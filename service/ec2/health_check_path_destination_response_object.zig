/// Describes a destination for a health check path.
pub const HealthCheckPathDestinationResponseObject = struct {
    /// The ID of the security group for the destination.
    security_group_id: ?[]const u8 = null,

    /// The ID of the subnet for the destination.
    subnet_id: ?[]const u8 = null,
};
