const WorkerLogDeliveryDescription = @import("worker_log_delivery_description.zig").WorkerLogDeliveryDescription;

/// The description of the log delivery settings.
pub const LogDeliveryDescription = struct {
    /// The workers can send worker logs to different destination types. This
    /// configuration specifies the details of these destinations.
    worker_log_delivery: ?WorkerLogDeliveryDescription = null,

    pub const json_field_names = .{
        .worker_log_delivery = "workerLogDelivery",
    };
};
