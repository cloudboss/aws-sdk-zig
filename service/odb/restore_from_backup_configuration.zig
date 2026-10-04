const CloneType = @import("clone_type.zig").CloneType;

/// The configuration for creating an Autonomous Database by restoring from a
/// backup.
pub const RestoreFromBackupConfiguration = struct {
    /// The unique identifier of the Autonomous Database backup to restore from.
    autonomous_database_backup_id: []const u8,

    /// The list of tablespace identifiers to clone from the backup.
    clone_table_space_list: ?[]const i32 = null,

    /// The type of clone to create from the backup.
    clone_type: CloneType,

    pub const json_field_names = .{
        .autonomous_database_backup_id = "autonomousDatabaseBackupId",
        .clone_table_space_list = "cloneTableSpaceList",
        .clone_type = "cloneType",
    };
};
