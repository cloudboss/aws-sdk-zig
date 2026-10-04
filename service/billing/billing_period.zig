/// A specific billing period identified by year and month.
pub const BillingPeriod = struct {
    /// The month of the billing period as an integer between 1 and 12.
    month: i32,

    /// The four-digit year of the billing period.
    year: i32,

    pub const json_field_names = .{
        .month = "month",
        .year = "year",
    };
};
