using System;
using System.Collections.Generic;

namespace EduPr.Data;

public partial class Medication
{
    public int IdMedication { get; set; }

    public string NameMedication { get; set; } = null!;

    public virtual ICollection<MedicationPrescription> MedicationPrescriptions { get; } = new List<MedicationPrescription>();
}
