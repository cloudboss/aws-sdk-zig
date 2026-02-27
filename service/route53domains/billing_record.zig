const OperationType = @import("operation_type.zig").OperationType;

/// Information for one billing record.
pub const BillingRecord = struct {
    /// The date that the operation was billed, in Unix format.
    bill_date: ?i64,

    /// The name of the domain that the billing record applies to. If the domain
    /// name contains
    /// characters other than a-z, 0-9, and - (hyphen), such as an internationalized
    /// domain
    /// name, then this value is in Punycode. For more information, see [DNS
    /// Domain Name
    /// Format](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/DomainNameFormat.html) in the *Amazon Route 53 Developer
    /// Guide*.
    domain_name: ?[]const u8,

    /// Deprecated property. This field is retained in report structure for
    /// backwards compatibility, but will appear blank.
    invoice_id: ?[]const u8,

    /// The operation that you were charged for.
    operation: ?OperationType,

    /// The price that you were charged for the operation, in US dollars.
    ///
    /// Example value: 12.0
    price: f64 = 0,

    pub const json_field_names = .{
        .bill_date = "BillDate",
        .domain_name = "DomainName",
        .invoice_id = "InvoiceId",
        .operation = "Operation",
        .price = "Price",
    };
};
