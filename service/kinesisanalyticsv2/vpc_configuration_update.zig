/// Describes updates to the VPC configuration used by the application.
pub const VpcConfigurationUpdate = struct {
    /// Describes updates to the array of
    /// [SecurityGroup](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_SecurityGroup.html) IDs used by the VPC configuration.
    security_group_id_updates: ?[]const []const u8,

    /// Describes updates to the array of
    /// [Subnet](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Subnet.html)
    /// IDs
    /// used by the VPC configuration.
    subnet_id_updates: ?[]const []const u8,

    /// Describes an update to the ID of the VPC configuration.
    vpc_configuration_id: []const u8,

    pub const json_field_names = .{
        .security_group_id_updates = "SecurityGroupIdUpdates",
        .subnet_id_updates = "SubnetIdUpdates",
        .vpc_configuration_id = "VpcConfigurationId",
    };
};
