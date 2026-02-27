const GrowthType = @import("growth_type.zig").GrowthType;
const ReplicateTo = @import("replicate_to.zig").ReplicateTo;

pub const DeploymentStrategy = struct {
    /// Total amount of time the deployment lasted.
    deployment_duration_in_minutes: i32 = 0,

    /// The description of the deployment strategy.
    description: ?[]const u8,

    /// The amount of time that AppConfig monitored for alarms before considering
    /// the
    /// deployment to be complete and no longer eligible for automatic rollback.
    final_bake_time_in_minutes: i32 = 0,

    /// The percentage of targets that received a deployed configuration during each
    /// interval.
    growth_factor: ?f32,

    /// The algorithm used to define how percentage grew over time.
    growth_type: ?GrowthType,

    /// The deployment strategy ID.
    id: ?[]const u8,

    /// The name of the deployment strategy.
    name: ?[]const u8,

    /// Save the deployment strategy to a Systems Manager (SSM) document.
    replicate_to: ?ReplicateTo,

    pub const json_field_names = .{
        .deployment_duration_in_minutes = "DeploymentDurationInMinutes",
        .description = "Description",
        .final_bake_time_in_minutes = "FinalBakeTimeInMinutes",
        .growth_factor = "GrowthFactor",
        .growth_type = "GrowthType",
        .id = "Id",
        .name = "Name",
        .replicate_to = "ReplicateTo",
    };
};
