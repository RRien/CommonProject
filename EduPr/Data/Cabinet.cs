using System;
using System.Collections.Generic;

namespace EduPr.Data;

public partial class Cabinet
{
    public int IdCabinet { get; set; }

    public string NumberCabinet { get; set; } = null!;

    public int? IdDepartment { get; set; }

    public virtual ICollection<Appointment> Appointments { get; } = new List<Appointment>();

    public virtual ICollection<DoctorSchedule> DoctorSchedules { get; } = new List<DoctorSchedule>();

    public virtual Department? IdDepartmentNavigation { get; set; }
}
