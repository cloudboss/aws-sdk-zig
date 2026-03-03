const ApplicationDeploymentLifecycle = @import("application_deployment_lifecycle.zig").ApplicationDeploymentLifecycle;
const EngineType = @import("engine_type.zig").EngineType;
const ApplicationLifecycle = @import("application_lifecycle.zig").ApplicationLifecycle;
const ApplicationVersionLifecycle = @import("application_version_lifecycle.zig").ApplicationVersionLifecycle;

/// A subset of the possible application attributes. Used in the application
/// list.
pub const ApplicationSummary = struct {
    /// The Amazon Resource Name (ARN) of the application.
    application_arn: []const u8,

    /// The unique identifier of the application.
    application_id: []const u8,

    /// The version of the application.
    application_version: i32,

    /// The timestamp when the application was created.
    creation_time: i64,

    /// Indicates either an ongoing deployment or if the application has ever
    /// deployed
    /// successfully.
    deployment_status: ?ApplicationDeploymentLifecycle = null,

    /// The description of the application.
    description: ?[]const u8 = null,

    /// The type of the target platform for this application.
    engine_type: EngineType,

    /// The unique identifier of the runtime environment that hosts this
    /// application.
    environment_id: ?[]const u8 = null,

    /// The timestamp when you last started the application. Null until the
    /// application runs for
    /// the first time.
    last_start_time: ?i64 = null,

    /// The name of the application.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the role associated with the application.
    role_arn: ?[]const u8 = null,

    /// The status of the application.
    status: ApplicationLifecycle,

    /// Indicates the status of the latest version of the application.
    version_status: ?ApplicationVersionLifecycle = null,

    pub const json_field_names = .{
        .application_arn = "applicationArn",
        .application_id = "applicationId",
        .application_version = "applicationVersion",
        .creation_time = "creationTime",
        .deployment_status = "deploymentStatus",
        .description = "description",
        .engine_type = "engineType",
        .environment_id = "environmentId",
        .last_start_time = "lastStartTime",
        .name = "name",
        .role_arn = "roleArn",
        .status = "status",
        .version_status = "versionStatus",
    };
};
