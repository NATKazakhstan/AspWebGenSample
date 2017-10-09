<%@ Page Title="" Language="C#" MasterPageFile="~/IFrameSite.Master" AutoEventWireup="true" Inherits="Nat.Web.Controls.BaseMainPage" %>

<%@ Register Assembly="Nat.Web.Controls" Namespace="Nat.Web.Controls" TagPrefix="NatC" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="width: 100%; height: 100%">
        <asp:PlaceHolder ID="phUMAllways" runat="server" />
        <asp:PlaceHolder ID="ph" runat="server" />
        <asp:PlaceHolder ID="phInUP" runat="server" />
        <asp:PlaceHolder ID="phActions" runat="server" />
    </div>
    <NatC:LoaderCssScript ID="LoaderCssScript1" runat="server" />
</asp:Content>
<script runat="server" type="text/C#">
    protected override PlaceHolder PlaceHolder => ph;

    protected override PlaceHolder PlaceHolderInUP => phInUP;

    protected override PlaceHolder PlaceHolderInUpInternal => phUMAllways;

    protected override UpdatePanel UpdatePanelForActions => null;

    protected override PlaceHolder PlaceHolderForActions => phActions;

    protected override bool EmptyPage => true;

    protected override string GetRedirectUrl(string userControl)
    {
        return null;
    }
</script>
