const WebAppVpcEndpointIpAddressType = @import("web_app_vpc_endpoint_ip_address_type.zig").WebAppVpcEndpointIpAddressType;

/// Contains the VPC configuration settings for hosting a web app endpoint,
/// including the VPC ID, subnet IDs, and security group IDs for access control.
pub const WebAppVpcConfig = struct {
    /// The IP address type for the web app's VPC endpoint. This determines whether
    /// the endpoint is accessible over IPv4 only, or over both IPv4 and IPv6.
    ip_address_type: ?WebAppVpcEndpointIpAddressType = null,

    /// The list of security group IDs that control access to the web app endpoint.
    /// These security groups determine which sources can access the endpoint based
    /// on IP addresses and port configurations.
    security_group_ids: ?[]const []const u8 = null,

    /// The list of subnet IDs within the VPC where the web app endpoint will be
    /// deployed. These subnets must be in the same VPC specified in the VpcId
    /// parameter.
    subnet_ids: ?[]const []const u8 = null,

    /// The identifier of the VPC where the web app endpoint will be hosted.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ip_address_type = "IpAddressType",
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
        .vpc_id = "VpcId",
    };
};
