const AccountConstraint = @import("account_constraint.zig").AccountConstraint;
const DeploymentSpecificationsField = @import("deployment_specifications_field.zig").DeploymentSpecificationsField;
const WorkloadDeploymentPatternStatus = @import("workload_deployment_pattern_status.zig").WorkloadDeploymentPatternStatus;

/// The data that details a workload deployment pattern.
pub const WorkloadDeploymentPatternData = struct {
    /// Optional list of constraints describing what kind of AWS account is allowed
    /// to deploy this workload or deployment pattern. Within a single list the
    /// semantics are OR: an account satisfies the list if it satisfies any entry.
    /// Workload-level and pattern-level lists combine with AND at deployment time.
    /// An absent or empty list at this level means no constraint at this level.
    account_constraints: ?[]const AccountConstraint = null,

    /// The name of the deployment pattern.
    deployment_pattern_name: ?[]const u8 = null,

    /// The version name of the deployment pattern.
    deployment_pattern_version_name: ?[]const u8 = null,

    /// The description of the deployment pattern.
    description: ?[]const u8 = null,

    /// The display name of the deployment pattern.
    display_name: ?[]const u8 = null,

    /// The settings specified for the deployment. These settings define how to
    /// deploy and configure your resources created by the deployment. For more
    /// information about the specifications required for creating a deployment for
    /// a SAP workload, see [SAP deployment
    /// specifications](https://docs.aws.amazon.com/launchwizard/latest/APIReference/launch-wizard-specifications-sap.html). To retrieve the specifications required to create a deployment for other workloads, use the [ `GetWorkloadDeploymentPattern` ](https://docs.aws.amazon.com/launchwizard/latest/APIReference/API_GetWorkloadDeploymentPattern.html) operation.
    specifications: ?[]const DeploymentSpecificationsField = null,

    /// The status of the deployment pattern.
    status: ?WorkloadDeploymentPatternStatus = null,

    /// The status message of the deployment pattern.
    status_message: ?[]const u8 = null,

    /// The workload name of the deployment pattern.
    workload_name: ?[]const u8 = null,

    /// The workload version name of the deployment pattern.
    workload_version_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_constraints = "accountConstraints",
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
