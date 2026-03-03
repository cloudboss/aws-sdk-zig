const ServiceResourceId = @import("service_resource_id.zig").ServiceResourceId;

/// Detailed information about an attempt to run a service job.
pub const ServiceJobAttemptDetail = struct {
    /// The service resource identifier associated with the service job attempt.
    service_resource_id: ?ServiceResourceId = null,

    /// The Unix timestamp (in milliseconds) for when the service job attempt was
    /// started.
    started_at: ?i64 = null,

    /// A string that provides additional details for the current status of the
    /// service job attempt.
    status_reason: ?[]const u8 = null,

    /// The Unix timestamp (in milliseconds) for when the service job attempt
    /// stopped running.
    stopped_at: ?i64 = null,

    pub const json_field_names = .{
        .service_resource_id = "serviceResourceId",
        .started_at = "startedAt",
        .status_reason = "statusReason",
        .stopped_at = "stoppedAt",
    };
};
