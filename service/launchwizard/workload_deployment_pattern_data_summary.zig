const AccountConstraint = @import("account_constraint.zig").AccountConstraint;
const WorkloadDeploymentPatternStatus = @import("workload_deployment_pattern_status.zig").WorkloadDeploymentPatternStatus;

/// Describes a workload deployment pattern.
pub const WorkloadDeploymentPatternDataSummary = struct {
    /// Optional list of constraints describing what kind of AWS account is allowed
    /// to deploy this workload or deployment pattern. Within a single list the
    /// semantics are OR: an account satisfies the list if it satisfies any entry.
    /// Workload-level and pattern-level lists combine with AND at deployment time.
    /// An absent or empty list at this level means no constraint at this level.
    account_constraints: ?[]const AccountConstraint = null,

    /// The name of a workload deployment pattern.
    deployment_pattern_name: ?[]const u8 = null,

    /// The version name of a workload deployment pattern.
    deployment_pattern_version_name: ?[]const u8 = null,

    /// The description of a workload deployment pattern.
    description: ?[]const u8 = null,

    /// The display name of a workload deployment pattern.
    display_name: ?[]const u8 = null,

    /// The status of a workload deployment pattern.
    status: ?WorkloadDeploymentPatternStatus = null,

    /// A message about a workload deployment pattern's status.
    status_message: ?[]const u8 = null,

    /// The name of the workload.
    workload_name: ?[]const u8 = null,

    /// The name of the workload deployment pattern version.
    workload_version_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_constraints = "accountConstraints",
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
