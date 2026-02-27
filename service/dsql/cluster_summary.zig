/// A summary of the properties of a cluster.
pub const ClusterSummary = struct {
    /// The ARN of the cluster.
    arn: []const u8,

    /// The ID of the cluster.
    identifier: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .identifier = "identifier",
    };
};
