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
using AccessOptions = SampleDictionaries.DIC_MySecondDictionaryAccessOptions;
using TableResources = SampleDictionaries.Properties.TableResources;
using Convert=System.Convert;
using SampleDictionaries.Security;
using SampleDictionaries;
using SampleDictionaries.UserControls;
using SampleDictionaries.Properties;
using Nat.Web.Controls.ExtNet.Generation.Filter;
using Nat.Web.Tools.ExtNet.ExtNetConfig;
using BrowseFilterParameters = Nat.Web.Tools.ExtNet.ExtNetBrowseFilterParameters;

namespace SampleDictionaries.UserControls
{
    public enum SelectModeDIC_MySecondDictionary
    {
        none,    }

    /// <summary>
    /// ����� ��� ������ � ��������� ������� "My Second Dictionary" (DIC_MySecondDictionary)
    /// </summary>
    public partial class DIC_MySecondDictionaryFilter : BaseFilterControl<long, DIC_MySecondDictionary, DBDataContext>, IAccessControl, IPostBackEventHandler
    {
        private readonly IEnumerable<IFilterProvider> filterProviders = new IFilterProvider[]{};
        private Dictionary<string, List<FilterItem>> filterValues;
        private IList<Filter> _filters;
        private IDictionary<string, Filter> _filterHandlers;
        private DBDataContext _db;
        private SelectModeDIC_MySecondDictionary? _select;
        private bool _filterInitialized;
        private bool _customFiltersInitialized;
        private string setFilterToGrid;
        private string getFilterFromGrid;
        
        protected bool FilterPanelCollapsed { get; set; }

        private BaseFilterEventArgs<DIC_MySecondDictionary> _cachedFilterArgs;
        private BaseFilterEventArgs<DIC_MySecondDictionary, DBDataContext> _cachedFilterOfParentsArgs;
        private BaseFilterEventArgs<DIC_MySecondDictionary, DBDataContext> _cachedFilterOfChildsArgs;
        private DIC_MyFirstDictionaryFilter _cachedDIC_MyFirstDictionaryFilterControl;
        

        public DIC_MySecondDictionaryFilter()
        {
            Header = TableResources.Project__Header + " -&gt; " + DIC_MySecondDictionaryResources.Header;

        }

        public static DIC_MySecondDictionaryFilter CreateDefault(MainPageUrlBuilder url, DBDataContext db)
        {
            var filter = new DIC_MySecondDictionaryFilter();
            var newUrl = url ?? new MainPageUrlBuilder();
            newUrl.SelectMode = "none";
            newUrl.ViewMode = "none";
            filter.SetUrl(newUrl);
            filter.SetDB(db);
            return filter;
        }

        public static DIC_MySecondDictionaryFilter CreateDefault(MainPageUrlBuilder url, DBDataContext db, bool showHistory)
        {
            var filter = new DIC_MySecondDictionaryFilter();
            var newUrl = url != null ? url.Clone() : new MainPageUrlBuilder();
            newUrl.ShowHistory = showHistory;
            newUrl.SelectMode = "none";
            newUrl.ViewMode = "none";
            filter.SetUrl(newUrl);
            filter.SetDB(db);
            filter.ShowHistory = showHistory;
            return filter;
        }

        public static DIC_MySecondDictionaryFilter CreateDefault(MainPageUrlBuilder url, DBDataContext db, bool showHistory, List<MainPageUrlBuilder.FilterParameter> controlFilterParameters)
        {
            var filter = new DIC_MySecondDictionaryFilter();
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

        protected SelectModeDIC_MySecondDictionary Select
        {
            get 
            {
                try
                {
                    if (_select == null) _select = (SelectModeDIC_MySecondDictionary?)Enum.Parse(typeof(SelectModeDIC_MySecondDictionary), Url.SelectMode, true);
                }
                catch
                {
                    _select = SelectModeDIC_MySecondDictionary.none;
                }
                return _select.Value;
            }
        }

        protected string FilterClick
        {
            get
            {
                if (Url.IsFilterWindow)
                    return HttpUtility.HtmlAttributeEncode("ApplyFilter($get('filterDIC_MySecondDictionary')); return false;");

                var getArgumentsScript = string.IsNullOrEmpty(PostBackFilterArguments)
                                             ? string.Empty
                                             : "'" + PostBackFilterArguments + "' + ";
                getArgumentsScript += "GetSerializedFilters($get('filterDIC_MySecondDictionary'))";
                var postback = Page.ClientScript.GetPostBackEventReference(PostBackFilterControl, "{0}")
                                   .Replace("'{0}'", getArgumentsScript);
                var onclick = postback + "; return false;";
                return HttpUtility.HtmlAttributeEncode(onclick);
            }
        }

        public override BaseFilter<long, DIC_MySecondDictionary> CustomFilter
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
            return "DIC_MySecondDictionary";
        }

        public override long? SelectedID { get; set; }

        //partial void SetFilters(ref IQueryable<DIC_MySecondDictionary> data);
        partial void SetFilter(BaseFilterEventArgs<DIC_MySecondDictionary> filterArgs);
        partial void SetFilter(BaseFilterEventArgs<DIC_MySecondDictionary, DBDataContext> filterArgs);
        partial void SetDefaultFilter(DefaultFilters defaultFilters);
        partial void FilterInitialize(IList<Filter> filters);
        partial void GetBrowseFilterParameters(string fieldName, BrowseFilterParameters parameters);
        partial void GetBrowseFilterParameters_refFirstDictionary(BrowseFilterParameters parameters);


        public override BaseFilterEventArgs<DIC_MySecondDictionary> GetFilter(Type typeOfData)
        {
            var filterArgs = _cachedFilterArgs;
            if (filterArgs == null || _cachedFilterArgs.QueryParameters != QueryParameters)
            {
                filterArgs = base.GetFilter(typeOfData);
                var filterArgs2 = (BaseFilterEventArgs<DIC_MySecondDictionary, DBDataContext>)filterArgs;
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
            var refFirstDictionaryControl = _cachedDIC_MyFirstDictionaryFilterControl;
            if (refFirstDictionaryControl == null)
                refFirstDictionaryControl = _cachedDIC_MyFirstDictionaryFilterControl = DIC_MyFirstDictionaryFilter.CreateDefault(null, DB, ShowHistory || SelectedID != null, Url.ControlFilterParameters);
            var refFirstDictionaryToTable = Expression.Property(upToTable, "DIC_MyFirstDictionary_refFirstDictionary");
            var refFirstDictionaryToCheckReference = new List<Expression>(fieldsToCheckReference);
            refFirstDictionaryControl.SetUrl(Url);
            source = refFirstDictionaryControl.FilterData<T>(source, QueryParameters, refFirstDictionaryToTable, param, refFirstDictionaryToCheckReference, true);
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
                NavigatorControl = new DIC_MySecondDictionaryNavigatorControl { Url = Url };
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
                provider.Init(typeof(DIC_MySecondDictionary));
                provider.SetFilters(ref query);
            }
            var filter = (IQueryable<DIC_MySecondDictionary>)query;
            //SetFilters(ref filter);
            query = filter;
            var enumerable = FilterByCustomExpressions((IQueryable<DIC_MySecondDictionary>)query);
            enumerable = FilterData(enumerable);

            if (ParentControl != null)
            {
                var param = Expression.Parameter(typeof(DIC_MySecondDictionary), "r");
                var filterExp = ParentControl.GetExpression(FilterByParentControl, param);
                if (filterExp != null)
                {
                    Expression pred = Expression.Lambda(filterExp, param);
                    Expression expr = Expression.Call(typeof(Queryable), "Where", new[] { typeof(DIC_MySecondDictionary) }, enumerable.Expression, pred);
                    enumerable = (IQueryable<DIC_MySecondDictionary>)enumerable.Provider.CreateQuery(expr);
                }
                else
                {
                    string filterValue;
                    filterValue = ParentControl.SelectedValue == null
                                      ? "0"
                                      : ParentControl.SelectedValueLong.ToString();
                    enumerable = (IQueryable<DIC_MySecondDictionary>)
                                 LinqFilterGenerator.GenerateFilter(enumerable,
                                                                    typeof (DIC_MySecondDictionary),
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
                    NavigatorControl = new DIC_MySecondDictionaryNavigatorControl { Url = Url };
                queryable = NavigatorControl.FilterData(queryable);
                if (Url.UserControl != null && Url.UserControl.StartsWith("DIC_MySecondDictionary"))
                {
                    foreach (var queryParameter in Url.QueryParameters)
                    {
                        if (queryParameter.Key.Contains(".") && !string.IsNullOrEmpty(queryParameter.Value) && !queryParameter.Key.EndsWith(".id"))
                        {
                            queryable = LinqFilterGenerator.GenerateFilter(queryable, typeof (DIC_MySecondDictionary), "Equal",
                                                                           queryParameter.Key, queryParameter.Value, null);
                        }
                    }
                }
            }
            return (IQueryable<DIC_MySecondDictionary>)queryable;
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
            
            _filters = (IList<Filter>)HttpContext.Current.Items["DIC_MySecondDictionary.FiltersCache"];
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
            
            
            
            
            //������� 'Name'
            current = currentBF = new BaseFilterParameterString<DIC_MySecondDictionary>(r => r.Name)
                {
                    FilterName = "Name", 
                    Header = DIC_MySecondDictionaryResources.Name__Header,
                    IsJournalFilter = true,
                    Mandatory = true,
                    Type = FilterHtmlGenerator.FilterType.Text, 
                    MaxLength = 255,
                            Width = "98%",
                };
            currentBF.AddFilter(filters);
            //filters.Add(current);
            
            
            
            
            
            parameters = new BrowseFilterParameters();
            GetBrowseFilterParameters_refFirstDictionary(parameters);
            //������� 'First Dictionary Value'
            current = currentBF = new BaseFilterParameter<DIC_MySecondDictionary, Int64>(r => r.refFirstDictionary,
                                      r => r.DIC_MyFirstDictionary_refFirstDictionary.Name,
                                      r => r.DIC_MyFirstDictionary_refFirstDictionary.Name)
                {
                    FilterName = "refFirstDictionary", 
                    Header = DIC_MySecondDictionaryResources.refFirstDictionary__Header,
                    IsJournalFilter = true,
                    Mandatory = true,
                    Type = FilterHtmlGenerator.FilterType.Reference,
                    ProjectName = "SampleDictionaries",
                    TableName = "DIC_MyFirstDictionary",
                    Lookup = true, 
                    MinimumPrefixLength = 1, 
                    Width = "98%", 
                    SelectMode = "none",
                    IsMultipleSelect = true,
                    BrowseFilterParameters = parameters,
                };
            currentBF.AddFilter(filters);
            //filters.Add(current);
            
            
            
            
            
            //������� 'Decimal Value'
            current = currentBF = new BaseFilterParameter<DIC_MySecondDictionary, Decimal>(r => r.DecimalValue)
                {
                    FilterName = "DecimalValue", 
                    Header = DIC_MySecondDictionaryResources.DecimalValue__Header,
                    IsJournalFilter = true,
                    Mandatory = false,
                    Type = FilterHtmlGenerator.FilterType.Numeric, 
                    DecimalPrecision = 2,
                    MaxLength = 11,
                            Columns = 11,
                };
            currentBF.AddFilter(filters);
            //filters.Add(current);
            
            
            
            
            
            //������� 'Boolean Value'
            current = currentBF = new BaseFilterParameter<DIC_MySecondDictionary, Boolean>(r => r.BoolValue)
                {
                    FilterName = "BoolValue", 
                    Header = DIC_MySecondDictionaryResources.BoolValue__Header,
                    IsJournalFilter = true,
                    Mandatory = true,
                    Type = FilterHtmlGenerator.FilterType.Boolean, 
                    TrueBooleanText = DIC_MySecondDictionaryResources.BoolValue__TrueText, 
                    FalseBooleanText = DIC_MySecondDictionaryResources.BoolValue__FalseText,
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
            HttpContext.Current.Items["DIC_MySecondDictionary.FiltersCache"] = filters;
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
            public const string VALIDATION_GROUP = "DIC_MySecondDictionary";
        
            /// <summary>
            /// ������������ �������
            /// </summary>
            public const string TABLE_NAME = "DIC_MySecondDictionary";
        
            /// <summary>
            /// ������������ ����� �������
            /// </summary>
            public const string JournalName = "DIC_MySecondDictionaryJournal";
        
            /// <summary>
            /// ������������ ����� ��������������
            /// </summary>
            public const string EditName = "DIC_MySecondDictionaryEdit";
        
            /// <summary>
            /// ������������ ����� �������
            /// </summary>
            public const string FilterName = "DIC_MySecondDictionaryFilter";
        
            /// <summary>
            /// �������� ������� �������
            /// </summary>
            public const string RefTable = "refDIC_MySecondDictionary";
        
            /// <summary>
            /// Identifier.
            /// </summary>
            public const string id = "id";
        
            /// <summary>
            /// Identifier, ������������ �������.
            /// </summary>
            public const string idFilterName = "id";
        
            /// <summary>
            /// Name.
            /// </summary>
            public const string Name = "Name";
        
            /// <summary>
            /// Name, ������������ �������.
            /// </summary>
            public const string NameFilterName = "Name";
        
            /// <summary>
            /// First Dictionary Value.
            /// </summary>
            public const string refFirstDictionary = "refFirstDictionary";
        
            /// <summary>
            /// First Dictionary Value, ������������ �������.
            /// </summary>
            public const string refFirstDictionaryFilterName = "refFirstDictionary";
        
            /// <summary>
            /// ������������ ����� ���� "First Dictionary Value".
            /// </summary>
            public const string DIC_MyFirstDictionary_refFirstDictionary = "DIC_MyFirstDictionary_refFirstDictionary";
        
            /// <summary>
            /// ������������ ����� ���� "First Dictionary Value", � ������ �����.
            /// </summary>
            public const string DIC_MyFirstDictionary_refFirstDictionary_id = "DIC_MyFirstDictionary_refFirstDictionary.id";
        
            /// <summary>
            /// Decimal Value.
            /// </summary>
            public const string DecimalValue = "DecimalValue";
        
            /// <summary>
            /// Decimal Value, ������������ �������.
            /// </summary>
            public const string DecimalValueFilterName = "DecimalValue";
        
            /// <summary>
            /// Boolean Value.
            /// </summary>
            public const string BoolValue = "BoolValue";
        
            /// <summary>
            /// Boolean Value, ������������ �������.
            /// </summary>
            public const string BoolValueFilterName = "BoolValue";
        
            /// <summary>
            /// timestamp.
            /// </summary>
            public const string RowVersion = "RowVersion";
        
            /// <summary>
            /// timestamp, ������������ �������.
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
            builder.UserControl = "DIC_MySecondDictionaryFilter";
            builder.IsFilterWindow = true;
            return builder;
        }

        public static string GetUserControlName()
        {
            return "DIC_MySecondDictionaryFilter";
        }
    }
}
#pragma warning restore