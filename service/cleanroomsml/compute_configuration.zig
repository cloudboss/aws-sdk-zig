const WorkerComputeConfiguration = @import("worker_compute_configuration.zig").WorkerComputeConfiguration;

/// Provides configuration information for the instances that will perform the
/// compute work.
pub const ComputeConfiguration = union(enum) {
    /// The worker instances that will perform the compute work.
    worker: ?WorkerComputeConfiguration,

    pub const json_field_names = .{
        .worker = "worker",
    };
};
