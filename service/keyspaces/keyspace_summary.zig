const rs = @import("rs.zig").rs;

/// Represents the properties of a keyspace.
pub const KeyspaceSummary = struct {
    /// The name of the keyspace.
    keyspace_name: []const u8,

    /// If the `replicationStrategy` of the keyspace is `MULTI_REGION`, a list of
    /// replication Regions is returned.
    replication_regions: ?[]const []const u8,

    /// This property specifies if a keyspace is a single Region keyspace or a
    /// multi-Region keyspace. The available values are `SINGLE_REGION` or
    /// `MULTI_REGION`.
    replication_strategy: rs,

    /// The unique identifier of the keyspace in the format of an Amazon Resource
    /// Name (ARN).
    resource_arn: []const u8,

    pub const json_field_names = .{
        .keyspace_name = "keyspaceName",
        .replication_regions = "replicationRegions",
        .replication_strategy = "replicationStrategy",
        .resource_arn = "resourceArn",
    };
};
