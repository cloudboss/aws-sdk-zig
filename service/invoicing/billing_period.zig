/// The billing period for which you want to retrieve invoice-related documents.
pub const BillingPeriod = struct {
    /// The billing period month.
    month: i32,

    /// The billing period year.
    year: i32,

    pub const json_field_names = .{
        .month = "Month",
        .year = "Year",
    };
};
