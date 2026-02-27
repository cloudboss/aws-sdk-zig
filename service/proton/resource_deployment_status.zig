/// The state that a PR-based deployment can be updated to.
pub const ResourceDeploymentStatus = enum {
    in_progress,
    failed,
    succeeded,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
    };
};
