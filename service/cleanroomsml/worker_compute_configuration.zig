const WorkerComputeConfigurationProperties = @import("worker_compute_configuration_properties.zig").WorkerComputeConfigurationProperties;
const WorkerComputeType = @import("worker_compute_type.zig").WorkerComputeType;

/// Configuration information about the compute workers that perform the
/// transform job.
pub const WorkerComputeConfiguration = struct {
    /// The number of compute workers that are used.
    number: i32 = 16,

    properties: ?WorkerComputeConfigurationProperties,

    /// The instance type of the compute workers that are used.
    type: WorkerComputeType = "CR.1X",

    pub const json_field_names = .{
        .number = "number",
        .properties = "properties",
        .type = "type",
    };
};
