/// Describes a destination for a health check path in a request. Destinations
/// can be in a different Availability Zone than the source (cross-AZ) or in a
/// Local Zone (AZ to Local Zone), enabling remote health validation of your
/// application.
pub const HealthCheckPathDestinationRequestObject = struct {
    /// The ID of the security group for the destination.
    security_group_id: ?[]const u8 = null,

    /// The ID of the subnet for the destination.
    subnet_id: ?[]const u8 = null,
};
