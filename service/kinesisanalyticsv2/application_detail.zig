const ApplicationConfigurationDescription = @import("application_configuration_description.zig").ApplicationConfigurationDescription;
const ApplicationMaintenanceConfigurationDescription = @import("application_maintenance_configuration_description.zig").ApplicationMaintenanceConfigurationDescription;
const ApplicationMode = @import("application_mode.zig").ApplicationMode;
const ApplicationStatus = @import("application_status.zig").ApplicationStatus;
const CloudWatchLoggingOptionDescription = @import("cloud_watch_logging_option_description.zig").CloudWatchLoggingOptionDescription;
const RuntimeEnvironment = @import("runtime_environment.zig").RuntimeEnvironment;

/// Describes the application, including the application Amazon Resource Name
/// (ARN), status,
/// latest version, and input and output configurations.
pub const ApplicationDetail = struct {
    /// The ARN of the application.
    application_arn: []const u8,

    /// Describes details about the application code and starting parameters for a
    /// Managed Service for Apache Flink application.
    application_configuration_description: ?ApplicationConfigurationDescription = null,

    /// The description of the application.
    application_description: ?[]const u8 = null,

    /// The details of the maintenance configuration for the application.
    application_maintenance_configuration_description: ?ApplicationMaintenanceConfigurationDescription = null,

    /// To create a Managed Service for Apache Flink Studio notebook, you must set
    /// the mode to `INTERACTIVE`. However, for a Managed Service for Apache Flink
    /// application, the mode is optional.
    application_mode: ?ApplicationMode = null,

    /// The name of the application.
    application_name: []const u8,

    /// The status of the application.
    application_status: ApplicationStatus,

    /// The timestamp that indicates when the application version was created.
    application_version_create_timestamp: ?i64 = null,

    /// Provides the current application version. Managed Service for Apache Flink
    /// updates the
    /// `ApplicationVersionId` each time you update the application.
    application_version_id: i64,

    /// If you reverted the application using RollbackApplication,
    /// the application version when `RollbackApplication` was called.
    application_version_rolled_back_from: ?i64 = null,

    /// The version to which you want to roll back the application.
    application_version_rolled_back_to: ?i64 = null,

    /// The previous application version before the latest application update.
    /// RollbackApplication
    /// reverts the application to this version.
    application_version_updated_from: ?i64 = null,

    /// Describes the application Amazon CloudWatch logging options.
    cloud_watch_logging_option_descriptions: ?[]const CloudWatchLoggingOptionDescription = null,

    /// A value you use to implement strong concurrency for application updates.
    conditional_token: ?[]const u8 = null,

    /// The current timestamp when the application was created.
    create_timestamp: ?i64 = null,

    /// The current timestamp when the application was last updated.
    last_update_timestamp: ?i64 = null,

    /// The runtime environment for the application.
    runtime_environment: RuntimeEnvironment,

    /// Specifies the IAM role that the application uses to access external
    /// resources.
    service_execution_role: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_arn = "ApplicationARN",
        .application_configuration_description = "ApplicationConfigurationDescription",
        .application_description = "ApplicationDescription",
        .application_maintenance_configuration_description = "ApplicationMaintenanceConfigurationDescription",
        .application_mode = "ApplicationMode",
        .application_name = "ApplicationName",
        .application_status = "ApplicationStatus",
        .application_version_create_timestamp = "ApplicationVersionCreateTimestamp",
        .application_version_id = "ApplicationVersionId",
        .application_version_rolled_back_from = "ApplicationVersionRolledBackFrom",
        .application_version_rolled_back_to = "ApplicationVersionRolledBackTo",
        .application_version_updated_from = "ApplicationVersionUpdatedFrom",
        .cloud_watch_logging_option_descriptions = "CloudWatchLoggingOptionDescriptions",
        .conditional_token = "ConditionalToken",
        .create_timestamp = "CreateTimestamp",
        .last_update_timestamp = "LastUpdateTimestamp",
        .runtime_environment = "RuntimeEnvironment",
        .service_execution_role = "ServiceExecutionRole",
    };
};
