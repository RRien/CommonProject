using System;
using System.Collections.Generic;

namespace EduPr.Data;

public partial class ServiceType
{
    public int IdServiceType { get; set; }

    public string NameServiceType { get; set; } = null!;

    public virtual ICollection<Service> Services { get; } = new List<Service>();
}
