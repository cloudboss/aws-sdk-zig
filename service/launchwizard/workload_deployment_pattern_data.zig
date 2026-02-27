const DeploymentSpecificationsField = @import("deployment_specifications_field.zig").DeploymentSpecificationsField;
const WorkloadDeploymentPatternStatus = @import("workload_deployment_pattern_status.zig").WorkloadDeploymentPatternStatus;

/// The data that details a workload deployment pattern.
pub const WorkloadDeploymentPatternData = struct {
    /// The name of the deployment pattern.
    deployment_pattern_name: ?[]const u8,

    /// The version name of the deployment pattern.
    deployment_pattern_version_name: ?[]const u8,

    /// The description of the deployment pattern.
    description: ?[]const u8,

    /// The display name of the deployment pattern.
    display_name: ?[]const u8,

    /// The settings specified for the deployment. These settings define how to
    /// deploy and configure your resources created by the deployment. For more
    /// information about the specifications required for creating a deployment for
    /// a SAP workload, see [SAP deployment
    /// specifications](https://docs.aws.amazon.com/launchwizard/latest/APIReference/launch-wizard-specifications-sap.html). To retrieve the specifications required to create a deployment for other workloads, use the [ `GetWorkloadDeploymentPattern` ](https://docs.aws.amazon.com/launchwizard/latest/APIReference/API_GetWorkloadDeploymentPattern.html) operation.
    specifications: ?[]const DeploymentSpecificationsField,

    /// The status of the deployment pattern.
    status: ?WorkloadDeploymentPatternStatus,

    /// The status message of the deployment pattern.
    status_message: ?[]const u8,

    /// The workload name of the deployment pattern.
    workload_name: ?[]const u8,

    /// The workload version name of the deployment pattern.
    workload_version_name: ?[]const u8,

    pub const json_field_names = .{
        .deployment_pattern_name = "deploymentPatternName",
        .deployment_pattern_version_name = "deploymentPatternVersionName",
        .description = "description",
        .display_name = "displayName",
        .specifications = "specifications",
        .status = "status",
        .status_message = "statusMessage",
        .workload_name = "workloadName",
        .workload_version_name = "workloadVersionName",
    };
};
