/// Describes the source for a health check path.
pub const HealthCheckPathSourceResponseObject = struct {
    /// The ID of the security group for the source.
    security_group_id: ?[]const u8 = null,

    /// The ID of the subnet for the source.
    subnet_id: ?[]const u8 = null,
};
