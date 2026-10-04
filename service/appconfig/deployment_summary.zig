const GrowthType = @import("growth_type.zig").GrowthType;
const DeploymentState = @import("deployment_state.zig").DeploymentState;
const DeploymentType = @import("deployment_type.zig").DeploymentType;

/// Information about the deployment.
pub const DeploymentSummary = struct {
    /// Time the deployment completed.
    completed_at: ?i64 = null,

    /// The name of the configuration.
    configuration_name: ?[]const u8 = null,

    /// The ID of the configuration profile that was deployed.
    configuration_profile_id: ?[]const u8 = null,

    /// The version of the configuration.
    configuration_version: ?[]const u8 = null,

    /// Total amount of time the deployment lasted.
    deployment_duration_in_minutes: i32 = 0,

    /// The sequence number of the deployment.
    deployment_number: i32 = 0,

    /// The amount of time that AppConfig monitors for alarms before considering the
    /// deployment to be complete and no longer eligible for automatic rollback.
    final_bake_time_in_minutes: i32 = 0,

    /// The percentage of targets to receive a deployed configuration during each
    /// interval.
    growth_factor: ?f32 = null,

    /// The algorithm used to define how percentage grows over time.
    growth_type: ?GrowthType = null,

    /// The percentage of targets for which the deployment is available.
    percentage_complete: ?f32 = null,

    /// Time the deployment started.
    started_at: ?i64 = null,

    /// The state of the deployment.
    state: ?DeploymentState = null,

    /// The type of deployment.
    @"type": ?DeploymentType = null,

    /// A user-defined label for an AppConfig hosted configuration version.
    version_label: ?[]const u8 = null,

    pub const json_field_names = .{
        .completed_at = "CompletedAt",
        .configuration_name = "ConfigurationName",
        .configuration_profile_id = "ConfigurationProfileId",
        .configuration_version = "ConfigurationVersion",
        .deployment_duration_in_minutes = "DeploymentDurationInMinutes",
        .deployment_number = "DeploymentNumber",
        .final_bake_time_in_minutes = "FinalBakeTimeInMinutes",
        .growth_factor = "GrowthFactor",
        .growth_type = "GrowthType",
        .percentage_complete = "PercentageComplete",
        .started_at = "StartedAt",
        .state = "State",
        .@"type" = "Type",
        .version_label = "VersionLabel",
    };
};
