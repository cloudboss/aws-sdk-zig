const ProtectedJobWorkerComputeConfiguration = @import("protected_job_worker_compute_configuration.zig").ProtectedJobWorkerComputeConfiguration;

/// The configuration of the compute resources for a PySpark job.
pub const ProtectedJobComputeConfiguration = union(enum) {
    /// The worker configuration for the compute environment.
    worker: ?ProtectedJobWorkerComputeConfiguration,

    pub const json_field_names = .{
        .worker = "worker",
    };
};
