const WorkerComputeConfigurationProperties = @import("worker_compute_configuration_properties.zig").WorkerComputeConfigurationProperties;
const ProtectedJobWorkerComputeType = @import("protected_job_worker_compute_type.zig").ProtectedJobWorkerComputeType;

/// The configuration of the compute resources for a PySpark job.
pub const ProtectedJobWorkerComputeConfiguration = struct {
    /// The number of workers for a PySpark job.
    number: i32,

    /// The configuration properties for the worker compute environment. These
    /// properties allow you to customize the compute settings for your Clean Rooms
    /// workloads.
    properties: ?WorkerComputeConfigurationProperties = null,

    /// The worker compute configuration type.
    @"type": ProtectedJobWorkerComputeType,

    pub const json_field_names = .{
        .number = "number",
        .properties = "properties",
        .@"type" = "type",
    };
};
