/// Information about the deployment status of the instances in the deployment.
pub const DeploymentOverview = struct {
    /// The number of instances in the deployment in a failed state.
    failed: i64 = 0,

    /// The number of instances in which the deployment is in progress.
    in_progress: i64 = 0,

    /// The number of instances in the deployment in a pending state.
    pending: i64 = 0,

    /// The number of instances in a replacement environment ready to receive
    /// traffic in a
    /// blue/green deployment.
    ready: i64 = 0,

    /// The number of instances in the deployment in a skipped state.
    skipped: i64 = 0,

    /// The number of instances in the deployment to which revisions have been
    /// successfully
    /// deployed.
    succeeded: i64 = 0,

    pub const json_field_names = .{
        .failed = "Failed",
        .in_progress = "InProgress",
        .pending = "Pending",
        .ready = "Ready",
        .skipped = "Skipped",
        .succeeded = "Succeeded",
    };
};
