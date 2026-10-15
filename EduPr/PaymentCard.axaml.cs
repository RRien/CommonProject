using Avalonia;
using Avalonia.Controls;
using Avalonia.Interactivity;
using Avalonia.Markup.Xaml;
using EduPr.Data;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace EduPr;

public partial class PaymentCard : Window
{
    Invoice inv;
    private int _invoiceId;
    private bool _isNewInvoice;
    public PaymentCard(int invoiceId = 0)
    {
        InitializeComponent();
        _invoiceId = invoiceId;
        _isNewInvoice = invoiceId == 0;

        LoadDictionaries();
        if (!_isNewInvoice) LoadData();
        else dpDate.SelectedDate = DateTime.Now;
    }

    private void LoadDictionaries()
    {
        var db = new AppDbContext();
        cmbPatient.ItemsSource = db.Patients.OrderBy(p => p.LastNamePatient).ToList();
    }

    private void LoadData()
    {
        var db = new AppDbContext();
        var inv = db.Invoices
            .Include(i => i.IdPaymentStatusNavigation)
            .FirstOrDefault(i => i.IdInvoice == _invoiceId);

        if (inv == null) return;

        cmbPatient.SelectedItem = cmbPatient.Items.FirstOrDefault(p => ((Patient)p).IdPatient == inv.IdPatient);
        dpDate.SelectedDate = inv.IssueDateInvoice;
        numTotal.Value = inv.TotalAmountInvoice;
        numDiscount.Value = inv.DiscountInvoice;
        UpdateFinalAmount();

        string targetStatus = inv.IdPaymentStatusNavigation?.NamePaymentStatus?.Trim() ?? "";
        foreach (ComboBoxItem item in cmbStatus.Items)
        {
            if (item.Content?.ToString()?.Trim() == targetStatus)
            {
                cmbStatus.SelectedItem = item;
                break;
            }
        }
    }
    private void Amount_ValueChanged(object? sender, NumericUpDownValueChangedEventArgs e)
    {
        UpdateFinalAmount();
    }

    private void UpdateFinalAmount()
    {
        double total = (double)(numTotal.Value ?? 0);
        double discount = (double)(numDiscount.Value ?? 0);
        double final = Math.Max(0, total - discount);
        txtFinal.Text = $"{final:0.00} ₽";
    }

    private async void BtnSave_Click(object? sender, RoutedEventArgs e)
    {
        if (cmbPatient.SelectedItem == null || !dpDate.SelectedDate.HasValue)
        {
            await ShowError("Выберите пациента и дату!");
            return;
        }

        try
        {
            var db = new AppDbContext();
            var patient = (Patient)cmbPatient.SelectedItem;
            var statusText = ((ComboBoxItem?)cmbStatus.SelectedItem)?.Content?.ToString()?.Trim();
            var status = db.PaymentStatuses.FirstOrDefault(s => s.NamePaymentStatus == statusText);

            double total = (double)numTotal.Value;
            double discount = (double)numDiscount.Value;
            double final = Math.Max(0, total - discount);



            if (_isNewInvoice)
            {
                inv = new Invoice
                {
                    IdPatient = patient.IdPatient,
                    IssueDateInvoice = dpDate.SelectedDate.Value.DateTime,
                    TotalAmountInvoice = (decimal)total,
                    DiscountInvoice = (decimal)discount,
                    FinalAmountInvoice = (decimal)final
                };
                if (status != null) inv.IdPaymentStatus = status.IdPaymentStatus;
                db.Invoices.Add(inv);
            }
            else
            {
                inv = db.Invoices.Find(_invoiceId)!;
                inv.IdPatient = patient.IdPatient;
                inv.IssueDateInvoice = dpDate.SelectedDate.Value.DateTime;
                inv.TotalAmountInvoice = (decimal)total;
                inv.DiscountInvoice = (decimal)discount;
                inv.FinalAmountInvoice = (decimal)final;
                if (status != null) inv.IdPaymentStatus = status.IdPaymentStatus;
                db.Invoices.Update(inv);
            }

            await db.SaveChangesAsync();
            this.Close();
        }
        catch (Exception ex)
        {
            await ShowError($"Ошибка сохранения: {ex.Message}");
        }
    }

    private async Task ShowError(string message)
    {
        var win = new Window { Content = new TextBlock { Text = message, Foreground = Avalonia.Media.Brushes.Red }, Width = 350, Height = 150 };
        await win.ShowDialog(this);
    }

    private void BtnCancel_Click(object? sender, RoutedEventArgs e)
    {
        this.Close();
    }
}
