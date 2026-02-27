const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// A response that contains the results of a finding aggregation by image
/// layer.
pub const PackageAggregationResponse = struct {
    /// The ID of the Amazon Web Services account associated with the findings.
    account_id: ?[]const u8,

    /// The name of the operating system package.
    package_name: []const u8,

    /// An object that contains the count of matched findings per severity.
    severity_counts: ?SeverityCounts,

    pub const json_field_names = .{
        .account_id = "accountId",
        .package_name = "packageName",
        .severity_counts = "severityCounts",
    };
};
