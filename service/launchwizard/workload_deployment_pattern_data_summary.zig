const WorkloadDeploymentPatternStatus = @import("workload_deployment_pattern_status.zig").WorkloadDeploymentPatternStatus;

/// Describes a workload deployment pattern.
pub const WorkloadDeploymentPatternDataSummary = struct {
    /// The name of a workload deployment pattern.
    deployment_pattern_name: ?[]const u8,

    /// The version name of a workload deployment pattern.
    deployment_pattern_version_name: ?[]const u8,

    /// The description of a workload deployment pattern.
    description: ?[]const u8,

    /// The display name of a workload deployment pattern.
    display_name: ?[]const u8,

    /// The status of a workload deployment pattern.
    status: ?WorkloadDeploymentPatternStatus,

    /// A message about a workload deployment pattern's status.
    status_message: ?[]const u8,

    /// The name of the workload.
    workload_name: ?[]const u8,

    /// The name of the workload deployment pattern version.
    workload_version_name: ?[]const u8,

    pub const json_field_names = .{
        .deployment_pattern_name = "deploymentPatternName",
        .deployment_pattern_version_name = "deploymentPatternVersionName",
        .description = "description",
        .display_name = "displayName",
        .status = "status",
        .status_message = "statusMessage",
        .workload_name = "workloadName",
        .workload_version_name = "workloadVersionName",
    };
};
