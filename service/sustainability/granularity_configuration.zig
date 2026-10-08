/// Contains configuration for the fiscal year granularities (e.g.,
/// `YEARLY_FISCAL`, `QUARTERLY_FISCAL`.
pub const GranularityConfiguration = struct {
    /// The month (1-12) when the fiscal year begins. Used for `YEARLY_FISCAL` and
    /// `QUARTERLY_FISCAL` granularity. Defaults to 1 (January).
    fiscal_year_start_month: i32 = 1,

    pub const json_field_names = .{
        .fiscal_year_start_month = "FiscalYearStartMonth",
    };
};
