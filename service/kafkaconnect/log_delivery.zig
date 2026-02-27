const WorkerLogDelivery = @import("worker_log_delivery.zig").WorkerLogDelivery;

/// Details about log delivery.
pub const LogDelivery = struct {
    /// The workers can send worker logs to different destination types. This
    /// configuration specifies the details of these destinations.
    worker_log_delivery: WorkerLogDelivery,

    pub const json_field_names = .{
        .worker_log_delivery = "workerLogDelivery",
    };
};
