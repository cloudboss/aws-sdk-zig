/// Represents a deployment status.
pub const DeploymentStatus = enum {
    pending,
    failed,
    deployed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .failed = "FAILED",
        .deployed = "DEPLOYED",
    };
};
