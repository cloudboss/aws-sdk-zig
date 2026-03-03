/// The results or descriptions for the additional metrics, based on whether the
/// metrics were or were not requested.
pub const SummaryMetricsResult = struct {
    /// The savings percentage based on your Amazon Web Services spend over the past
    /// 30 days.
    ///
    /// Savings percentage is only supported when filtering by Region, account ID,
    /// or tags.
    savings_percentage: ?[]const u8 = null,

    pub const json_field_names = .{
        .savings_percentage = "savingsPercentage",
    };
};
