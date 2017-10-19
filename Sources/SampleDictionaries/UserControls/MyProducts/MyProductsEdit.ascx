<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MyProductsEdit.ascx.cs" Inherits="SampleDictionaries.UserControls.MyProductsEdit" %>

<%@ Import Namespace="Nat.Web.Tools" %>
<%@ Import Namespace="Nat.Web.Tools.Security" %>
<%@ Import Namespace="SampleDictionaries.Security" %>
<%@ Import Namespace="SampleDictionaries.Properties" %>
<%@ Register Assembly="SampleDictionaries" Namespace="SampleDictionaries" TagPrefix="cc1" %>
<%@ Register Assembly="SampleDictionaries" Namespace="SampleDictionaries.UserControls" TagPrefix="NatC" %>
<%@ Register Assembly="Nat.Web.Controls" Namespace="Nat.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Nat.Web.Controls" Namespace="Nat.Web.Controls.GenerationClasses" TagPrefix="cc1" %>
<%@ Register Assembly="Nat.Web.Controls" Namespace="Nat.Web.Controls.GenerationClasses" TagPrefix="NatC" %>
<%@ Register Assembly="Nat.Web.Controls" Namespace="Nat.Web.Controls.GenerationClasses.Data" TagPrefix="NatC" %>
<%@ Register Assembly="Nat.Web.Controls" Namespace="Nat.Web.Controls.DateTimeControls" TagPrefix="cc1" %>
<%@ Register Assembly="Nat.Web.Controls" Namespace="Nat.Web.Controls.Preview" TagPrefix="NatC" %>
<%@ Register Assembly="Nat.Web.Controls" Namespace="Nat.Web.Controls.SelectValues" TagPrefix="NatC" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>



<%

    if (false)

    {
%>
        <cc1:MyProductsNavigatorControl ID="NavigatorControl" runat=server />
<%  }%>

<cc1:MyProductsJournalDataSource runat="server" ID="source" OnSelecting="Source_Selecting" />
<NatC:LinqDataSourceExt ID="lds" runat="server"
    ContextTypeName="SampleDictionaries.DBDataContext" TableName="MyProducts" 
    EnableDelete="True" EnableUpdate="True" Where="id == @id" 
    EnableInsert="True" oninserted="lds_Inserted" onupdated="lds_Updated" OnContextCreating="lds_ContextCreating" OnContextDisposing="lds_ContextDisposing"
    onselecting="lds_Selecting" onUpdating="lds_Updating" onInserting="lds_Inserting">
    <WhereParameters>
        <asp:ControlParameter ControlID="hfid" DefaultValue="0" Name="id" PropertyName="Value" Type="Int64" />
    </WhereParameters>
</NatC:LinqDataSourceExt>
<NatC:LinqDataSourceExt ID="ldsChanges" runat="server" 
    ContextTypeName="SampleDictionaries.DBDataContext" TableName="MyProducts" 
    EnableDelete="True" EnableUpdate="True" Where="id == @id" 
    EnableInsert="True" oninserted="lds_Inserted" onupdated="lds_Updated" OnContextCreating="lds_ContextCreating" OnContextDisposing="lds_ContextDisposing"
    onselecting="ldsChanges_Selecting" onUpdating="ldsChanges_Updating" onInserting="ldsChanges_Inserting">
    <WhereParameters>
        <asp:ControlParameter ControlID="hfid" DefaultValue="0" Name="id" PropertyName="Value" Type="Int64" />
    </WhereParameters>
</NatC:LinqDataSourceExt>

<script>
    var resizeDialogWindow = function(w) {
        if (w.maximized) return;
        w.setWidth($(window).width() / 4 * 3);
        w.setHeight($(window).height() / 4 * 3);
        w.setPosition($(window).width() / 8, $(window).height() / 8);
    };

    $(function() {
        $(window).resize(function() {
            resizeDialogWindow(<%= Window.ClientID %>);
            resizeDialogWindow(<%= ModalWindow.ClientID %>);
        });
    });
</script>
<ext:Window
    ID="ModalWindow"
    runat="server"
    Icon="Table"
    Modal="false"
    Width="750"
    Height="590"
    AutoRender=false
    Hidden="true"
    Maximized="True"
    Layout="Fit">
    <Loader Url="" Mode="Frame" AutoLoad="False" meta:resourcekey="Loader">
        <LoadMask ShowMask="True"></LoadMask>
    </Loader>
    <Listeners>
        <Show Handler="item.loader.load()"></Show>
        <Restore Fn="resizeDialogWindow"></Restore>
    </Listeners>
</ext:Window>
<ext:Window
    ID="Window"
    runat="server"
    Icon="Table"
    Width="750"
    Height="590"
    AutoRender=false
    Collapsible=true
    Maximizable=true
    Maximized="True"
    Hidden="true"
    Layout="Fit">
    <Loader Url="" Mode="Frame" AutoLoad="False" meta:resourcekey="Loader">
        <LoadMask ShowMask="True"></LoadMask>
    </Loader>
    <Listeners>
        <Show Handler=""></Show>
        <Expand Handler="resizeDialogWindow(item); item.loader.load();"></Expand>
        <Restore Fn="resizeDialogWindow"></Restore>
    </Listeners>
</ext:Window>
<ext:Viewport ID="vp" runat="server" Layout="border">
    <Items>
<ext:FormPanel runat="server" ID="FormPanelMyProducts"
    Title="Мои товары"
    DefaultButton="SaveButton"
    Region="Center"
    AutoScroll="True"
    meta:resourcekey="FormPanelMyProducts">
    <Items>
        <ext:Hidden runat="server" ID="rowVersionHiddenField"/>
        <ext:Hidden runat="server" ID="hfSessionKey"/>
        <ext:Hidden ID="hfid" runat="server" />
        
        
        
        
             <ext:Container runat="server" ID="containerName" Layout="Fit">
                <Items>
                    <ext:TextField ID="tbName" runat="server"
                        meta:resourcekey="ColumnName"
                        Name="Name"
                        FieldLabel="Наименование"
                        LabelWidth="200"
                        Width="500"
                        ValidationGroup="MyProducts"
                        PreserveIndicatorIcon="False"
                        Padding="5"
                        AllowBlank="false"
                        ReadOnly='<%# IsRead %>'
                        AutoDataBind="True"
                        MaxLength="200" EnforceMaxLength="True">
                        <RemoteValidation OnValidation="RemoteValidationFields" />
                    </ext:TextField>
                </Items>
             </ext:Container>
        
        
        
        
             <ext:Container runat="server" ID="containerCreationDate" Layout="HBoxLayout">
                <Items>
                    <ext:DateField ID="dpCreationDate" runat="server" 
                        meta:resourcekey="ColumnCreationDate"
                        Name="CreationDate"
                        FieldLabel="Дата создания"
                        LabelWidth="200"
                        Width=""
                        ValidationGroup="MyProducts"
                        PreserveIndicatorIcon="False"
                        Padding="5"
                        AllowBlank="false"
                        ReadOnly='<%# IsRead %>'
                        AutoDataBind="True"
                        Format="dd.MM.yyyy">
                        <RemoteValidation OnValidation="RemoteValidationFields" />
                    </ext:DateField>
                </Items>
             </ext:Container>
        
        
        
        
             <ext:Container runat="server" ID="containerPrice" Layout="Fit">
                <Items>
                    <ext:NumberField ID="tbPrice" runat="server"
                        meta:resourcekey="ColumnPrice"
                        Name="Price"
                        FieldLabel="Цена"
                        LabelWidth="200"
                        Width="500"
                        ValidationGroup="MyProducts"
                        PreserveIndicatorIcon="False"
                        Padding="5"
                        AllowBlank="false"
                        ReadOnly='<%# IsRead %>'
                        AutoDataBind="True"
                        MaxLength="8" EnforceMaxLength="True"
                        DecimalPrecision="2">
                        <RemoteValidation OnValidation="RemoteValidationFields" />
                    </ext:NumberField>
                </Items>
             </ext:Container>
        
        
        
        
             <ext:Container runat="server" ID="containerAmount" Layout="Fit">
                <Items>
                    <ext:NumberField ID="tbAmount" runat="server"
                        meta:resourcekey="ColumnAmount"
                        Name="Amount"
                        FieldLabel="Доступно"
                        LabelWidth="200"
                        Width="500"
                        ValidationGroup="MyProducts"
                        PreserveIndicatorIcon="False"
                        Padding="5"
                        AllowBlank="false"
                        ReadOnly="False"
                        
                        Enabled="False"
                        MaxLength="8" EnforceMaxLength="True"
                        DecimalPrecision="2">
                        <RemoteValidation OnValidation="RemoteValidationFields" />
                    </ext:NumberField>
                </Items>
             </ext:Container>
    </Items>
    <BottomBar>
        <ext:Toolbar runat="server" meta:resourcekey="bottomToolbar">
            <Items>
                <ext:Button runat="server" ID="SaveButton"
                    Text="Save"
                    Icon="PageSave"
                    meta:resourcekey="SaveButton">
                    <DirectEvents>
                        <Click Before="return (#{FormPanelMyProducts}.isValid()) == 1;" OnEvent="SaveData">
                            <EventMask ShowMask="True"></EventMask>
                        </Click>
                    </DirectEvents>
                </ext:Button>
            </Items>
        </ext:Toolbar>
    </BottomBar>
    <Listeners>
        <ValidityChange Handler="#{SaveButton}.setDisabled(!valid);" />
    </Listeners>
</ext:FormPanel>
    </Items>
</ext:Viewport>

<br />
<asp:PlaceHolder runat="server" ID="phControls" />
<cc1:ExtenderAjaxControl runat="server" ID="extenderAjaxControl" />