const RegionalSummary = @import("regional_summary.zig").RegionalSummary;

/// A summary report for the attribute across all Regions.
pub const AttributeSummary = struct {
    /// The name of the attribute.
    attribute_name: ?[]const u8,

    /// The configuration value that is most frequently observed for the attribute.
    most_frequent_value: ?[]const u8,

    /// The number of accounts with the same configuration value for the attribute
    /// that is
    /// most frequently observed.
    number_of_matched_accounts: ?i32,

    /// The number of accounts with a configuration value different from the most
    /// frequently
    /// observed value for the attribute.
    number_of_unmatched_accounts: ?i32,

    /// The summary report for each Region for the attribute.
    regional_summaries: ?[]const RegionalSummary,
};
