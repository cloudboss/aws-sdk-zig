const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;

/// A summary of the deployment data.
pub const DeploymentDataSummary = struct {
    /// The time the deployment was created.
    created_at: ?i64,

    /// The ID of the deployment.
    id: ?[]const u8,

    /// The time the deployment was last modified.
    modified_at: ?i64,

    /// The name of the deployment
    name: ?[]const u8,

    /// The name of the workload deployment pattern.
    pattern_name: ?[]const u8,

    /// The status of the deployment.
    status: ?DeploymentStatus,

    /// The name of the workload.
    workload_name: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .id = "id",
        .modified_at = "modifiedAt",
        .name = "name",
        .pattern_name = "patternName",
        .status = "status",
        .workload_name = "workloadName",
    };
};
