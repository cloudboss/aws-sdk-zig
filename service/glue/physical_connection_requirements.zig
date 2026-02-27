/// The OAuth client app in GetConnection response.
pub const PhysicalConnectionRequirements = struct {
    /// The connection's Availability Zone.
    availability_zone: ?[]const u8,

    /// The security group ID list used by the connection.
    security_group_id_list: ?[]const []const u8,

    /// The subnet ID used by the connection.
    subnet_id: ?[]const u8,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .security_group_id_list = "SecurityGroupIdList",
        .subnet_id = "SubnetId",
    };
};
