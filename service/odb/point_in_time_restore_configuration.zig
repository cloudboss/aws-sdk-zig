const CloneType = @import("clone_type.zig").CloneType;

/// The configuration for creating an Autonomous Database by restoring to a
/// point in time.
pub const PointInTimeRestoreConfiguration = struct {
    /// The list of tablespace identifiers to clone from the point-in-time restore.
    clone_table_space_list: ?[]const i32 = null,

    /// The type of clone to create from the point-in-time restore.
    clone_type: CloneType,

    /// The unique identifier of the source Autonomous Database to restore from.
    source_autonomous_database_id: []const u8,

    /// The date and time to which to restore the Autonomous Database.
    timestamp: ?i64 = null,

    /// Indicates whether to use the latest available backup timestamp for the
    /// restore.
    use_latest_available_backup_timestamp: ?bool = null,

    pub const json_field_names = .{
        .clone_table_space_list = "cloneTableSpaceList",
        .clone_type = "cloneType",
        .source_autonomous_database_id = "sourceAutonomousDatabaseId",
        .timestamp = "timestamp",
        .use_latest_available_backup_timestamp = "useLatestAvailableBackupTimestamp",
    };
};
