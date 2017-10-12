<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DIC_MySecondDictionaryEdit.ascx.cs" Inherits="SampleDictionaries.UserControls.DIC_MySecondDictionaryEdit" %>

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


<%@ Register Assembly="SampleDictionaries" Namespace="SampleDictionaries" TagPrefix="cc1" %>



<%

    if (false)

    {
%>
        <cc1:DIC_MySecondDictionaryNavigatorControl ID="NavigatorControl" runat=server />
<%  }%>

<cc1:DIC_MySecondDictionaryJournalDataSource runat="server" ID="source" OnSelecting="Source_Selecting" />
<NatC:LinqDataSourceExt ID="lds" runat="server"
    ContextTypeName="SampleDictionaries.DBDataContext" TableName="DIC_MySecondDictionaries" 
    EnableDelete="True" EnableUpdate="True" Where="id == @id" 
    EnableInsert="True" oninserted="lds_Inserted" onupdated="lds_Updated" OnContextCreating="lds_ContextCreating" OnContextDisposing="lds_ContextDisposing"
    onselecting="lds_Selecting" onUpdating="lds_Updating" onInserting="lds_Inserting">
    <WhereParameters>
        <asp:ControlParameter ControlID="hfid" DefaultValue="0" Name="id" PropertyName="Value" Type="Int64" />
    </WhereParameters>
</NatC:LinqDataSourceExt>
<NatC:LinqDataSourceExt ID="ldsChanges" runat="server" 
    ContextTypeName="SampleDictionaries.DBDataContext" TableName="DIC_MySecondDictionaries" 
    EnableDelete="True" EnableUpdate="True" Where="id == @id" 
    EnableInsert="True" oninserted="lds_Inserted" onupdated="lds_Updated" OnContextCreating="lds_ContextCreating" OnContextDisposing="lds_ContextDisposing"
    onselecting="ldsChanges_Selecting" onUpdating="ldsChanges_Updating" onInserting="ldsChanges_Inserting">
    <WhereParameters>
        <asp:ControlParameter ControlID="hfid" DefaultValue="0" Name="id" PropertyName="Value" Type="Int64" />
    </WhereParameters>
</NatC:LinqDataSourceExt>

<cc1:DIC_MyFirstDictionaryJournalDataSource runat="server" ID="jdsrefFirstDictionary" 
OnSelecting="jdsrefFirstDictionary_Selecting" AllowSelectOnlyNames=true SelectForAddType="SampleDictionaries.DIC_MySecondDictionary" />

<ext:Store runat="server" id="Store_refFirstDictionary" AutoLoad="False">
    <Proxy>
        <ext:AjaxProxy Url="/AutoCompleteHandler.ashx">
            <ExtraParams>
                <ext:Parameter Name="dataSourceType" Value="SampleDictionaries.DIC_MyFirstDictionaryJournalDataSourceView"/>
                <ext:Parameter Name="isKz" Value='<%# LocalizationHelper.IsCultureKZ %>' AutoDataBind="True"/>
            </ExtraParams>
            <ActionMethods Read="POST" />
            <Reader>
                <ext:JsonReader Root="Data" TotalProperty="Total" IDProperty="jReader" />
            </Reader>
        </ext:AjaxProxy>
    </Proxy>
    <Model>
        <ext:Model runat="server" IDProperty="id">
            <Fields>
                <ext:ModelField Name="id" Type="Int"></ext:ModelField>
                <ext:ModelField Name="RowName" Type="String"></ext:ModelField>
                <ext:ModelField Name="AdditionalValues" Type="String"></ext:ModelField>
            </Fields>
        </ext:Model>
    </Model>
    <Listeners>
        <BeforeLoad Handler="SetLookupParameters_refFirstDictionary(this);"></BeforeLoad>
    </Listeners>
</ext:Store>
<ext:XScript runat="server">
<script type="text/javascript">
    function SetLookupParameters_refFirstDictionary(store) {
        ReadExtNetAdditionalFields(#{lookuprefFirstDictionaryAddFields});
        var extraParams = store.getProxy().extraParams;
        extraParams.parameters = GetExtNetLookupFilters(#{lookuprefFirstDictionaryFilters}) 
            + GetExtNetLookupSelectParameters(#{lookuprefFirstDictionaryAddFields});
        return '';
    }

    var lookuprefFirstDictionaryClick = function (el, trigger, tag, auto) {            
        var lookupAddFields = #{lookuprefFirstDictionaryAddFields};
        var store = el.getStore();
        switch(tag) {
            case "open":
                var w = #{refFirstDictionaryModalWindow};
                w.editor = el;
                w.autoComplete = auto;
                valueID = el.getValue();
                ReadExtNetAdditionalFields(lookupAddFields);
                var newUrl = '/EmptyPage.aspx/data/DIC_MyFirstDictionaryJournal/Select?mode=none&viewmode=none&__SFAddType=SampleDictionaries.DIC_MySecondDictionary'
                    + GetExtNetLookupFilters(#{lookuprefFirstDictionaryFilters})
                    + GetExtNetLookupSelectParameters(lookupAddFields);

                var urlChanged = false;
                if (w.loader.url != newUrl) {
                    w.loader.url = newUrl;
                    urlChanged = true;
                }

                w.show();

                if (urlChanged){
                    w.loader.load();
                    var frame = w.getFrame();

                    // todo: add auto select in journal
                    frame.refDIC_MyFirstDictionary = valueID == null ? null : valueID;
                    frame.selectedRecords = valueID == null ? [] : [store.getById(valueID)];
                    if (valueID != null) frame.tryLoadPage = true;
                    frame.addSelectedValues = function(record) {
                        w.hide();
                        var newValue = record.id;
                        store.add(record);
                        el.setValue(newValue);
                        ChangeExtNetLookupValue(store, newValue, lookupAddFields); // todo: check. May be call twice
                    };

                    frame.removeSelectedValues = function(record) {
                        el.removeByValue(record.id);
                        el.clearValue();
                        NullValuesExtNetAdditionalFields(lookupAddFields);
                    };
                } else {

                    // todo: use rows in journal, think what to do when record not exists in first 10 records.
                    var frame = w.getFrame();
                    frame.selectedRecords = valueID == null ? [] : [store.getById(valueID)];
                    if (valueID != null) frame.tryLoadPage = true;
                    if (frame.selectRecords != null)
                        frame.selectRecords(frame.selectedRecords);
                }

                break;
            case "remove":
                el.removeByValue(el.getValue());
                el.clearValue();
                NullValuesExtNetAdditionalFields(lookupAddFields);
                break;
        }
    };
    </script>
</ext:XScript>
<ext:Window
    ID="refFirstDictionaryModalWindow"
    runat="server"
    Icon="Table"
    Modal="False"
    Width="800"
    Height="600"
    Maximized="True"
    AutoRender=false
    Hidden="true"
    Layout="Fit"
    meta:resourcekey="refFirstDictionaryModalWindow">
    <Loader Url="" Mode="Frame" AutoLoad="False" meta:resourcekey="Loader">
        <LoadMask ShowMask="True"></LoadMask>
    </Loader>
    <Listeners>
    </Listeners>
</ext:Window>
<ext:Store runat="server" id="Store_BoolValue">
    <Model>
        <ext:Model runat="server" IDProperty="Key">
            <Fields>
                <ext:ModelField Name="Key" Type="Boolean"></ext:ModelField>
                <ext:ModelField Name="Value" Type="String"></ext:ModelField>
            </Fields>
        </ext:Model>
    </Model>
</ext:Store>

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
<ext:FormPanel runat="server" ID="FormPanelDIC_MySecondDictionary"
    Title="My Second Dictionary"
    DefaultButton="SaveButton"
    Region="Center"
    AutoScroll="True"
    meta:resourcekey="FormPanelDIC_MySecondDictionary">
    <Items>
        <ext:Hidden runat="server" ID="rowVersionHiddenField"/>
        <ext:Hidden runat="server" ID="hfSessionKey"/>
        <ext:Hidden ID="hfid" runat="server" />
        
        
        
        
             <ext:Container runat="server" ID="containerName" Layout="Fit">
                <Items>
                    <ext:TextField ID="tbName" runat="server"
                        meta:resourcekey="ColumnName"
                        Name="Name"
                        FieldLabel="Name"
                        LabelWidth="200"
                        Width="500"
                        ValidationGroup="DIC_MySecondDictionary"
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
        
        
        
        
             <ext:Container runat="server" ID="containerrefFirstDictionary" Layout="Fit">
                <Items>
                    <ext:ComboBox ID="lookuprefFirstDictionary" runat="server"
                        meta:resourcekey="ColumnrefFirstDictionary"
                        Name="refFirstDictionary"
                        FieldLabel="First Dictionary Value"
                        LabelWidth="200"
                        Width="500"
                        ValidationGroup="DIC_MySecondDictionary"
                        PreserveIndicatorIcon="False"
                        Padding="5"
                        AllowBlank="false"
                        ReadOnly='<%# IsRead %>'
                        AutoDataBind="True"
                        DisplayField="RowName"
                        ValueField="id"
                        QueryParam="prefixText"
                        ForceSelection="true"
                        HideBaseTrigger="true"
                        PageSize="10"
                        MinChars="1"
                        StoreID="Store_refFirstDictionary">
                        <Triggers>
                            <ext:FieldTrigger Icon="Search" Qtip="Открыть" Tag="open" meta:resourcekey="ColumnrefFirstDictionarySearch" />
                            <ext:FieldTrigger Icon="Clear" Qtip="Удалить выбранное" Tag="remove" meta:resourcekey="ColumnrefFirstDictionaryClear" />
                        </Triggers>
                        <Listeners>
                            <TriggerClick Handler="lookuprefFirstDictionaryClick(this, trigger, tag, true, 0);" />
                            <Change Handler="ChangeExtNetLookupValue(item.getStore(), newValue, #{lookuprefFirstDictionaryAddFields})"></Change>
                        </Listeners>
                        <ListConfig LoadingText="Поиск..." meta:resourcekey="ColumnrefFirstDictionaryLoadingText">
                            <ItemTpl ID="ColumnrefFirstDictionary_search" runat="server">
                                <Html>
                                   <div class="search-item">{RowName}</div>
                                </Html>
                            </ItemTpl>
                        </ListConfig>
                        <RemoteValidation OnValidation="RemoteValidationFields" />
                    </ext:ComboBox>
                    <ext:Hidden ID="lookuprefFirstDictionaryFilters" runat="server" Text='<%# GetBrowseUrl("refFirstDictionary", Info.refFirstDictionary, SelectedValueKey) %>' AutoDataBind="true" />
                    <ext:Hidden ID="lookuprefFirstDictionaryAddFields" runat="server" Text='<%# Info.Get_refFirstDictionaryAdditionalInfo() %>' AutoDataBind="true" />
                </Items>
             </ext:Container>
        
        
        
        
             <ext:Container runat="server" ID="containerDecimalValue" Layout="Fit">
                <Items>
                    <ext:NumberField ID="tbDecimalValue" runat="server"
                        meta:resourcekey="ColumnDecimalValue"
                        Name="DecimalValue"
                        FieldLabel="Decimal Value"
                        LabelWidth="200"
                        Width="500"
                        ValidationGroup="DIC_MySecondDictionary"
                        PreserveIndicatorIcon="False"
                        Padding="5"
                        ReadOnly='<%# IsRead %>'
                        AutoDataBind="True"
                        MaxLength="11" EnforceMaxLength="True"
                        DecimalPrecision="2">
                        <RemoteValidation OnValidation="RemoteValidationFields" />
                    </ext:NumberField>
                </Items>
             </ext:Container>
        
        
        
        
             <ext:Container runat="server" ID="containerBoolValue" Layout="Fit">
                <Items>
                    <ext:Checkbox ID="cbBoolValue" runat="server"
                        meta:resourcekey="ColumnBoolValue"
                        Name="BoolValue"
                        FieldLabel="Boolean Value"
                        LabelWidth="200"
                        Width="500"
                        ValidationGroup="DIC_MySecondDictionary"
                        PreserveIndicatorIcon="False"
                        Padding="5"
                        AllowBlank="false"
                        ReadOnly='<%# IsRead %>'
                        AutoDataBind="True">
                        <RemoteValidation OnValidation="RemoteValidationFields" />
                    </ext:Checkbox>
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
                        <Click Before="return (#{FormPanelDIC_MySecondDictionary}.isValid()) == 1;" OnEvent="SaveData">
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