using Avalonia.Controls;
using Avalonia.Input;
using Avalonia.Interactivity;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using EduPr.Data;

namespace EduPr;

public partial class PaymentsList : UserControl
{
    public PaymentsList()
    {
        InitializeComponent();
        LoadPayments("", "Все статусы");
    }

    private void LoadPayments(string searchText, string statusFilter)
    {
        var db = new AppDbContext();
        var payments = db.Invoices
            .Include(i => i.IdPatientNavigation)
            .Include(i => i.IdPaymentStatusNavigation)
            .ToList();

        if (!string.IsNullOrWhiteSpace(searchText))
        {
            payments = payments.Where(i =>
                (i.IdPatientNavigation?.LastNamePatient?.Contains(searchText) ?? false) ||
                (i.IdPatientNavigation?.FirstNamePatient?.Contains(searchText) ?? false)
            ).ToList();
        }

        if (!string.IsNullOrWhiteSpace(statusFilter) && statusFilter != "Все статусы")
        {
            payments = payments.Where(i => i.IdPaymentStatusNavigation.NamePaymentStatus == statusFilter).ToList();
        }

        PaymentsGrid.ItemsSource = payments.OrderByDescending(i => i.IssueDateInvoice).ToList();
    }

    private string GetSelectedStatus()
    {
        var selectedItem = statusFilter.SelectedItem as ComboBoxItem;
        var status = selectedItem?.Content?.ToString();

        return status;
    }

    private void Search_TextChanged(object? sender, TextChangedEventArgs e)
    {
        LoadPayments(searchTb.Text, GetSelectedStatus());
    }
    private void StatusFilter_Changed(object? sender, SelectionChangedEventArgs e)
    {
        LoadPayments(searchTb.Text, GetSelectedStatus());
    }
    private void Search_Click(object? sender, RoutedEventArgs e)
    {
        LoadPayments(searchTb.Text, GetSelectedStatus());
    }

    private async void Payment_DoubleTapped(object? sender, TappedEventArgs e)
    {
        var selected = PaymentsGrid.SelectedItem as Invoice;
        if (selected == null) return;

        var card = new PaymentCard(selected.IdInvoice);
        await card.ShowDialog(this.VisualRoot as Window);
        LoadPayments(searchTb.Text, GetSelectedStatus());
    }

    private async void AddPayment_Click(object? sender, RoutedEventArgs e)
    {
        var card = new PaymentCard(0);
        await card.ShowDialog(this.VisualRoot as Window);
        LoadPayments(searchTb.Text, GetSelectedStatus());
    }
}