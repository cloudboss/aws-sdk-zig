const WorkerComputeConfiguration = @import("worker_compute_configuration.zig").WorkerComputeConfiguration;

/// The configuration of the compute resources for an analysis with the Spark
/// analytics engine.
pub const ComputeConfiguration = union(enum) {
    /// The worker configuration for the compute environment.
    worker: ?WorkerComputeConfiguration,

    pub const json_field_names = .{
        .worker = "worker",
    };
};
