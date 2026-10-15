using System;
using System.Collections.Generic;

namespace EduPr.Data;

public partial class Patient
{
    public int IdPatient { get; set; }

    public string FirstNamePatient { get; set; } = null!;

    public string LastNamePatient { get; set; } = null!;

    public string? MiddleNamePatient { get; set; }

    public string? PhonePatient { get; set; }

    public DateOnly? BirthDatePatient { get; set; }

    public DateTime? CreatedPatient { get; set; }

    public virtual ICollection<Appointment> Appointments { get; } = new List<Appointment>();

    public virtual ICollection<Invoice> Invoices { get; } = new List<Invoice>();

    public virtual MedicalCard? MedicalCard { get; set; }

    public virtual ICollection<Review> Reviews { get; } = new List<Review>();
}
