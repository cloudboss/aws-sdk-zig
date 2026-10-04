const WorkerComputeConfiguration = @import("worker_compute_configuration.zig").WorkerComputeConfiguration;

/// Contains the compute configuration for an intermediate table population
/// operation.
pub const IntermediateTableComputeConfiguration = union(enum) {
    query_compute_configuration: ?WorkerComputeConfiguration,

    pub const json_field_names = .{
        .query_compute_configuration = "queryComputeConfiguration",
    };
};
