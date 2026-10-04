/// Describes the source for a health check path in a request. The source
/// defines the subnet and security group where a health check elastic network
/// interface (ENI) is created to originate health check traffic.
pub const HealthCheckPathSourceRequestObject = struct {
    /// The ID of the security group for the source.
    security_group_id: ?[]const u8 = null,

    /// The ID of the subnet for the source.
    subnet_id: ?[]const u8 = null,
};
