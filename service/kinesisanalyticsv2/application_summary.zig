const ApplicationMode = @import("application_mode.zig").ApplicationMode;
const ApplicationStatus = @import("application_status.zig").ApplicationStatus;
const RuntimeEnvironment = @import("runtime_environment.zig").RuntimeEnvironment;

/// Provides application summary information, including the application Amazon
/// Resource Name (ARN), name, and status.
pub const ApplicationSummary = struct {
    /// The ARN of the application.
    application_arn: []const u8,

    /// For a Managed Service for Apache Flink application, the mode is `STREAMING`.
    /// For a Managed Service for Apache Flink Studio notebook, it is `INTERACTIVE`.
    application_mode: ?ApplicationMode,

    /// The name of the application.
    application_name: []const u8,

    /// The status of the application.
    application_status: ApplicationStatus,

    /// Provides the current application version.
    application_version_id: i64,

    /// The runtime environment for the application.
    runtime_environment: RuntimeEnvironment,

    pub const json_field_names = .{
        .application_arn = "ApplicationARN",
        .application_mode = "ApplicationMode",
        .application_name = "ApplicationName",
        .application_status = "ApplicationStatus",
        .application_version_id = "ApplicationVersionId",
        .runtime_environment = "RuntimeEnvironment",
    };
};
