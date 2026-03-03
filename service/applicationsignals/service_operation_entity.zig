const ServiceEntity = @import("service_entity.zig").ServiceEntity;

/// A structure that contains identifying information for a service operation
/// entity.
pub const ServiceOperationEntity = struct {
    /// The type of metric associated with this service operation.
    metric_type: ?[]const u8 = null,

    /// The name of the operation.
    operation: ?[]const u8 = null,

    /// The service entity that contains this operation.
    service: ?ServiceEntity = null,

    pub const json_field_names = .{
        .metric_type = "MetricType",
        .operation = "Operation",
        .service = "Service",
    };
};
