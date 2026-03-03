const ResourceGatewayIpAddressType = @import("resource_gateway_ip_address_type.zig").ResourceGatewayIpAddressType;
const ResourceGatewayStatus = @import("resource_gateway_status.zig").ResourceGatewayStatus;

/// Summary information about a resource gateway.
pub const ResourceGatewaySummary = struct {
    /// The Amazon Resource Name (ARN) of the resource gateway.
    arn: ?[]const u8 = null,

    /// The date and time that the VPC endpoint association was created, in ISO-8601
    /// format.
    created_at: ?i64 = null,

    /// The ID of the resource gateway.
    id: ?[]const u8 = null,

    /// The type of IP address used by the resource gateway.
    ip_address_type: ?ResourceGatewayIpAddressType = null,

    /// The number of IPv4 addresses in each ENI for the resource gateway.
    ipv_4_addresses_per_eni: ?i32 = null,

    /// The most recent date and time that the resource gateway was updated, in
    /// ISO-8601 format.
    last_updated_at: ?i64 = null,

    /// The name of the resource gateway.
    name: ?[]const u8 = null,

    /// The IDs of the security groups applied to the resource gateway.
    security_group_ids: ?[]const []const u8 = null,

    /// The name of the resource gateway.
    status: ?ResourceGatewayStatus = null,

    /// The IDs of the VPC subnets for the resource gateway.
    subnet_ids: ?[]const []const u8 = null,

    /// The ID of the VPC for the resource gateway.
    vpc_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .id = "id",
        .ip_address_type = "ipAddressType",
        .ipv_4_addresses_per_eni = "ipv4AddressesPerEni",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .security_group_ids = "securityGroupIds",
        .status = "status",
        .subnet_ids = "subnetIds",
        .vpc_identifier = "vpcIdentifier",
    };
};
