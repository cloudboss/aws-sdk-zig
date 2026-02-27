const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// An aggregation of findings by Amazon Web Services account ID.
pub const AccountAggregationResponse = struct {
    /// The Amazon Web Services account ID.
    account_id: ?[]const u8,

    /// The number of findings that have an exploit available.
    exploit_available_count: ?i64,

    /// Details about the number of fixes.
    fix_available_count: ?i64,

    /// The number of findings by severity.
    severity_counts: ?SeverityCounts,

    pub const json_field_names = .{
        .account_id = "accountId",
        .exploit_available_count = "exploitAvailableCount",
        .fix_available_count = "fixAvailableCount",
        .severity_counts = "severityCounts",
    };
};
