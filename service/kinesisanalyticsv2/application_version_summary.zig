const ApplicationStatus = @import("application_status.zig").ApplicationStatus;

/// The summary of the application version.
pub const ApplicationVersionSummary = struct {
    /// The status of the application.
    application_status: ApplicationStatus,

    /// The ID of the application version. Managed Service for Apache Flink updates
    /// the `ApplicationVersionId` each time you update the application.
    application_version_id: i64,

    pub const json_field_names = .{
        .application_status = "ApplicationStatus",
        .application_version_id = "ApplicationVersionId",
    };
};
