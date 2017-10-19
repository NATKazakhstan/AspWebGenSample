/*
 * Generated by: Sergey.Shpakovskiy
 * Generated at: 1.0.0.2
 * Copyright � JSC NAT Kazakhstan 2011
 */
#pragma warning disable
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.Linq;
using System.Linq;
using System.Linq.Expressions;
using System.Security.Principal;
using System.Text;
using System.Xml.Linq;
using System.Web;
using System.Web.Compilation;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using SampleDictionaries.Properties;

using Microsoft.JScript;

using Nat.Tools.Specific;
using Nat.Web.Controls;
using Nat.Web.Controls.GenerationClasses;
using Nat.Web.Controls.GenerationClasses.BaseJournal;
using Nat.Web.Controls.GenerationClasses.Data;
using Nat.Web.Controls.GenerationClasses.Filter;
using Nat.Web.Controls.GenerationClasses.Navigator;
using Nat.Web.Controls.HistoryFilters;
using Nat.Web.Controls.Preview;
using Nat.Web.Tools;
using Nat.Web.Tools.Security;
using Nat.Web.Tools.WorkFlow;
using Nat.Web.WorkFlow.Data;
using Filter = Nat.Web.Controls.GenerationClasses.FilterHtmlGenerator.Filter;
using AccessOptions = SampleDictionaries.MyProductsAccessOptions;
using TableResources = SampleDictionaries.Properties.TableResources;
using Convert=System.Convert;
using SampleDictionaries.Security;

using Nat.Web.Controls.ExtNet.Generation.Filter;
using Nat.Web.Tools.ExtNet.ExtNetConfig;
using BrowseFilterParameters = Nat.Web.Tools.ExtNet.ExtNetBrowseFilterParameters;

namespace SampleDictionaries.UserControls
{
    public enum SelectModeMyProducts
    {
        none,    }

    /// <summary>
    /// ����� ��� ������ � ��������� ������� "��� ������" (MyProducts)
    /// </summary>
    public partial class MyProductsFilter : BaseFilterControl<long, MyProduct, DBDataContext>, IAccessControl, IPostBackEventHandler
    {
        private readonly IEnumerable<IFilterProvider> filterProviders = new IFilterProvider[]{};
        private Dictionary<string, List<FilterItem>> filterValues;
        private IList<Filter> _filters;
        private IDictionary<string, Filter> _filterHandlers;
        private DBDataContext _db;
        private SelectModeMyProducts? _select;
        private bool _filterInitialized;
        private bool _customFiltersInitialized;
        private string setFilterToGrid;
        private string getFilterFromGrid;
        
        protected bool FilterPanelCollapsed { get; set; }

        private BaseFilterEventArgs<MyProduct> _cachedFilterArgs;
        private BaseFilterEventArgs<MyProduct, DBDataContext> _cachedFilterOfParentsArgs;
        private BaseFilterEventArgs<MyProduct, DBDataContext> _cachedFilterOfChildsArgs;
        
        

        public MyProductsFilter()
        {
            Header = TableResources.Project__Header + " -&gt; " + MyProductsResources.Header;

        }

        public static MyProductsFilter CreateDefault(MainPageUrlBuilder url, DBDataContext db)
        {
            var filter = new MyProductsFilter();
            var newUrl = url ?? new MainPageUrlBuilder();
            newUrl.SelectMode = "none";
            newUrl.ViewMode = "none";
            filter.SetUrl(newUrl);
            filter.SetDB(db);
            return filter;
        }

        public static MyProductsFilter CreateDefault(MainPageUrlBuilder url, DBDataContext db, bool showHistory)
        {
            var filter = new MyProductsFilter();
            var newUrl = url != null ? url.Clone() : new MainPageUrlBuilder();
            newUrl.ShowHistory = showHistory;
            newUrl.SelectMode = "none";
            newUrl.ViewMode = "none";
            filter.SetUrl(newUrl);
            filter.SetDB(db);
            filter.ShowHistory = showHistory;
            return filter;
        }

        public static MyProductsFilter CreateDefault(MainPageUrlBuilder url, DBDataContext db, bool showHistory, List<MainPageUrlBuilder.FilterParameter> controlFilterParameters)
        {
            var filter = new MyProductsFilter();
            var newUrl = url != null ? url.Clone() : new MainPageUrlBuilder();
            newUrl.ShowHistory = showHistory;
            newUrl.SelectMode = "none";
            newUrl.ViewMode = "none";
            foreach (var item in controlFilterParameters)
                newUrl.ControlFilterParameters.Add(item.Clone());
            filter.SetUrl(newUrl);
            filter.SetDB(db);
            filter.ShowHistory = showHistory;
            return filter;
        }

        protected DBDataContext DB
        {
            get 
            {
                if (_db == null)
                {
                    _db = new DBDataContext(SpecificInstances.DbFactory.CreateConnection());
                }

                return _db;
            }
        }

        protected SelectModeMyProducts Select
        {
            get 
            {
                try
                {
                    if (_select == null) _select = (SelectModeMyProducts?)Enum.Parse(typeof(SelectModeMyProducts), Url.SelectMode, true);
                }
                catch
                {
                    _select = SelectModeMyProducts.none;
                }
                return _select.Value;
            }
        }

        protected string FilterClick
        {
            get
            {
                if (Url.IsFilterWindow)
                    return HttpUtility.HtmlAttributeEncode("ApplyFilter($get('filterMyProducts')); return false;");

                var getArgumentsScript = string.IsNullOrEmpty(PostBackFilterArguments)
                                             ? string.Empty
                                             : "'" + PostBackFilterArguments + "' + ";
                getArgumentsScript += "GetSerializedFilters($get('filterMyProducts'))";
                var postback = Page.ClientScript.GetPostBackEventReference(PostBackFilterControl, "{0}")
                                   .Replace("'{0}'", getArgumentsScript);
                var onclick = postback + "; return false;";
                return HttpUtility.HtmlAttributeEncode(onclick);
            }
        }

        public override BaseFilter<long, MyProduct> CustomFilter
        {
            get { return base.CustomFilter; }

            set
            {
                base.CustomFilter = value;
                if (value != null && _filterInitialized && !_customFiltersInitialized)
                {
                    _customFiltersInitialized = true;
                    InitializeCustomFilters(_filters);
                    
                    _filterHandlers = _filters
                        .Union(_filters.SelectMany(r => r.AllChildren))
                        .Where(p => p.FilterHandler != null)
                        .ToDictionary(p => LinqFilterGenerator.GetFilterName(p.FilterName));
                }
            }
        }

        public override string GetTableName()
        {
            return "MyProducts";
        }

        public override long? SelectedID { get; set; }

        //partial void SetFilters(ref IQueryable<MyProduct> data);
        partial void SetFilter(BaseFilterEventArgs<MyProduct> filterArgs);
        partial void SetFilter(BaseFilterEventArgs<MyProduct, DBDataContext> filterArgs);
        partial void SetDefaultFilter(DefaultFilters defaultFilters);
        partial void FilterInitialize(IList<Filter> filters);
        partial void GetBrowseFilterParameters(string fieldName, BrowseFilterParameters parameters);

        public override BaseFilterEventArgs<MyProduct> GetFilter(Type typeOfData)
        {
            var filterArgs = _cachedFilterArgs;
            if (filterArgs == null || _cachedFilterArgs.QueryParameters != QueryParameters)
            {
                filterArgs = base.GetFilter(typeOfData);
                var filterArgs2 = (BaseFilterEventArgs<MyProduct, DBDataContext>)filterArgs;
                SetFilter(filterArgs2);
                SetFilter(filterArgs);
                if (!filterArgs.DenyCache)
                    _cachedFilterArgs = filterArgs;
            }
            return filterArgs;
        }

        partial void FilterDataByParentExtend<T>(
            ref Expression source,
            ParameterExpression param,
            Expression upToTable,
            IEnumerable<Expression> fieldsToCheckReference);

        public override Expression FilterDataByParents<T>(Expression source, ParameterExpression param, Expression upToTable, IEnumerable<Expression> fieldsToCheckReference)
        {
            
            FilterDataByParentExtend<T>(ref source, param, upToTable, fieldsToCheckReference);
            return source;
        }


        protected override IDictionary<string, Filter> GetFilterHandlers()
        {
            if (_filterHandlers == null)
                FilterInitialize();
            return _filterHandlers;
        }
        
        internal ICollection<Filter> GetFiltersInternal()
        {
            return GetFilterHandlers().Values;
        }

        protected override Dictionary<string, string[]> GetFilterValues()
        {
            return null;
        }

        protected override Dictionary<string, List<FilterItem>> GetFilterItems()
        {
            ParseFilterParameters();
            return filterValues;
        }

        protected override BaseNavigatorControl GetNavigatorControl()
        {
            if (NavigatorControl == null)
                NavigatorControl = new MyProductsNavigatorControl { Url = Url };
            return NavigatorControl;
        }

        public override IQueryable SetFilters(IQueryable query)
        {
            FilterInitialize();
            foreach (var provider in filterProviders)
            {
                provider.IsSelect = true;
                provider.Url = Url;
                provider.ProjectName = "SampleDictionaries";
                provider.Init(typeof(MyProduct));
                provider.SetFilters(ref query);
            }
            var filter = (IQueryable<MyProduct>)query;
            //SetFilters(ref filter);
            query = filter;
            var enumerable = FilterByCustomExpressions((IQueryable<MyProduct>)query);
            enumerable = FilterData(enumerable);

            if (ParentControl != null)
            {
                var param = Expression.Parameter(typeof(MyProduct), "r");
                var filterExp = ParentControl.GetExpression(FilterByParentControl, param);
                if (filterExp != null)
                {
                    Expression pred = Expression.Lambda(filterExp, param);
                    Expression expr = Expression.Call(typeof(Queryable), "Where", new[] { typeof(MyProduct) }, enumerable.Expression, pred);
                    enumerable = (IQueryable<MyProduct>)enumerable.Provider.CreateQuery(expr);
                }
                else
                {
                    string filterValue;
                    filterValue = ParentControl.SelectedValue == null
                                      ? "0"
                                      : ParentControl.SelectedValueLong.ToString();
                    enumerable = (IQueryable<MyProduct>)
                                 LinqFilterGenerator.GenerateFilter(enumerable,
                                                                    typeof (MyProduct),
                                                                    "Equal",
                                                                    FilterByParentControl,
                                                                    filterValue,
                                                                    null);
                }
            }

            IQueryable queryable = enumerable;
            if (ParentControl == null)
            {
                if (NavigatorControl == null)
                    NavigatorControl = new MyProductsNavigatorControl { Url = Url };
                queryable = NavigatorControl.FilterData(queryable);
                if (Url.UserControl != null && Url.UserControl.StartsWith("MyProducts"))
                {
                    foreach (var queryParameter in Url.QueryParameters)
                    {
                        if (queryParameter.Key.Contains(".") && !string.IsNullOrEmpty(queryParameter.Value) && !queryParameter.Key.EndsWith(".id"))
                        {
                            queryable = LinqFilterGenerator.GenerateFilter(queryable, typeof (MyProduct), "Equal",
                                                                           queryParameter.Key, queryParameter.Value, null);
                        }
                    }
                }
            }
            return (IQueryable<MyProduct>)queryable;
        }
        
        public override void SetUrl(MainPageUrlBuilder url)
        {
            base.SetUrl(url);
            ParseFilterParameters();
        }

        private void ParseFilterParameters()
        {
            filterValues = Url.GetFilterItemsDic(GetFilterTableName());
        }
        
        public override void ReParseFilterParameters()
        {
            ParseFilterParameters();
        }

        protected override void SetDefaultFilterIntranal(DefaultFilters defaultFilters)
        {
            SetDefaultFilter(defaultFilters);
            base.SetDefaultFilterIntranal(defaultFilters);
        }

        public override void SetDB(DataContext db)
        {
            this._db = (DBDataContext)db;
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            FilterInitialize();
        }
        
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (Url.IsFilterWindow && !Page.IsPostBack)
                ParseFilterParameters();
        }

        protected override void OnPreRender(EventArgs e)
        {
            FilterControlGenerator.PackingFilter(this, _filters, getFilterFromGrid, setFilterToGrid, FilterPanelCollapsed);
        
            base.OnPreRender(e);
        }
        
        internal void InitializeFilterFunction(string setFilterToGrid, string getFilterFromGrid)
        {
            this.setFilterToGrid = setFilterToGrid;
            this.getFilterFromGrid = getFilterFromGrid;
        }

        public void RaisePostBackEvent(string eventArgument)
        {
            string component = GlobalObject.decodeURIComponent(eventArgument);
            Url.SetFilter(GetFilterTableName(), component);
            if (Url != MainPageUrlBuilder.Current)
                MainPageUrlBuilder.Current.SetFilter(component, GetFilterTableName());
            MainPageUrlBuilder.ChangedUrl();
            filterValues = MainPageUrlBuilder.GetFilterItemsDicByFilterContent(component);
            OnFilterApply(EventArgs.Empty);
            var updatePanel = ControlHelper.FindControl<UpdatePanel>(this);
            if (updatePanel != null) updatePanel.Update();
        }
        
        protected override IWorkFlow[] CreateWorkFlows()
        {
            return new IWorkFlow[] {};
        }

        protected override void FilterInitialize()
        {
            if (_filterInitialized) return;
            _filterInitialized = true;
            
            _filters = (IList<Filter>)HttpContext.Current.Items["MyProducts.FiltersCache"];
            if (Page == null && _filters != null)
            {
                _filterHandlers = _filters.
                    Union(_filters.SelectMany(r => r.AllChildren)).
                    Where(p => p.FilterHandler != null).
                    ToDictionary(p => LinqFilterGenerator.GetFilterName(p.FilterName));
                return;
            }
            
            BrowseFilterParameters parameters;
            IList<Filter> filters = new List<Filter>();
            var stack = new Stack<IList<Filter>>();
            _filters = filters;
            Filter current;
            BaseFilterParameter currentBF = null;
            
            
            
            
            //������� '������������'
            current = currentBF = new BaseFilterParameterString<MyProduct>(r => r.Name)
                {
                    FilterName = "Name", 
                    Header = MyProductsResources.Name__Header,
                    IsJournalFilter = true,
                    Mandatory = true,
                    Type = FilterHtmlGenerator.FilterType.Text, 
                    MaxLength = 200,
                            Width = "98%",
                };
            currentBF.AddFilter(filters);
            //filters.Add(current);
            
            
            
            
            
            //������� '���� ��������'
            current = currentBF = new BaseFilterParameter<MyProduct, DateTime>(r => r.CreationDate)
                {
                    FilterName = "CreationDate", 
                    Header = MyProductsResources.CreationDate__Header,
                    IsJournalFilter = true,
                    Mandatory = true,
                    Type = FilterHtmlGenerator.FilterType.Numeric, 
                    IsDateTime = true,
                };
            currentBF.AddFilter(filters);
            //filters.Add(current);
            
            
            
            
            
            //������� '����'
            current = currentBF = new BaseFilterParameter<MyProduct, Decimal>(r => r.Price)
                {
                    FilterName = "Price", 
                    Header = MyProductsResources.Price__Header,
                    IsJournalFilter = true,
                    Mandatory = true,
                    Type = FilterHtmlGenerator.FilterType.Numeric, 
                    DecimalPrecision = 2,
                    MaxLength = 8,
                            Columns = 8,
                };
            currentBF.AddFilter(filters);
            //filters.Add(current);
            
            
            
            
            
            //������� '��������'
            current = currentBF = new BaseFilterParameter<MyProduct, Decimal>(r => r.Amount)
                {
                    FilterName = "Amount", 
                    Header = MyProductsResources.Amount__Header,
                    IsJournalFilter = true,
                    Mandatory = true,
                    Type = FilterHtmlGenerator.FilterType.Numeric, 
                    DecimalPrecision = 2,
                    MaxLength = 8,
                            Columns = 8,
                };
            currentBF.AddFilter(filters);
            //filters.Add(current);
            
            
            
            
            if(Url.IsMultipleSelect)
            {
                current = new Filter
                              {
                                  FilterName = MultipleSelectedValues,
                                  Header = TableResources.MultipleSelectedFilterHeader,
                                  Type = FilterHtmlGenerator.FilterType.Boolean,
                                  TrueBooleanText = TableResources.MultipleSelectedFilterSelected,
                                  FalseBooleanText = TableResources.MultipleSelectedFilterNotSelected,
                                  Mandatory = true,
                                  FilterHandler =
                                      delegate(IQueryable enumerable, Enum type, string value1, string value2)
                                          {
                                              throw new Exception("Is not actual delegate");
                                          },
                              };
                filters.Add(current);
            }
            
            AddSearchFilter(filters);
            SetDefaultFilterType(filters);
            FilterInitialize(filters);
            if (CustomFilter != null && !_customFiltersInitialized)
            {
                _customFiltersInitialized = true;
                InitializeCustomFilters(filters);
            }
            
            _filterHandlers = filters.
                Union(filters.SelectMany(r => r.AllChildren)).
                Where(p => p.FilterHandler != null).
                ToDictionary(p => LinqFilterGenerator.GetFilterName(p.FilterName));
            HttpContext.Current.Items["MyProducts.FiltersCache"] = filters;
        }
        
        private void AddSearchFilter(IList<Filter> filters)
        {
        }

        protected override object SaveViewState()
        {
            return new Pair(filterValues, base.SaveViewState());
        }

        protected override void LoadViewState(object savedState)
        {
            Pair pair = savedState as Pair;
            if (pair != null)
            {
                filterValues = (Dictionary<string, List<FilterItem>>)pair.First;
                base.LoadViewState(pair.Second);
            }
            else
                base.LoadViewState(null);
        }
 
        
        
        public class ConstOfColumnNames
        {
            /// <summary>
            /// ������������ ������ ���������
            /// </summary>
            public const string VALIDATION_GROUP = "MyProducts";
        
            /// <summary>
            /// ������������ �������
            /// </summary>
            public const string TABLE_NAME = "MyProducts";
        
            /// <summary>
            /// ������������ ����� �������
            /// </summary>
            public const string JournalName = "MyProductsJournal";
        
            /// <summary>
            /// ������������ ����� ��������������
            /// </summary>
            public const string EditName = "MyProductsEdit";
        
            /// <summary>
            /// ������������ ����� �������
            /// </summary>
            public const string FilterName = "MyProductsFilter";
        
            /// <summary>
            /// �������� ������� �������
            /// </summary>
            public const string RefTable = "refMyProducts";
        
            /// <summary>
            /// �������������.
            /// </summary>
            public const string id = "id";
        
            /// <summary>
            /// �������������, ������������ �������.
            /// </summary>
            public const string idFilterName = "id";
        
            /// <summary>
            /// ������������.
            /// </summary>
            public const string Name = "Name";
        
            /// <summary>
            /// ������������, ������������ �������.
            /// </summary>
            public const string NameFilterName = "Name";
        
            /// <summary>
            /// ���� ��������.
            /// </summary>
            public const string CreationDate = "CreationDate";
        
            /// <summary>
            /// ���� ��������, ������������ �������.
            /// </summary>
            public const string CreationDateFilterName = "CreationDate";
        
            /// <summary>
            /// ����.
            /// </summary>
            public const string Price = "Price";
        
            /// <summary>
            /// ����, ������������ �������.
            /// </summary>
            public const string PriceFilterName = "Price";
        
            /// <summary>
            /// ��������.
            /// </summary>
            public const string Amount = "Amount";
        
            /// <summary>
            /// ��������, ������������ �������.
            /// </summary>
            public const string AmountFilterName = "Amount";
        
            /// <summary>
            /// .
            /// </summary>
            public const string RowVersion = "RowVersion";
        
            /// <summary>
            /// , ������������ �������.
            /// </summary>
            public const string RowVersionFilterName = "RowVersion";
        }
        
        bool IAccessControl.CheckPermit(Page page)
        {
            return AccessOptions.CheckPermit();
        }

        private LogMonitor _logMonitor;
        protected LogMonitor LogMonitor
        {
            get
            {
                if(_logMonitor == null)
                {
                    _logMonitor = new LogMonitor();
                    _logMonitor.Init();
                }
                return _logMonitor;
            }
        }

        public static MainPageUrlBuilder FromUrl(string url)
        {
            var builder = MainPageUrlBuilder.FromUrlToOtherControl(url);
            builder.UserControl = "MyProductsFilter";
            builder.IsFilterWindow = true;
            return builder;
        }

        public static string GetUserControlName()
        {
            return "MyProductsFilter";
        }
    }
}
#pragma warning restore