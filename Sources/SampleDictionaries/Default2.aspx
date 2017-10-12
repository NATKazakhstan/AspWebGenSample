<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SampleDictionaries._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <ext:Viewport runat="server" Layout="Border" PaddingSpec="50 0 0 0">
        <Items>
            <ext:Panel runat="server" Region="Center">
                <Loader runat="server" Url="/MainPage/data/DIC_MySecondDictionaryJournal" Mode="Frame" />
            </ext:Panel>
        </Items>
    </ext:Viewport>
</asp:Content>
