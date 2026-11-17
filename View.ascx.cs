/*
' Copyright (c) 2024  Christoc.com
'  All rights reserved.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
' TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
' THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
' CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
' DEALINGS IN THE SOFTWARE.
' 
*/

using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Modules.Actions;
using DotNetNuke.Security;
using DotNetNuke.Services.Exceptions;
using DotNetNuke.Services.Localization;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using DotNetNuke.Web.Api;
using System.Web.UI;
using System.Globalization;
using System.Threading;

namespace famcargoVerificacion_pago_CMA
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from Verificacion_pago_CMAModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------



    public partial class View : Verificacion_pago_CMAModuleBase, IActionable
    {
        string CadConeccion = "";
        SqlConnection conn = new SqlConnection();
        DataTable DtDatos = new DataTable();
        DataTable detalle = new DataTable();
        string nit = "";

        protected override void FrameworkInitialize()

        {

            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture("es-CO");

            Thread.CurrentThread.CurrentUICulture = new CultureInfo("es-CO");

            base.FrameworkInitialize();

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                nit = DotNetNuke.Entities.Users.UserController.Instance.GetCurrentUserInfo().Profile.GetPropertyValue("NIT").ToString();
                Session["nituser"] = nit;


                if (Settings.Contains("SetConnection"))
                {
                    CadConeccion = Settings["SetConnection"].ToString();
                    conn = new SqlConnection(CadConeccion);
                }
                else
                {
                    CadConeccion = ConfigurationManager.ConnectionStrings["BD_CMA_CGM"].ConnectionString;
                    conn = new SqlConnection(CadConeccion);
                }

                if (!IsPostBack)
                {
                    //string RecibeID = Request.QueryString["ID"];
                    //if (RecibeID != "" && RecibeID != null)
                    //{
                        //txt_ID.Text = RecibeID;
                        //DtDatos = GetData("Exec SP_TRAER_DATOS_VERIFICACION_PAGOS '" + RecibeID + "'");
                        DtDatos = GetData("Exec SP_TRAER_DATOS_VERIFICACION_PAGOS '0001290900245'");
                        nit = "0001290900";
                        if (DtDatos.Rows.Count > 0)
                        {
                            DataRow rg = DtDatos.Rows[0];
                            string nitllega = rg["nit_tercero"].ToString();

                            if (nit == nitllega)
                            {
                                txt_ID.Text = rg["Reference"].ToString();
                                txt_nit.Text = rg["nit_tercero"].ToString();
                                txt_fecha.Text = rg["updated"].ToString();
                                txt_nombre_usuario.Text = rg["nombre_cliente"].ToString();
                                decimal wvalor = Convert.ToDecimal(rg["Total_pagado"]);
                                txt_saldo.Text = wvalor.ToString();

                                GridView1.DataSource = DtDatos;
                                GridView1.DataBind();
                            }
                            else
                            {
                                lblMensaje2.Text = "Estimado usuario, usted no se encuentra autorizado para ver esta información";
                                lblMensaje2.ForeColor = System.Drawing.Color.FromName("#cc0000");
                                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta1", "$('#alerta1').modal({backdrop: 'static', keyboard: false});", true);
                            }

                        }
                        else
                        {
                            lblMensaje2.Text = "Estimado usuario, no se encontró información con estos requerimientos";
                            lblMensaje2.ForeColor = System.Drawing.Color.FromName("#cc0000");
                            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta1", "$('#alerta1').modal({backdrop: 'static', keyboard: false});", true);
                        }
                    //}

                }
            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }

        private DataTable GetData(string query)
        {

            //string sConnectionString = Settings["connectionString"].ToString();
            //conn.ConnectionString = ConfigurationManager.ConnectionStrings[string.Format("{0}", sConnectionString)].ConnectionString;

            string conecct = CadConeccion;
            conn.ConnectionString = conecct;
            string sqlSelectCommand = query;

            //SqlDataAdapter adapter = new SqlDataAdapter(sqlSelectCommand, ConfigurationManager.ConnectionStrings[empresa + "Connection"].ConnectionString);

            SqlDataAdapter adapter = new SqlDataAdapter(sqlSelectCommand, conn.ConnectionString);
            DataTable DtConsulta = new DataTable();
            adapter.Fill(DtConsulta);
            return DtConsulta;

        }

        public ModuleActionCollection ModuleActions
        {
            get
            {
                var actions = new ModuleActionCollection
                    {
                        {
                            GetNextActionID(), Localization.GetString("EditModule", LocalResourceFile), "", "", "",
                            EditUrl(), false, SecurityAccessLevel.Edit, true, false
                        }
                    };
                return actions;
            }
        }

        protected void Btn_actualizar_Click(object sender, EventArgs e)
        {
            if (txt_valor_seleccionado.Text != "")
            {
                decimal Vdigitado = Convert.ToDecimal(txt_valor_seleccionado.Text);
                string valor = txt_saldo.Text.Replace(',', '.');
                decimal VBanco = Convert.ToDecimal(txt_saldo.Text);

                if (VBanco == Vdigitado)
                {
                    try
                    {
                        CadConeccion = ConfigurationManager.ConnectionStrings["BD_CMA_CGM"].ConnectionString;
                        string conecct = CadConeccion;
                        conn.ConnectionString = conecct;
                        conn.Open();

                        string pais = "";
                        if (Settings.Contains("SetPais"))
                        {
                            pais = Settings["SetPais"].ToString();
                        }

                        using (SqlTransaction tr = conn.BeginTransaction(IsolationLevel.Serializable))
                        {
                            try
                            {
                                foreach (GridViewRow row in GridView1.Rows)
                                {
                                    System.Web.UI.WebControls.CheckBox chk = (System.Web.UI.WebControls.CheckBox)row.FindControl("ChkEmpty");
                                    if (chk.Checked == true)
                                    {
                                        string sqlupdate1;
                                        string factura = row.Cells[3].Text.Replace("&nbsp;", "");

                                        string Concepto = row.Cells[4].Text;
                                        string bl = row.Cells[1].Text;
                                        System.Web.UI.WebControls.TextBox Vinicial = (System.Web.UI.WebControls.TextBox)row.FindControl("Valor_pagado");
                                        string dato = Vinicial.Text.Trim();
                                        decimal valorInicial = Convert.ToDecimal(dato, CultureInfo.InvariantCulture);
                                        string valorInicialFormateado = valorInicial.ToString("F2", CultureInfo.InvariantCulture);
                                        System.Web.UI.WebControls.TextBox Vfinal = (System.Web.UI.WebControls.TextBox)row.FindControl("Valor_digitado");
                                        string datofinal = Vfinal.Text.Replace(",", ".").Trim();
                                        decimal valorFinal = Convert.ToDecimal(datofinal, CultureInfo.InvariantCulture);
                                        string valorFinalFormateado = valorFinal.ToString("F2", CultureInfo.InvariantCulture);
                                        string fecha1 = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString().PadLeft(2, '0') + DateTime.Now.Day.ToString().PadLeft(2, '0') + " " + DateTime.Now.Hour.ToString().PadLeft(2, '0') + ":" + DateTime.Now.Minute.ToString().PadLeft(2, '0');
                                        sqlupdate1 = "EXEC Sp_Insertar_registro_pagos_parciales '" + txt_nombre_usuario.Text + "','" + txt_nit.Text + "'," + valorFinalFormateado.ToString() + "," + valorFinalFormateado.ToString() + ",'" + txt_ID.Text + "','" + fecha1 + "','" + factura + "','" + Concepto + "'";
                                        sqlupdate1 = sqlupdate1.Replace("&nbsp;", "");
                                        SqlCommand Sqlcommand1 = new SqlCommand(sqlupdate1, conn);
                                        Sqlcommand1.Transaction = tr;
                                        Sqlcommand1.ExecuteNonQuery();
                                        


                                    }
                                }

                                tr.Commit();

                                string sqlupdate;
                                sqlupdate = "EXEC Actualizar_pagos_abonos '" + txt_ID.Text.Trim() + "'";
                                SqlCommand Sqlcommand = new SqlCommand(sqlupdate, conn);
                                Sqlcommand.Transaction = tr;
                                Sqlcommand.ExecuteNonQuery();
                                conn.Close();

                                lblMensaje1.Text = "Actualización realizada éxitosamente";
                                lblMensaje1.ForeColor = System.Drawing.Color.FromName("#009933");
                                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta1", "$('#alerta1').modal({backdrop: 'static', keyboard: false});", true);
                                //

                            }
                            catch (Exception ex)
                            {
                                string error = ex.Message;
                                tr.Rollback();
                                conn.Close();
                            }

                        }
                    }
                    catch (Exception ex)
                    {
                        string error = ex.Message;
                        conn.Close();
                    }

                }
                else
                {
                    lblMensaje2.Text = "ERROR , El valor del banco no coincide con la sumatoria de los valores seleccionados";
                    lblMensaje2.ForeColor = System.Drawing.Color.FromName("#cc0000");
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta1", "$('#alerta1').modal({backdrop: 'static', keyboard: false});", true);
                }
            }
        }

        protected void BTN_cerrar_Click(object sender, EventArgs e)
        {
            string scrptbatch = @"function closeRadWindow() {
            var radwindow = $find('<%=alerta1.ClientID %>');
            radwindow.close();
            }";

            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "closeRadWindow()", scrptbatch, true);
        }

        protected void Valor_digitado_TextChanged(object sender, EventArgs e)
        {
            TextBox control = (TextBox)sender;
            GridView grid = ((GridView)((System.Web.UI.WebControls.TextBox)sender).NamingContainer.NamingContainer);
            decimal subtotal = 0;
            if(control.Text != "")
            { 
                foreach (GridViewRow row in grid.Rows)
                {
                    TextBox valinicial = (TextBox)row.FindControl("Valor_pagado");
                    TextBox valdigitado = (TextBox)row.FindControl("Valor_digitado");

                    decimal wvalini = Convert.ToDecimal(valinicial.Text);
                    decimal wvaldig = Convert.ToDecimal(valdigitado.Text);

                    if (wvaldig > wvalini)
                    {
                        lblMensaje2.Text = "ERROR , El valor del abono no puede ser mayor al de la obligacion !!";
                        lblMensaje2.ForeColor = System.Drawing.Color.FromName("#cc0000");
                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta1", "$('#alerta1').modal({backdrop: 'static', keyboard: false});", true);
                        break;
                    }
                    else
                    {
                        subtotal = subtotal + wvaldig;
                    }
                }

                txt_valor_seleccionado.Text = subtotal.ToString();
                string valor = txt_saldo.Text.Replace(',', '.');

                decimal wval1 = Convert.ToDecimal(valor);
                decimal val2 = wval1 - subtotal;

                txt_valor_restante.Text = val2.ToString();

            }
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            if(txt_valor_restante.Text == "0")
            {
                
                string scrptbatch = @"function closeOpenedWindow() {
                    history.back();
                    }";

                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "closeOpenedWindow()", scrptbatch, true);
            }
            
        }
        
    }
}