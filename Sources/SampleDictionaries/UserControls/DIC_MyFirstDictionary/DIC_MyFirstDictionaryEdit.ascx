<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DIC_MyFirstDictionaryEdit.ascx.cs" Inherits="SampleDictionaries.UserControls.DIC_MyFirstDictionaryEdit" %>

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
        <cc1:DIC_MyFirstDictionaryNavigatorControl ID="NavigatorControl" runat=server />
<%  }%>

<cc1:DIC_MyFirstDictionaryJournalDataSource runat="server" ID="source" OnSelecting="Source_Selecting" />
<NatC:LinqDataSourceExt ID="lds" runat="server"
    ContextTypeName="SampleDictionaries.DBDataContext" TableName="DIC_MyFirstDictionaries" 
    EnableDelete="True" EnableUpdate="True" Where="id == @id" 
    EnableInsert="True" oninserted="lds_Inserted" onupdated="lds_Updated" OnContextCreating="lds_ContextCreating" OnContextDisposing="lds_ContextDisposing"
    onselecting="lds_Selecting" onUpdating="lds_Updating" onInserting="lds_Inserting">
    <WhereParameters>
        <asp:ControlParameter ControlID="hfid" DefaultValue="0" Name="id" PropertyName="Value" Type="Int64" />
    </WhereParameters>
</NatC:LinqDataSourceExt>
<NatC:LinqDataSourceExt ID="ldsChanges" runat="server" 
    ContextTypeName="SampleDictionaries.DBDataContext" TableName="DIC_MyFirstDictionaries" 
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
<ext:FormPanel runat="server" ID="FormPanelDIC_MyFirstDictionary"
    Title="My First Dictionary"
    DefaultButton="SaveButton"
    Region="Center"
    AutoScroll="True"
    meta:resourcekey="FormPanelDIC_MyFirstDictionary">
    <Items>
        <ext:Hidden runat="server" ID="rowVersionHiddenField"/>
        <ext:Hidden runat="server" ID="hfSessionKey"/>
        <ext:Hidden ID="hfid" runat="server" />
        
        
        
        
             <ext:Container runat="server" ID="containerCode" Layout="Fit">
                <Items>
                    <ext:TextField ID="tbCode" runat="server"
                        meta:resourcekey="ColumnCode"
                        Name="Code"
                        FieldLabel="System code"
                        LabelWidth="200"
                        Width="500"
                        ValidationGroup="DIC_MyFirstDictionary"
                        PreserveIndicatorIcon="False"
                        Padding="5"
                        AllowBlank="false"
                        ReadOnly='<%# IsRead %>'
                        AutoDataBind="True"
                        MaxLength="4" EnforceMaxLength="True">
                        <RemoteValidation OnValidation="RemoteValidationFields" />
                    </ext:TextField>
                </Items>
             </ext:Container>
        
        
        
        
             <ext:Container runat="server" ID="containerName" Layout="Fit">
                <Items>
                    <ext:TextField ID="tbName" runat="server"
                        meta:resourcekey="ColumnName"
                        Name="Name"
                        FieldLabel="Name"
                        LabelWidth="200"
                        Width="500"
                        ValidationGroup="DIC_MyFirstDictionary"
                        PreserveIndicatorIcon="False"
                        Padding="5"
                        AllowBlank="false"
                        ReadOnly='<%# IsRead %>'
                        AutoDataBind="True"
                        MaxLength="255" EnforceMaxLength="True">
                        <RemoteValidation OnValidation="RemoteValidationFields" />
                    </ext:TextField>
                </Items>
             </ext:Container>
        
        
        
        
             <ext:Container runat="server" ID="containerDateStart" Layout="HBoxLayout">
                <Items>
                    <ext:DateField ID="dpDateStart" runat="server" 
                        meta:resourcekey="ColumnDateStart"
                        Name="DateStart"
                        FieldLabel="Date time Start"
                        LabelWidth="200"
                        Width=""
                        ValidationGroup="DIC_MyFirstDictionary"
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
        
        
        
        
             <ext:Container runat="server" ID="containerDateEnd" Layout="HBoxLayout">
                <Items>
                    <ext:DateField ID="dpDateEnd" runat="server" 
                        meta:resourcekey="ColumnDateEnd"
                        Name="DateEnd"
                        FieldLabel="Date time End"
                        LabelWidth="200"
                        Width=""
                        ValidationGroup="DIC_MyFirstDictionary"
                        PreserveIndicatorIcon="False"
                        Padding="5"
                        ReadOnly='<%# IsRead %>'
                        AutoDataBind="True"
                        Format="dd.MM.yyyy">
                        <RemoteValidation OnValidation="RemoteValidationFields" />
                    </ext:DateField>
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
                        <Click Before="return (#{FormPanelDIC_MyFirstDictionary}.isValid()) == 1;" OnEvent="SaveData">
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