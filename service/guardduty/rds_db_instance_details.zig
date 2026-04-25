const Tag = @import("tag.zig").Tag;

/// Contains information about the resource type `RDSDBInstance` involved in a
/// GuardDuty finding.
pub const RdsDbInstanceDetails = struct {
    /// The identifier of the database cluster that contains the database instance
    /// ID involved in the finding.
    db_cluster_identifier: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that identifies the database instance
    /// involved in the finding.
    db_instance_arn: ?[]const u8 = null,

    /// The identifier associated to the database instance that was involved in the
    /// finding.
    db_instance_identifier: ?[]const u8 = null,

    /// The unique ID of the database resource involved in the activity that
    /// prompted GuardDuty to generate the finding.
    dbi_resource_id: ?[]const u8 = null,

    /// The database engine of the database instance involved in the finding.
    engine: ?[]const u8 = null,

    /// The version of the database engine that was involved in the finding.
    engine_version: ?[]const u8 = null,

    /// Information about the tag key-value pairs.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .db_cluster_identifier = "DbClusterIdentifier",
        .db_instance_arn = "DbInstanceArn",
        .db_instance_identifier = "DbInstanceIdentifier",
        .dbi_resource_id = "DbiResourceId",
        .engine = "Engine",
        .engine_version = "EngineVersion",
        .tags = "Tags",
    };
};
