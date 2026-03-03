const ServiceType = @import("service_type.zig").ServiceType;

/// Describes the type of service for a VPC endpoint.
pub const ServiceTypeDetail = struct {
    /// The type of service.
    service_type: ?ServiceType = null,
};
