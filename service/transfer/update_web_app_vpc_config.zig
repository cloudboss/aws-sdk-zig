const WebAppVpcEndpointIpAddressType = @import("web_app_vpc_endpoint_ip_address_type.zig").WebAppVpcEndpointIpAddressType;

/// Contains the VPC configuration settings for updating a web app endpoint,
/// including the subnet IDs where the endpoint should be deployed.
pub const UpdateWebAppVpcConfig = struct {
    /// The IP address type for the web app's VPC endpoint. This determines whether
    /// the endpoint is accessible over IPv4 only, or over both IPv4 and IPv6.
    ip_address_type: ?WebAppVpcEndpointIpAddressType = null,

    /// The list of subnet IDs within the VPC where the web app endpoint should be
    /// deployed during the update operation.
    subnet_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .ip_address_type = "IpAddressType",
        .subnet_ids = "SubnetIds",
    };
};
