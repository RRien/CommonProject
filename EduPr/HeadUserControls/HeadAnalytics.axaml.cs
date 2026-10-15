using Avalonia;
using Avalonia.Controls;
using Avalonia.Markup.Xaml;
using EduPr.Data;
using System.Linq;

namespace EduPr;

public partial class HeadAnalytics : UserControl
{
    public HeadAnalytics()
    {
        InitializeComponent();
        LoadStatystics();
    }
    private void LoadStatystics()
    {
        using var db = new AppDbContext();
        int totalAppointments = db.Appointments.Count();
        AllAppointments.Text = totalAppointments.ToString();

        decimal totalRevenue = db.Invoices.Sum(i => i.FinalAmountInvoice);
        txtTotalRevenue.Text = $"{totalRevenue:0.00} ₽";

        int totalDoctors = db.Doctors.Count();
        txtTotalDoctors.Text = totalDoctors.ToString();
    }
}


