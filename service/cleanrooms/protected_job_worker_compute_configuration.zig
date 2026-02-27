const ProtectedJobWorkerComputeType = @import("protected_job_worker_compute_type.zig").ProtectedJobWorkerComputeType;

/// The configuration of the compute resources for a PySpark job.
pub const ProtectedJobWorkerComputeConfiguration = struct {
    /// The number of workers for a PySpark job.
    number: i32,

    /// The worker compute configuration type.
    @"type": ProtectedJobWorkerComputeType,

    pub const json_field_names = .{
        .number = "number",
        .@"type" = "type",
    };
};
