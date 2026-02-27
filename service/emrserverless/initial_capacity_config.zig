const WorkerResourceConfig = @import("worker_resource_config.zig").WorkerResourceConfig;

/// The initial capacity configuration per worker.
pub const InitialCapacityConfig = struct {
    /// The resource configuration of the initial capacity configuration.
    worker_configuration: ?WorkerResourceConfig,

    /// The number of workers in the initial capacity configuration.
    worker_count: i64 = 0,

    pub const json_field_names = .{
        .worker_configuration = "workerConfiguration",
        .worker_count = "workerCount",
    };
};
