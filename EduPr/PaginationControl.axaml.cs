using Avalonia;
using Avalonia.Controls;
using Avalonia.Interactivity;
using Avalonia.Markup.Xaml;
using System;

namespace EduPr;

public partial class PaginationControl : UserControl
{
    public int CurrentPage { get; private set; } = 1;
    public int TotalPages { get; private set; } = 1;
    public int PageSize { get; set; } = 10;

    public event EventHandler<int>? PageChanged;

    public PaginationControl()
    {
        InitializeComponent();
        UpdatePageInfo();
    }

    public void SetTotalItems(int totalItems)
    {
        TotalPages = Math.Max(1, (int)Math.Ceiling((double)totalItems / PageSize));
        if (CurrentPage > TotalPages)
            CurrentPage = TotalPages;
        UpdatePageInfo();
    }

    private void BtnPrevious_Click(object? sender, RoutedEventArgs e)
    {
        if (CurrentPage > 1)
        {
            CurrentPage--;
            UpdatePageInfo();
            PageChanged?.Invoke(this, CurrentPage);
        }
    }

    private void BtnNext_Click(object? sender, RoutedEventArgs e)
    {
        if (CurrentPage < TotalPages)
        {
            CurrentPage++;
            UpdatePageInfo();
            PageChanged?.Invoke(this, CurrentPage);
        }
    }

    private void UpdatePageInfo()
    {
        PageNumber.Text = $"Страница {CurrentPage} из {TotalPages}";
    }
}