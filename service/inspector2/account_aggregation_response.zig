const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// An aggregation of findings by Amazon Web Services account ID.
pub const AccountAggregationResponse = struct {
    /// The Amazon Web Services account ID.
    account_id: ?[]const u8 = null,

    /// The number of findings that have an exploit available.
    exploit_available_count: ?i64 = null,

    /// Details about the number of fixes.
    fix_available_count: ?i64 = null,

    /// The number of findings by severity.
    severity_counts: ?SeverityCounts = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .exploit_available_count = "exploitAvailableCount",
        .fix_available_count = "fixAvailableCount",
        .severity_counts = "severityCounts",
    };
};
