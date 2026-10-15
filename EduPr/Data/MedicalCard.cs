using System;
using System.Collections.Generic;

namespace EduPr.Data;

public partial class MedicalCard
{
    public int IdMedicalCard { get; set; }

    public int IdPatient { get; set; }

    public DateTime? CreatedCard { get; set; }

    public virtual Patient IdPatientNavigation { get; set; } = null!;
}
