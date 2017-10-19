// ReSharper disable once CheckNamespace

namespace SampleDictionaries.UserControls
{
    using System;

    public partial class MyProductsEdit
    {
        partial void InsertLogic()
        {
            if (IsStartAction)
            {
                Info.Amount = 0;
                Info.CreationDate = DateTime.Today;
            }
        }
    }

    internal partial class MyProductsActivityController
    {
        partial void InitializeActivity()
        {
        }
    }
}