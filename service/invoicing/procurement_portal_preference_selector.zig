/// Specifies criteria for selecting which invoices should be processed using a
/// particular procurement portal preference.
pub const ProcurementPortalPreferenceSelector = struct {
    /// The Amazon Resource Name (ARN) of invoice unit identifiers to which this
    /// preference applies.
    invoice_unit_arns: ?[]const []const u8 = null,

    /// The list of seller of record IDs to which this preference applies.
    seller_of_records: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .invoice_unit_arns = "InvoiceUnitArns",
        .seller_of_records = "SellerOfRecords",
    };
};
