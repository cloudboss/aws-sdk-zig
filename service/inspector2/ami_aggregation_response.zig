const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// A response that contains the results of a finding aggregation by AMI.
pub const AmiAggregationResponse = struct {
    /// The Amazon Web Services account ID for the AMI.
    account_id: ?[]const u8 = null,

    /// The IDs of Amazon EC2 instances using this AMI.
    affected_instances: ?i64 = null,

    /// The ID of the AMI that findings were aggregated for.
    ami: []const u8,

    /// An object that contains the count of matched findings per severity.
    severity_counts: ?SeverityCounts = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .affected_instances = "affectedInstances",
        .ami = "ami",
        .severity_counts = "severityCounts",
    };
};
