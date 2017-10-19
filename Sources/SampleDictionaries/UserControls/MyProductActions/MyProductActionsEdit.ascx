<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MyProductActionsEdit.ascx.cs" Inherits="SampleDictionaries.UserControls.MyProductActionsEdit" %>

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
        <cc1:MyProductActionsNavigatorControl ID="NavigatorControl" runat=server />
<%  }%>

<cc1:MyProductActionsJournalDataSource runat="server" ID="source" OnSelecting="Source_Selecting" />
<NatC:LinqDataSourceExt ID="lds" runat="server"
    ContextTypeName="SampleDictionaries.DBDataContext" TableName="MyProductActions" 
    EnableDelete="True" EnableUpdate="True" Where="id == @id" 
    EnableInsert="True" oninserted="lds_Inserted" onupdated="lds_Updated" OnContextCreating="lds_ContextCreating" OnContextDisposing="lds_ContextDisposing"
    onselecting="lds_Selecting" onUpdating="lds_Updating" onInserting="lds_Inserting">
    <WhereParameters>
        <asp:ControlParameter ControlID="hfid" DefaultValue="0" Name="id" PropertyName="Value" Type="Int64" />
    </WhereParameters>
</NatC:LinqDataSourceExt>
<NatC:LinqDataSourceExt ID="ldsChanges" runat="server" 
    ContextTypeName="SampleDictionaries.DBDataContext" TableName="MyProductActions" 
    EnableDelete="True" EnableUpdate="True" Where="id == @id" 
    EnableInsert="True" oninserted="lds_Inserted" onupdated="lds_Updated" OnContextCreating="lds_ContextCreating" OnContextDisposing="lds_ContextDisposing"
    onselecting="ldsChanges_Selecting" onUpdating="ldsChanges_Updating" onInserting="ldsChanges_Inserting">
    <WhereParameters>
        <asp:ControlParameter ControlID="hfid" DefaultValue="0" Name="id" PropertyName="Value" Type="Int64" />
    </WhereParameters>
</NatC:LinqDataSourceExt>

<cc1:MyProductsJournalDataSource runat="server" ID="jdsrefProduct" 
OnSelecting="jdsrefProduct_Selecting" AllowSelectOnlyNames=true SelectForAddType="SampleDictionaries.MyProductAction" />

<ext:Store runat="server" id="Store_refProduct" AutoLoad="False">
    <Proxy>
        <ext:AjaxProxy Url="/AutoCompleteHandler.ashx">
            <ExtraParams>
                <ext:Parameter Name="dataSourceType" Value="SampleDictionaries.MyProductsJournalDataSourceView"/>
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
        <BeforeLoad Handler="SetLookupParameters_refProduct(this);"></BeforeLoad>
    </Listeners>
</ext:Store>
<ext:XScript runat="server">
<script type="text/javascript">
    function SetLookupParameters_refProduct(store) {
        ReadExtNetAdditionalFields(#{lookuprefProductAddFields});
        var extraParams = store.getProxy().extraParams;
        extraParams.parameters = GetExtNetLookupFilters(#{lookuprefProductFilters}) 
            + GetExtNetLookupSelectParameters(#{lookuprefProductAddFields});
        return '';
    }

    var lookuprefProductClick = function (el, trigger, tag, auto) {            
        var lookupAddFields = #{lookuprefProductAddFields};
        var store = el.getStore();
        switch(tag) {
            case "open":
                var w = #{refProductModalWindow};
                w.editor = el;
                w.autoComplete = auto;
                valueID = el.getValue();
                ReadExtNetAdditionalFields(lookupAddFields);
                var newUrl = '/EmptyPage.aspx/data/MyProductsJournal/Select?mode=none&viewmode=none&__SFAddType=SampleDictionaries.MyProductAction'
                    + GetExtNetLookupFilters(#{lookuprefProductFilters})
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
                    frame.refMyProducts = valueID == null ? null : valueID;
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
    ID="refProductModalWindow"
    runat="server"
    Icon="Table"
    Modal="False"
    Width="800"
    Height="600"
    Maximized="True"
    AutoRender=false
    Hidden="true"
    Layout="Fit"
    meta:resourcekey="refProductModalWindow">
    <Loader Url="" Mode="Frame" AutoLoad="False" meta:resourcekey="Loader">
        <LoadMask ShowMask="True"></LoadMask>
    </Loader>
    <Listeners>
    </Listeners>
</ext:Window>

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
<ext:FormPanel runat="server" ID="FormPanelMyProductActions"
    Title="Поступления/продажи товаров"
    DefaultButton="SaveButton"
    Region="Center"
    AutoScroll="True"
    meta:resourcekey="FormPanelMyProductActions">
    <Items>
        <ext:Hidden runat="server" ID="rowVersionHiddenField"/>
        <ext:Hidden runat="server" ID="hfSessionKey"/>
        <ext:Hidden ID="hfid" runat="server" />
        
        
        
        
             <ext:Container runat="server" ID="containerrefProduct" Layout="Fit">
                <Items>
                    <ext:ComboBox ID="lookuprefProduct" runat="server"
                        meta:resourcekey="ColumnrefProduct"
                        Name="refProduct"
                        FieldLabel="Мой товар"
                        LabelWidth="200"
                        Width="500"
                        ValidationGroup="MyProductActions"
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
                        StoreID="Store_refProduct">
                        <Triggers>
                            <ext:FieldTrigger Icon="Search" Qtip="Открыть" Tag="open" meta:resourcekey="ColumnrefProductSearch" />
                            <ext:FieldTrigger Icon="Clear" Qtip="Удалить выбранное" Tag="remove" meta:resourcekey="ColumnrefProductClear" />
                        </Triggers>
                        <Listeners>
                            <TriggerClick Handler="lookuprefProductClick(this, trigger, tag, true, 0);" />
                            <Change Handler="ChangeExtNetLookupValue(item.getStore(), newValue, #{lookuprefProductAddFields})"></Change>
                        </Listeners>
                        <ListConfig LoadingText="Поиск..." meta:resourcekey="ColumnrefProductLoadingText">
                            <ItemTpl ID="ColumnrefProduct_search" runat="server">
                                <Html>
                                   <div class="search-item">{RowName}</div>
                                </Html>
                            </ItemTpl>
                        </ListConfig>
                        <RemoteValidation OnValidation="RemoteValidationFields" />
                    </ext:ComboBox>
                    <ext:Hidden ID="lookuprefProductFilters" runat="server" Text='<%# GetBrowseUrl("refProduct", Info.refProduct, SelectedValueKey) %>' AutoDataBind="true" />
                    <ext:Hidden ID="lookuprefProductAddFields" runat="server" Text='<%# Info.Get_refProductAdditionalInfo() %>' AutoDataBind="true" />
                </Items>
             </ext:Container>
        
        
        
        
             <ext:Container runat="server" ID="containerDateTimeAction" Layout="HBoxLayout">
                <Items>
                    <ext:DateField ID="dpDateTimeAction" runat="server" 
                        meta:resourcekey="ColumnDateTimeAction"
                        Name="DateTimeAction"
                        FieldLabel="Дата/время действия"
                        LabelWidth="200"
                        Width=""
                        ValidationGroup="MyProductActions"
                        PreserveIndicatorIcon="False"
                        Padding="5"
                        AllowBlank="false"
                        ReadOnly="False"
                        
                        Enabled="False"
                        Format="dd.MM.yyyy">
                        <RemoteValidation OnValidation="RemoteValidationFields" />
                    </ext:DateField>
                </Items>
             </ext:Container>
        
        
        
        
             <ext:Container runat="server" ID="containerAmountChange" Layout="Fit">
                <Items>
                    <ext:NumberField ID="tbAmountChange" runat="server"
                        meta:resourcekey="ColumnAmountChange"
                        Name="AmountChange"
                        FieldLabel="Изменение кол-ва"
                        LabelWidth="200"
                        Width="500"
                        ValidationGroup="MyProductActions"
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
        
        
        
        
             <ext:Container runat="server" ID="containerNote" Layout="Fit">
                <Items>
                    <ext:TextField ID="tbNote" runat="server"
                        meta:resourcekey="ColumnNote"
                        Name="Note"
                        FieldLabel="Примечание"
                        LabelWidth="200"
                        Width="500"
                        ValidationGroup="MyProductActions"
                        PreserveIndicatorIcon="False"
                        Padding="5"
                        ReadOnly='<%# IsRead %>'
                        AutoDataBind="True"
                        MaxLength="500" EnforceMaxLength="True">
                        <RemoteValidation OnValidation="RemoteValidationFields" />
                    </ext:TextField>
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
                        <Click Before="return (#{FormPanelMyProductActions}.isValid()) == 1;" OnEvent="SaveData">
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