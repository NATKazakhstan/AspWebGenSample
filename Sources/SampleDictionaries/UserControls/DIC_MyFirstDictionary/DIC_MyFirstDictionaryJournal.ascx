<%@ Import Namespace="Nat.Web.Tools" %>
<%@ Import Namespace="Nat.Web.Controls.GenerationClasses"%>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DIC_MyFirstDictionaryJournal.ascx.cs" Inherits="SampleDictionaries.UserControls.DIC_MyFirstDictionaryJournal" %>
<%@ Register Assembly="Nat.Web.Controls" Namespace="Nat.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Nat.Web.Controls" Namespace="Nat.Web.Controls.GenerationClasses" TagPrefix="cc1" %>
<%@ Register Assembly="Nat.Web.Controls" Namespace="Nat.Web.Controls.GenerationClasses.Data" TagPrefix="NatC" %>
<%@ Register Assembly="Nat.Web.Controls.ExtNet" Namespace="Nat.Web.Controls.ExtNet.Generation" TagPrefix="NatC" %>
<%@ Register Assembly="SampleDictionaries" Namespace="SampleDictionaries.UserControls" TagPrefix="NatC" %>
<%@ Register Assembly="SampleDictionaries" Namespace="SampleDictionaries.UserControls" TagPrefix="cc1" %>
<%@ Register Assembly="SampleDictionaries" Namespace="SampleDictionaries" TagPrefix="cc1" %>





<cc1:DIC_MyFirstDictionaryJournalDataSource runat="server" ID="source" OnSelecting="Source_Selecting" AllowCustomCache=true />

<%
    // Не требуется рендеринг, но нужен для фильтрации.
    if (false)
    {
%>
<cc1:DIC_MyFirstDictionaryNavigatorControl ID="NavigatorControl" runat=server OnValuesInitialized="NavigatorControl_ValuesInitialized"/>
<%
    }
%>
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
       <NatC:SelectedRowsGrid runat="server" id="selectedUserValues" Region="North" Layout="Fit" MinHeight="130" MaxHeight="130" />
        <ext:Container runat="server" ID="filterPlaceHolder" Region="North" Layout="Fit" Visible="False" />
        <ext:GridPanel runat="server" ID="grid" Region="Center" Layout="Fit" meta:resourcekey="grid">
            <Store>
                <ext:Store runat="server"
                    ID="store"
                    PageSize="10"
                    RemotePaging="True"
                    RemoteSort="True"
                    AutoDataBind="True"
                    RemoteFilter="True"
                    OnReadData="OnReadData"
                    meta:resourcekey="store">
                    <Proxy>
                        <ext:PageProxy />
                    </Proxy>
                    <Model>
                        <ext:Model runat="server" IDProperty="id" />
                    </Model>
                    <Listeners>
                        <Load Handler="
                            var value = #{SelectIDHidden}.getValue();
                            if (value == null || value == '')
                                return;
                            var selModel = #{grid}.selModel;
                            var r = store.getById(parseInt(value));
                            if (!Ext.isEmpty(r)) {
                                selModel.select([r]);
                                #{SelectIDHidden}.setValue('');
                            }
                            else
                                selModel.select([]);" />
                    </Listeners>
                </ext:Store>
            </Store>
            <ColumnModel>
            </ColumnModel>
            <SelectionModel>
                <ext:CheckboxSelectionModel runat="server" Mode="Multi" ID="gridSelectionModel" />
            </SelectionModel>
            <Features>
                <ext:GridFilters runat="server" ID="gridFilter" meta:resourcekey="gridFilter"/>
            </Features>
            <View>
                <ext:GridView
                    runat="server"
                    meta:resourcekey="gridView" />
            </View>
            <TopBar>
                <ext:Toolbar runat="server" ID="topGridToolBar">
                    <Items>
                        <ext:Button ID="SelectionOK" Icon="Accept" runat="server" meta:resourcekey="SelectionOK">
                            <Listeners>
                                <Click Handler="window.frameElement.addSelectedValues(#{selectedUserValuesStore}.getAllRange())" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="SelectionCancel" Icon="Cancel" runat="server" meta:resourcekey="SelectionCancel">
                            <Listeners>
                                <Click Handler="window.frameElement.closeModalWindow();" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <BottomBar>
                <ext:PagingToolbar
                    runat="server"
                    DisplayInfo="true"
                    meta:resourcekey="pagingToolBar">
                    <Items>
                        <ext:Button runat="server" ID="AddButton"
                            Icon="Add"
                            ToolTip="Add"
                            meta:resourcekey="AddButton">
                        </ext:Button>
                        <ext:Button runat="server" ID="DeleteSelectedButton"
                            Icon="Cross"
                            ToolTip="Delete selected"
                            meta:resourcekey="DeleteSelectedButton">
                            <DirectEvents>
                                <Click OnEvent="DeleteSelected">
                                    <EventMask ShowMask="True"></EventMask>
                                    <Confirmation ConfirmRequest="True" />
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <NatC:HelpFileLinkExt runat="server" ID="btnHelp" WindowID="ModalWindow" NavigateUrlDefault="/HelpFiles/SampleDictionaries/DIC_MyFirstDictionary.htm" NavigateUrl="/HelpFiles/SampleDictionaries/DIC_MyFirstDictionary_Journal.htm" />
                        <ext:Hidden runat="server" ID="FilterHidden"></ext:Hidden>
                        <ext:Hidden runat="server" ID="GridFilterHidden"></ext:Hidden>
                        <ext:Hidden runat="server" ID="ShowHistoryHidden" Text="false"></ext:Hidden>
                        <ext:Hidden runat="server" ID="SelectIDHidden"></ext:Hidden>
                    </Items>
                </ext:PagingToolbar>
            </BottomBar>
            <Plugins>
            </Plugins>
            <Loader meta:resourcekey="Loader"/>
        </ext:GridPanel>
    </Items>
</ext:Viewport>

<asp:PlaceHolder runat="server" ID="placeHolder" />
<script type="text/javascript">
    function <%= GetUpdateFilterSctiptFunctionName() %>(filters) {
        <%= FilterHidden.ClientID %>.setValue(filters);
        <%= store.ClientID %>.reload();
    }
    
    function <%= GetValueFilterSctiptFunctionName() %>() {
        return <%= FilterHidden.ClientID %>.getValue();
    }
</script>