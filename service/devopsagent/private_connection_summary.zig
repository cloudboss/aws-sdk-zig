const ResourceConfigDnsResolution = @import("resource_config_dns_resolution.zig").ResourceConfigDnsResolution;
const PrivateConnectionStatus = @import("private_connection_status.zig").PrivateConnectionStatus;
const PrivateConnectionType = @import("private_connection_type.zig").PrivateConnectionType;

/// Summary of a Private Connection.
pub const PrivateConnectionSummary = struct {
    /// The expiry time of the certificate associated with the Private Connection.
    /// Only present when a certificate is associated.
    certificate_expiry_time: ?i64 = null,

    /// DNS resolution mode for the Private Connection's resource gateway.
    dns_resolution: ?ResourceConfigDnsResolution = null,

    /// Message describing the reason for a failed Private Connection, if
    /// applicable.
    failure_message: ?[]const u8 = null,

    /// IP address or DNS name of the target resource. Only present for
    /// service-managed Private Connections.
    host_address: ?[]const u8 = null,

    /// The name of the Private Connection.
    name: []const u8,

    /// The Resource Configuration ARN. Only present for self-managed Private
    /// Connections.
    resource_configuration_id: ?[]const u8 = null,

    /// The service-managed Resource Gateway ARN. Only present for service-managed
    /// Private Connections.
    resource_gateway_id: ?[]const u8 = null,

    /// The status of the Private Connection.
    status: PrivateConnectionStatus,

    /// The type of the Private Connection.
    type: PrivateConnectionType,

    /// VPC identifier of the service-managed Resource Gateway. Only present for
    /// service-managed Private Connections.
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
        .type = "type",
        .vpc_id = "vpcId",
    };
};
