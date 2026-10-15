using System;
using System.Collections.Generic;

namespace EduPr.Data;

public partial class Specialization
{
    public int IdSpecialization { get; set; }

    public string NameSpecialization { get; set; } = null!;

    public virtual ICollection<Doctor> Doctors { get; } = new List<Doctor>();
}
