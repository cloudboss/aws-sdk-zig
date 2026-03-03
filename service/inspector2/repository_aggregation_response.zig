const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// A response that contains details on the results of a finding aggregation by
/// repository.
pub const RepositoryAggregationResponse = struct {
    /// The ID of the Amazon Web Services account associated with the findings.
    account_id: ?[]const u8 = null,

    /// The number of container images impacted by the findings.
    affected_images: ?i64 = null,

    /// The name of the repository associated with the findings.
    repository: []const u8,

    /// An object that represent the count of matched findings per severity.
    severity_counts: ?SeverityCounts = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .affected_images = "affectedImages",
        .repository = "repository",
        .severity_counts = "severityCounts",
    };
};
