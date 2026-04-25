/// The billing period for an invoice, specified by month and year.
pub const InvoiceBillingPeriod = struct {
    /// The billing period month. Valid range: 1-12.
    month: i32,

    /// The billing period year.
    year: i32,

    pub const json_field_names = .{
        .month = "month",
        .year = "year",
    };
};
