<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="famcargoVerificacion_pago_CMA.View" %>

    <div class="container">

        <div class="row">
            <div class="col-md-6">
                <asp:Label ID="Label1" runat="server" Text="Cliente"></asp:Label>
                <asp:TextBox ID="txt_nombre_usuario" runat="server" ReadOnly="true" CssClass="form-control"></asp:TextBox>
            </div>
             <div class="col-md-6">
                <asp:Label ID="Label2" runat="server" Text="ID"></asp:Label>
                <asp:TextBox ID="txt_nit" runat="server" ReadOnly="true" CssClass="form-control" ></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <asp:Panel ID="Panel1" runat="server" Height="20px"></asp:Panel>
                <asp:Label ID="Label3" runat="server" Text="Número de Referencia"></asp:Label>
                <asp:TextBox ID="txt_ID" runat="server" ReadOnly="true" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-md-4">
                <asp:Panel ID="Panel3" runat="server" Height="20px"></asp:Panel>
                <asp:Label ID="Label4" runat="server" Text="Valor de la transacción"></asp:Label>
                <asp:TextBox ID="txt_saldo" ReadOnly="true" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-md-4">
                <asp:Panel ID="Panel4" runat="server" Height="20px"></asp:Panel>
                <asp:Label ID="Label5" runat="server" Text="Fecha"></asp:Label>
                <asp:TextBox ID="txt_fecha" runat="server" ReadOnly="true" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
    </div>

    <div class="container">
       <asp:Panel ID="Panel2" runat="server" Height="20px"></asp:Panel>
       <asp:GridView ID="GridView1" runat="server" CssClass="table table-striped" AutoGenerateColumns="false" CellPadding="4" ForeColor="#333333" GridLines="None">
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" Font-Names="verdana" Font-Size="8pt"/>
           <HeaderStyle BackColor="#005782" Font-Names="verdana" ForeColor="White" Font-Bold="true" HorizontalAlign="Center" Font-Size="Small" />
            <AlternatingRowStyle BackColor="White" />
           <Columns>
               <asp:TemplateField>
<%--                   <HeaderTemplate>
                       <asp:CheckBox ID="Chkheader" runat="server" onclick="HeaderCheckBoxClick(this);"/>
                   </HeaderTemplate>--%>
                   <ItemTemplate>
                       <asp:CheckBox ID="ChkEmpty" onclick="ChildCheckBoxClick(this);" runat="server" />
                   </ItemTemplate>
               </asp:TemplateField>
               <asp:BoundField DataField="bl" ControlStyle-CssClass="form-control" HeaderText="BL" ItemStyle-Font-Names="verdana" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" ControlStyle-Font-Size="10pt" ControlStyle-BorderStyle="Inset" ItemStyle-HorizontalAlign="Center" />
               <asp:BoundField DataField="contenedor" ControlStyle-CssClass="form-control" HeaderText="CONTENEDOR" ItemStyle-Font-Names="verdana" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" ControlStyle-Font-Size="10pt" ControlStyle-BorderStyle="Inset" ItemStyle-HorizontalAlign="Center"/>
               <asp:BoundField DataField="factura" ControlStyle-CssClass="form-control" HeaderText="FACTURA" ItemStyle-Font-Names="verdana" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" ControlStyle-Font-Size="10pt" ControlStyle-BorderStyle="Inset"  ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="concepto" ControlStyle-CssClass="form-control" HeaderText="CONCEPTO" ItemStyle-Font-Names="verdana" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" ControlStyle-Font-Size="10pt" ControlStyle-BorderStyle="Inset" ItemStyle-HorizontalAlign="Justify" />
               <asp:BoundField DataField="detalles" ControlStyle-CssClass="form-control" HeaderText="DETALLES" ItemStyle-Font-Names="verdana" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" ControlStyle-Font-Size="10pt" ControlStyle-BorderStyle="Inset" ItemStyle-HorizontalAlign="Justify"/>
               <asp:TemplateField HeaderText="VALOR OBLIGACION" ItemStyle-Font-Names="verdana" ItemStyle-Font-Size="10pt" ItemStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="White">
                <ItemTemplate>
                <asp:TextBox ID="Valor_pagado" runat="server" Text='<%# Eval("valor_pagado")%>' CssClass="form-control" Font-Size="9pt" Font-Names="verdana" ReadOnly="true" BackColor="White">
                </asp:TextBox>
                </ItemTemplate>
              </asp:TemplateField>
               <asp:TemplateField HeaderText="ABONO" ItemStyle-Font-Names="verdana" ItemStyle-Font-Size="8pt" ItemStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="White">
                <ItemTemplate>
                    <input id="Valor_digitado" runat="server" class="form-control" onchange="Sumatoria(this);" style="font-size:10px; background-color:white" value="0"  />
                    <%--<asp:TextBox ID="Valor_digitado" runat="server" Text='<%# Eval("Abono","{0:N2}")%>' CssClass="form-control" OnTextChanged="Valor_digitado_TextChanged"  Font-Size="9pt" Font-Names="verdana" BackColor="White" AutoPostBack="true"></asp:TextBox>--%>
                </ItemTemplate>
              </asp:TemplateField>
            </Columns>
       </asp:GridView>


        <div class="row">
            <div class ="col-md-3">
                <asp:Panel ID="Panel5" Height="15px" runat="server"></asp:Panel>
                <asp:Label ID="Label6" runat="server" Text="Valor seleccionado: "></asp:Label>
                 <asp:Panel ID="Panel7" Height="5px" runat="server"></asp:Panel>
                <asp:TextBox ID="txt_valor_seleccionado" runat="server"></asp:TextBox>
            </div>
           <div class ="col-md-3">
                <asp:Panel ID="Panel8" Height="15px" runat="server"></asp:Panel>
                <asp:Label ID="Label7" runat="server" Text="Diferencia: "></asp:Label>
               <asp:Panel ID="Panel9" Height="5px" runat="server"></asp:Panel>
                <asp:TextBox ID="txt_valor_restante" runat="server"></asp:TextBox>
            </div>
            <div class ="col-md-3">
                <asp:Panel ID="Panel6" Height="30px" runat="server"></asp:Panel>
                <asp:Button ID="Btn_actualizar" runat="server" CssClass="btn btn-primary" OnClick="Btn_actualizar_Click" Text="Actualizar información..." Width="200px" />
            </div>
            <div class ="col-md-3">
                <asp:Panel ID="Panel10" Height="30px" runat="server"></asp:Panel>
                <asp:Button ID="btnSalir" runat="server" CssClass="btn btn-primary" OnClick="btnSalir_Click" Text="Cerrar Pantalla..." Width="200px" />
            </div>
        </div>
   </div>

         <script type="text/javascript">

<%--             function HeaderCheckBoxClick(checkbox) {
                 var gridview = document.getElementById("<%=GridView1.ClientID%>");
                 var marcado = false;
                 var sum1 = 0;
                 var valor = 0;
                 var sum = 0;
                 var VBanco = 0;
                 var VBanco1 = 0;
                 const formateador = new Intl.NumberFormat('es-ES');

                 if (gridview.rows[0].cells[0].childNodes[1].checked)
                 {
                     marcado = true;
                 }
                 for (var i = 1; i < gridview.rows.length; i++)
                 {
                     gridview.rows[i].cells[0].childNodes[1].checked = marcado;
                     valor = gridview.rows[i].cells[6].childNodes[1].value;
                     sum = parseFloat(valor);
                     gridview.rows[i].cells[7].childNodes[1].value = sum;
                     sum1 = sum1 + sum;

                 }
                 sum1 = formateador.format(sum1);
                 document.getElementById("<%=txt_valor_seleccionado.ClientID%>").value = sum1;

                 if (sum1 > 0)
                 {
                     document.getElementById("<%=Btn_actualizar.ClientID%>").display = true;
                     
                 }
                 else
                 {
                     document.getElementById("<%=Btn_actualizar.ClientID%>").visible = false;
                 }
             }--%>

             function ChildCheckBoxClick(checkbox) {

                 var gridview = document.getElementById("<%=GridView1.ClientID%>");
                 var sum = 0;
                 var valor = 0;
                 var sum1 = 0;
                 var Vdigitado = 0;
                 var Vdigitado1 = 0;
                 var concepto;
                 var VBanco = 0;
                 var VBanco1 = 0;

                 for (var i = 1; i < gridview.rows.length; i++) {
                     concepto = gridview.rows[i].cells[4].childNodes[0].data;
                     if (concepto == "COSTO TRANSACCION") {
                         /*valor = gridview.rows[i].cells[6].childNodes[1].value.replace(',', '');*/
                         valor = gridview.rows[i].cells[6].childNodes[1].value;
                         if (typeof (valor) == "number") {
                             gridview.rows[i].cells[7].childNodes[1].value = valor;
                             sum = parseFloat(valor);
                         }
                         else {
                             sum = parseFloat(valor);
                             gridview.rows[i].cells[7].childNodes[1].value = sum;
                         }
                         gridview.rows[i].cells[0].childNodes[1].checked = true;
                         sum1 = sum1 + sum;
                     }
                     else {
                         if (gridview.rows[i].cells[0].childNodes[1].checked == true) {
                             valor = gridview.rows[i].cells[7].childNodes[1].value;
                             if (valor == "0,00") {
                                 valor = gridview.rows[i].cells[6].childNodes[1].value;

                                 if (valor.indexOf(",") === valor.length - 3) {
                                     valor = valor.replace(".", "").replace(",", ".");
                                 } else {
                                     valor = valor.replace(",", "");
                                 }
                                 gridview.rows[i].cells[7].childNodes[1].value = valor;
                                 sum = valor;
                             }
                             else {
                                 valor = gridview.rows[i].cells[6].childNodes[1].value;
                                 if (valor.indexOf(",") === valor.length - 3) {
                                     valor = valor.replace(".", "").replace(",", ".");
                                 } else {
                                     valor = valor.replace(",", "");
                                 }
                             }
                             Vdigitado = gridview.rows[i].cells[7].childNodes[1].value;
                             Vdigitado1 = Vdigitado;
                             if (Vdigitado1.indexOf(",") === Vdigitado1.length - 3) {
                                 Vdigitado1 = Vdigitado1.replace(".", "").replace(",", ".");
                             } else {
                                 Vdigitado1 = Vdigitado1.replace(",", "");
                             }

                             if (Vdigitado1 > valor) {
                                 gridview.rows[i].cells[0].childNodes[1].checked = false;
                                 gridview.rows[i].cells[7].childNodes[1].value = 0;
                                 window.alert("El valor del abono no puede ser superior al valor de la obligación")
                             }
                             else {
                                 if (Vdigitado1 == 0) {
                                     gridview.rows[i].cells[7].childNodes[1].value = sum;
                                 }
                                 else {
                                     Vdigitado = gridview.rows[i].cells[7].childNodes[1].value;
                                     Vdigitado1 = parseFloat(Vdigitado);
                                     sum = Vdigitado1;
                                 }
                                 sum1 = sum1 + sum;
                             }
                         }
                         else {
                             gridview.rows[i].cells[7].childNodes[1].value = "0,00";
                         }
                     }

                 }
                 var formattedSum1 = sum1;

                 // Asignar el valor formateado al campo de texto
                 document.getElementById("<%=txt_valor_seleccionado.ClientID%>").value = formattedSum1;
                 var VrestaBanco = document.getElementById("<%=txt_saldo.ClientID%>").value;

                 if (VrestaBanco.indexOf(",") === VrestaBanco.length - 3) {
                     VrestaBanco = VrestaBanco.replace(".", "").replace(",", ".");
                 } else {
                     VrestaBanco = VrestaBanco.replace(",", "");
                 }
                 var VrestaBanco1 = VrestaBanco;
                 var Diferencia = VrestaBanco1 - sum1;

                 document.getElementById("<%=txt_valor_restante.ClientID%>").value = Diferencia;
             }


                 function formatNumber(number) {
                     // Dividir el número en parte entera y decimal
                     var [integerPart, decimalPart] = number.toFixed(2).split('.');

                     // Añadir puntos como separadores de miles
                     integerPart = integerPart.replace(/\B(?=(\d{3})+(?!\d))/g, ',');

                     // Devolver el número formateado con la coma como separador decimal
                     return integerPart + ',' + decimalPart;
                 }

                 function Sumatoria(control) {
                     const formateador = new Intl.NumberFormat('es-ES');
                     var gridview = document.getElementById("<%=GridView1.ClientID%>");
                     var sum = 0;
                     var valor = 0;
                     var sum1 = 0;
                     var Vdigitado = 0;
                     var Vdigitado1 = 0;
                     var concepto;
                     var VBanco = 0;
                     var VBanco1 = 0;

                     for (var i = 1; i < gridview.rows.length; i++) {
                         if (gridview.rows[i].cells[0].childNodes[1].checked == true) {
                             valor = gridview.rows[i].cells[6].childNodes[1].value;
                             Vdigitado = gridview.rows[i].cells[7].childNodes[1].value;

                             if (Vdigitado > valor) {
                                 gridview.rows[i].cells[0].childNodes[1].checked = false;
                                 gridview.rows[i].cells[7].childNodes[1].value = 0;
                                 window.alert("El valor del abono no puede ser superior al valor de la obligación")
                             }
                             else {

                                 sum = Vdigitado;
                                 sum1 = parseFloat(sum1) + parseFloat(sum);
                                
                             }
                         }
                     }

                     document.getElementById("<%=txt_valor_seleccionado.ClientID%>").value = formateador.format(sum1);
                 }

             function closeOpenedWindow() {
                 openedWindow.close();
             }
         </script>


    <div class="container">

      <!-- Modal -->
      <div class="modal" id="alerta1" role="dialog">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">NOTIFICACIÓN</h4>
            </div>
            <div class="modal-body">
                 <asp:Label ID="lblMensaje2" runat="server" Text="" Font-Size="9pt" ></asp:Label>
                <asp:Label ID="lblMensaje1" runat="server" Text="" Font-Size="9pt" ></asp:Label>
            </div>
              <div class="modal-footer">
                  <asp:Button ID="BTN_cerrar" runat="server" CssClass="btn btn-info" OnClick="BTN_cerrar_Click" Text="Cerrar"/>
              </div>

          </div>
        </div>
      </div>
    </div>

