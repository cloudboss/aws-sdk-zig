const NotifyWorkersFailureCode = @import("notify_workers_failure_code.zig").NotifyWorkersFailureCode;

/// When MTurk encounters an issue with notifying the Workers
/// you specified, it returns back this object with failure details.
pub const NotifyWorkersFailureStatus = struct {
    /// Encoded value for the failure type.
    notify_workers_failure_code: ?NotifyWorkersFailureCode,

    /// A message detailing the reason the Worker could not be
    /// notified.
    notify_workers_failure_message: ?[]const u8,

    /// The ID of the Worker.
    worker_id: ?[]const u8,

    pub const json_field_names = .{
        .notify_workers_failure_code = "NotifyWorkersFailureCode",
        .notify_workers_failure_message = "NotifyWorkersFailureMessage",
        .worker_id = "WorkerId",
    };
};
