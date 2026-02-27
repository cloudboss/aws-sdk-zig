const NetworkInterfaceType = @import("network_interface_type.zig").NetworkInterfaceType;

/// The settings for a VPC source.
pub const VpcInterface = struct {
    /// Immutable and has to be a unique against other VpcInterfaces in this Flow.
    name: []const u8,

    /// IDs of the network interfaces created in customer's account by MediaConnect.
    network_interface_ids: []const []const u8,

    /// The type of network interface.
    network_interface_type: NetworkInterfaceType,

    /// A role Arn MediaConnect can assume to create ENIs in your account.
    role_arn: []const u8,

    /// Security Group IDs to be used on ENI.
    security_group_ids: []const []const u8,

    /// Subnet must be in the AZ of the Flow.
    subnet_id: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .network_interface_ids = "NetworkInterfaceIds",
        .network_interface_type = "NetworkInterfaceType",
        .role_arn = "RoleArn",
        .security_group_ids = "SecurityGroupIds",
        .subnet_id = "SubnetId",
    };
};
