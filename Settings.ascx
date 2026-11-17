<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="famcargoVerificacion_pago_CMA.Settings" %>


<!-- uncomment the code below to start using the DNN Form pattern to create and update settings -->
<%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>

	<h2 id="dnnSitePanel-BasicSettings" class="dnnFormSectionHead"><a href="" class="dnnSectionExpanded"><%=LocalizeString("BasicSettings")%></a></h2>
	<fieldset>
        <div class="dnnFormItem">
            <dnn:Label ID="lblConnection" runat="server" /> 
             <asp:TextBox ID="txtConnection" runat="server" />
        </div>
        <div class="dnnFormItem">
            <dnn:Label ID="lblPais" runat="server" /> 
             <asp:TextBox ID="txtpais" runat="server" />
        </div>
      <%--  <div class="dnnFormItem">
            <dnn:label ID="lblNITEmpresa" runat="server" />
            <asp:TextBox ID="txtNITEmpresa" runat="server" />
        </div>
        <div class="dnnFormItem">
            <dnn:label ID="lblPasswordBD" runat="server" />
            <asp:TextBox ID="txtPasswordBD" runat="server" />
        </div>--%>
    </fieldset>