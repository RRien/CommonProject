using Avalonia;
using Avalonia.Controls;
using Avalonia.Input;
using Avalonia.Interactivity;
using Avalonia.Markup.Xaml;
using EduPr.Data;
using EduPr.Models;
using System.Linq;

namespace EduPr;

public partial class PatientList : UserControl
{
    public PatientList()
    {
        InitializeComponent();
        LoadPatients("");
    }

    private void LoadPatients(string searchText)
    {
        var context = new AppDbContext();
        var patientsList = context.Patients.ToList();

        if (!string.IsNullOrWhiteSpace(searchText))
        {
            patientsList = patientsList.Where(p =>
                p.LastNamePatient.Contains(searchText) ||
                p.FirstNamePatient.Contains(searchText) ||
                p.PhonePatient.Contains(searchText)
            ).ToList();
        }

        DataItems.ItemsSource = patientsList.OrderBy(p => p.LastNamePatient).ToList();
    }
    private void SearchTC(object? sender, TextChangedEventArgs e)
    {
        LoadPatients(searchPatientTb.Text);
    }

    private void SearchPatient(object? sender, RoutedEventArgs e)
    {
        LoadPatients(searchPatientTb.Text);
    }

    private async void TblPatients_DoubleTapped(object? sender, TappedEventArgs e)
    {
        var selectedPatient = DataItems.SelectedItem as Patient;
        if (selectedPatient == null) return;

        ContextData.SelectedPatient = selectedPatient;
        var cardWindow = new CardMedPatient(selectedPatient.IdPatient);
        await cardWindow.ShowDialog(this.VisualRoot as Window);
        LoadPatients(searchPatientTb.Text);
    }

    private async void AddPatBtn_Click(object? sender, RoutedEventArgs e)
    {
        ContextData.SelectedPatient = null;
        var createdWindow = new CardMedPatient(0);
        await createdWindow.ShowDialog(this.VisualRoot as Window);
        LoadPatients(searchPatientTb.Text);
    }
}
