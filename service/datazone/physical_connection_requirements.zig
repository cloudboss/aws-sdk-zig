/// Physical connection requirements of a connection.
pub const PhysicalConnectionRequirements = struct {
    /// The availability zone of the physical connection requirements of a
    /// connection.
    availability_zone: ?[]const u8 = null,

    /// The group ID list of the physical connection requirements of a connection.
    security_group_id_list: ?[]const []const u8 = null,

    /// The subnet ID of the physical connection requirements of a connection.
    subnet_id: ?[]const u8 = null,

    /// The subnet ID list of the physical connection requirements of a connection.
    subnet_id_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "availabilityZone",
        .security_group_id_list = "securityGroupIdList",
        .subnet_id = "subnetId",
        .subnet_id_list = "subnetIdList",
    };
};
