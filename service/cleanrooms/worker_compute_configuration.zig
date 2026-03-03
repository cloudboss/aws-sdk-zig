const WorkerComputeConfigurationProperties = @import("worker_compute_configuration_properties.zig").WorkerComputeConfigurationProperties;
const WorkerComputeType = @import("worker_compute_type.zig").WorkerComputeType;

/// The configuration of the compute resources for workers running an analysis
/// with the Clean Rooms SQL analytics engine.
pub const WorkerComputeConfiguration = struct {
    /// The number of workers.
    ///
    /// SQL queries support a minimum value of 2 and a maximum value of 400.
    ///
    /// PySpark jobs support a minimum value of 4 and a maximum value of 128.
    number: ?i32 = null,

    /// The configuration properties for the worker compute environment. These
    /// properties allow you to customize the compute settings for your Clean Rooms
    /// workloads.
    properties: ?WorkerComputeConfigurationProperties = null,

    /// The worker compute configuration type.
    @"type": ?WorkerComputeType = null,

    pub const json_field_names = .{
        .number = "number",
        .properties = "properties",
        .@"type" = "type",
    };
};
