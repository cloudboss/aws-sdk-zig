const MasterUserSecret = @import("master_user_secret.zig").MasterUserSecret;
const TenantDatabasePendingModifiedValues = @import("tenant_database_pending_modified_values.zig").TenantDatabasePendingModifiedValues;
const Tag = @import("tag.zig").Tag;

/// A tenant database in the DB instance. This data type is an element in the
/// response to the `DescribeTenantDatabases` action.
pub const TenantDatabase = struct {
    /// The character set of the tenant database.
    character_set_name: ?[]const u8,

    /// The ID of the DB instance that contains the tenant database.
    db_instance_identifier: ?[]const u8,

    /// The Amazon Web Services Region-unique, immutable identifier for the DB
    /// instance.
    dbi_resource_id: ?[]const u8,

    /// Specifies whether deletion protection is enabled for the DB instance.
    deletion_protection: ?bool,

    /// The master username of the tenant database.
    master_username: ?[]const u8,

    master_user_secret: ?MasterUserSecret,

    /// The `NCHAR` character set name of the tenant database.
    nchar_character_set_name: ?[]const u8,

    /// Information about pending changes for a tenant database.
    pending_modified_values: ?TenantDatabasePendingModifiedValues,

    /// The status of the tenant database.
    status: ?[]const u8,

    tag_list: ?[]const Tag,

    /// The Amazon Resource Name (ARN) for the tenant database.
    tenant_database_arn: ?[]const u8,

    /// The creation time of the tenant database.
    tenant_database_create_time: ?i64,

    /// The Amazon Web Services Region-unique, immutable identifier for the tenant
    /// database.
    tenant_database_resource_id: ?[]const u8,

    /// The database name of the tenant database.
    tenant_db_name: ?[]const u8,
};
