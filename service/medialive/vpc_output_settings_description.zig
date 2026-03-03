/// The properties for a private VPC Output
pub const VpcOutputSettingsDescription = struct {
    /// The Availability Zones where the vpc subnets are located.
    /// The first Availability Zone applies to the first subnet in the list of
    /// subnets.
    /// The second Availability Zone applies to the second subnet.
    availability_zones: ?[]const []const u8 = null,

    /// A list of Elastic Network Interfaces created by MediaLive in the customer's
    /// VPC
    network_interface_ids: ?[]const []const u8 = null,

    /// A list of up EC2 VPC security group IDs attached to the Output VPC network
    /// interfaces.
    security_group_ids: ?[]const []const u8 = null,

    /// A list of VPC subnet IDs from the same VPC.
    /// If STANDARD channel, subnet IDs must be mapped to two unique availability
    /// zones (AZ).
    subnet_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .availability_zones = "AvailabilityZones",
        .network_interface_ids = "NetworkInterfaceIds",
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
    };
};
