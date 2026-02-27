const Tag = @import("tag.zig").Tag;

/// Contains information about the resource type `RDSLimitlessDB` that is
/// involved in a GuardDuty
/// finding.
pub const RdsLimitlessDbDetails = struct {
    /// The name of the database cluster that is a part of the Limitless Database.
    db_cluster_identifier: ?[]const u8,

    /// The Amazon Resource Name (ARN) that identifies the DB shard group.
    db_shard_group_arn: ?[]const u8,

    /// The name associated with the Limitless DB shard group.
    db_shard_group_identifier: ?[]const u8,

    /// The resource identifier of the DB shard group within the Limitless Database.
    db_shard_group_resource_id: ?[]const u8,

    /// The database engine of the database instance involved in the finding.
    engine: ?[]const u8,

    /// The version of the database engine.
    engine_version: ?[]const u8,

    /// Information about the tag key-value pair.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .db_cluster_identifier = "DbClusterIdentifier",
        .db_shard_group_arn = "DbShardGroupArn",
        .db_shard_group_identifier = "DbShardGroupIdentifier",
        .db_shard_group_resource_id = "DbShardGroupResourceId",
        .engine = "Engine",
        .engine_version = "EngineVersion",
        .tags = "Tags",
    };
};
