using System;
using System.Collections.Generic;

namespace EduPr.Data;

public partial class PaymentStatus
{
    public int IdPaymentStatus { get; set; }

    public string NamePaymentStatus { get; set; } = null!;

    public virtual ICollection<Invoice> Invoices { get; } = new List<Invoice>();
}
