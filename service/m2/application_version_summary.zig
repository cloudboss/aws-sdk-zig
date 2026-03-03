const ApplicationVersionLifecycle = @import("application_version_lifecycle.zig").ApplicationVersionLifecycle;

/// Defines an application version summary.
pub const ApplicationVersionSummary = struct {
    /// The application version.
    application_version: i32,

    /// The timestamp when the application version was created.
    creation_time: i64,

    /// The status of the application.
    status: ApplicationVersionLifecycle,

    /// The reason for the reported status.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_version = "applicationVersion",
        .creation_time = "creationTime",
        .status = "status",
        .status_reason = "statusReason",
    };
};
