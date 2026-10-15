using System;
using System.Collections.Generic;

namespace EduPr.Data;

public partial class MedicationPrescription
{
    public int IdPrescription { get; set; }

    public int IdAppointment { get; set; }

    public int IdMedication { get; set; }

    public string DosagePrescription { get; set; } = null!;

    public int? DurationDaysPrescription { get; set; }

    public string? InstructionsPrescription { get; set; }

    public virtual Appointment IdAppointmentNavigation { get; set; } = null!;

    public virtual Medication IdMedicationNavigation { get; set; } = null!;
}
