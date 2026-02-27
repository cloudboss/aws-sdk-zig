const ServiceResourceId = @import("service_resource_id.zig").ServiceResourceId;

/// Information about the latest attempt of a service job. A Service job can
/// transition from `SCHEDULED` back to `RUNNABLE` state when they encounter
/// capacity constraints.
pub const LatestServiceJobAttempt = struct {
    /// The service resource identifier associated with the service job attempt.
    service_resource_id: ?ServiceResourceId,

    pub const json_field_names = .{
        .service_resource_id = "serviceResourceId",
    };
};
