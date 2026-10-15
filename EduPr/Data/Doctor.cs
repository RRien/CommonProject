using System;
using System.Collections.Generic;

namespace EduPr.Data;

public partial class Doctor
{
    public int IdDoctor { get; set; }

    public string FirstNameDoctor { get; set; } = null!;

    public string LastNameDoctor { get; set; } = null!;

    public string? MiddleNameDoctor { get; set; }

    public string? PhoneDoctor { get; set; }

    public int IdSpecialization { get; set; }

    public int IdDepartment { get; set; }

    public int? IdUser { get; set; }

    public virtual ICollection<Appointment> Appointments { get; } = new List<Appointment>();

    public virtual ICollection<DoctorSchedule> DoctorSchedules { get; } = new List<DoctorSchedule>();

    public virtual Department IdDepartmentNavigation { get; set; } = null!;

    public virtual Specialization IdSpecializationNavigation { get; set; } = null!;

    public virtual User? IdUserNavigation { get; set; }

    public virtual ICollection<Review> Reviews { get; } = new List<Review>();

    public virtual ICollection<SpecialistSchedule> SpecialistSchedules { get; } = new List<SpecialistSchedule>();
}
