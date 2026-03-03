/// Describes a pending database value modification.
pub const PendingModifiedRelationalDatabaseValues = struct {
    /// A Boolean value indicating whether automated backup retention is enabled.
    backup_retention_enabled: ?bool = null,

    /// The database engine version.
    engine_version: ?[]const u8 = null,

    /// The password for the master user of the database.
    master_user_password: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_retention_enabled = "backupRetentionEnabled",
        .engine_version = "engineVersion",
        .master_user_password = "masterUserPassword",
    };
};
