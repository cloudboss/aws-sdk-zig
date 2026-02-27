const ServiceId = @import("service_id.zig").ServiceId;

/// The service within the service graph that has anomalously high fault rates.
pub const AnomalousService = struct {
    service_id: ?ServiceId,

    pub const json_field_names = .{
        .service_id = "ServiceId",
    };
};
