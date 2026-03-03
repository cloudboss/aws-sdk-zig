/// Contains information about the directory.
pub const DirectoryVpcSettingsDescription = struct {
    /// The list of Availability Zones that the directory is in.
    availability_zones: ?[]const []const u8 = null,

    /// The domain controller security group identifier for the directory.
    security_group_id: ?[]const u8 = null,

    /// The identifiers of the subnets for the directory servers.
    subnet_ids: ?[]const []const u8 = null,

    /// The identifier of the VPC that the directory is in.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zones = "AvailabilityZones",
        .security_group_id = "SecurityGroupId",
        .subnet_ids = "SubnetIds",
        .vpc_id = "VpcId",
    };
};
