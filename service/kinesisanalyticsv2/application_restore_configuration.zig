const ApplicationRestoreType = @import("application_restore_type.zig").ApplicationRestoreType;

/// Specifies the method and snapshot to use when restarting an application
/// using previously saved application state.
pub const ApplicationRestoreConfiguration = struct {
    /// Specifies how the application should be restored.
    application_restore_type: ApplicationRestoreType,

    /// The identifier of an existing snapshot of application state to use to
    /// restart an application.
    /// The application uses this value if `RESTORE_FROM_CUSTOM_SNAPSHOT` is
    /// specified for the
    /// `ApplicationRestoreType`.
    snapshot_name: ?[]const u8,

    pub const json_field_names = .{
        .application_restore_type = "ApplicationRestoreType",
        .snapshot_name = "SnapshotName",
    };
};
