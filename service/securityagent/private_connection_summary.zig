const aws = @import("aws");

const ResourceConfigDnsResolution = @import("resource_config_dns_resolution.zig").ResourceConfigDnsResolution;
const PrivateConnectionStatus = @import("private_connection_status.zig").PrivateConnectionStatus;
const PrivateConnectionType = @import("private_connection_type.zig").PrivateConnectionType;

/// Summarizes a private connection.
pub const PrivateConnectionSummary = struct {
    /// The date and time the connection's certificate expires, in UTC format.
    certificate_expiry_time: ?i64 = null,

    /// The DNS resolution mode for the resource gateway.
    dns_resolution: ?ResourceConfigDnsResolution = null,

    /// A message describing why the private connection entered a failed state, if
    /// applicable.
    failure_message: ?[]const u8 = null,

    /// The IP address or DNS name of the target resource.
    host_address: ?[]const u8 = null,

    /// The name of the private connection.
    name: []const u8,

    /// The identifier or ARN of the VPC Lattice resource configuration.
    resource_configuration_id: ?[]const u8 = null,

    /// The identifier or ARN of the VPC Lattice resource gateway.
    resource_gateway_id: ?[]const u8 = null,

    /// The current status of the private connection.
    status: PrivateConnectionStatus,

    /// The tags attached to the private connection.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of the private connection, indicating whether it is service-managed
    /// or self-managed.
    type: PrivateConnectionType,

    /// The identifier of the VPC the resource gateway is created in.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_expiry_time = "certificateExpiryTime",
        .dns_resolution = "dnsResolution",
        .failure_message = "failureMessage",
        .host_address = "hostAddress",
        .name = "name",
        .resource_configuration_id = "resourceConfigurationId",
        .resource_gateway_id = "resourceGatewayId",
        .status = "status",
        .tags = "tags",
        .type = "type",
        .vpc_id = "vpcId",
    };
};
