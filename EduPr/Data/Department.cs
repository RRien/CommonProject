using System;
using System.Collections.Generic;

namespace EduPr.Data;

public partial class Department
{
    public int IdDepartment { get; set; }

    public string NameDepartment { get; set; } = null!;

    public virtual ICollection<Cabinet> Cabinets { get; } = new List<Cabinet>();

    public virtual ICollection<Doctor> Doctors { get; } = new List<Doctor>();
}
