const Tag = @import("tag.zig").Tag;

/// Contains the details of a tenant database in a snapshot of a DB instance.
pub const DBSnapshotTenantDatabase = struct {
    /// The name of the character set of a tenant database.
    character_set_name: ?[]const u8 = null,

    /// The ID for the DB instance that contains the tenant databases.
    db_instance_identifier: ?[]const u8 = null,

    /// The resource identifier of the source CDB instance. This identifier can't be
    /// changed and is unique to an Amazon Web Services Region.
    dbi_resource_id: ?[]const u8 = null,

    /// The identifier for the snapshot of the DB instance.
    db_snapshot_identifier: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the snapshot tenant database.
    db_snapshot_tenant_database_arn: ?[]const u8 = null,

    /// The name of the database engine.
    engine_name: ?[]const u8 = null,

    /// The master username of the tenant database.
    master_username: ?[]const u8 = null,

    /// The `NCHAR` character set name of the tenant database.
    nchar_character_set_name: ?[]const u8 = null,

    /// The type of DB snapshot.
    snapshot_type: ?[]const u8 = null,

    tag_list: ?[]const Tag = null,

    /// The time the DB snapshot was taken, specified in Coordinated Universal Time
    /// (UTC). If you copy the snapshot, the creation time changes.
    tenant_database_create_time: ?i64 = null,

    /// The resource ID of the tenant database.
    tenant_database_resource_id: ?[]const u8 = null,

    /// The name of the tenant database.
    tenant_db_name: ?[]const u8 = null,
};
