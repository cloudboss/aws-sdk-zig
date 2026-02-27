const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// A response that contains the results of a finding type aggregation.
pub const FindingTypeAggregationResponse = struct {
    /// The ID of the Amazon Web Services account associated with the findings.
    account_id: ?[]const u8,

    /// The number of findings that have an exploit available.
    exploit_available_count: ?i64,

    /// Details about the number of fixes.
    fix_available_count: ?i64,

    /// The value to sort results by.
    severity_counts: ?SeverityCounts,

    pub const json_field_names = .{
        .account_id = "accountId",
        .exploit_available_count = "exploitAvailableCount",
        .fix_available_count = "fixAvailableCount",
        .severity_counts = "severityCounts",
    };
};
