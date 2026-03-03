const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// A response that contains details on the results of a finding aggregation by
/// title.
pub const TitleAggregationResponse = struct {
    /// The ID of the Amazon Web Services account associated with the findings.
    account_id: ?[]const u8 = null,

    /// An object that represent the count of matched findings per severity.
    severity_counts: ?SeverityCounts = null,

    /// The title that the findings were aggregated on.
    title: []const u8,

    /// The vulnerability ID of the finding.
    vulnerability_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .severity_counts = "severityCounts",
        .title = "title",
        .vulnerability_id = "vulnerabilityId",
    };
};
