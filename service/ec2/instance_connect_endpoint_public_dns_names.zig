const InstanceConnectEndpointDnsNames = @import("instance_connect_endpoint_dns_names.zig").InstanceConnectEndpointDnsNames;

/// The public DNS names of the endpoint, including IPv4-only and dualstack DNS
/// names.
pub const InstanceConnectEndpointPublicDnsNames = struct {
    /// The dualstack DNS name of the EC2 Instance Connect Endpoint. A dualstack DNS
    /// name supports connections from both IPv4 and IPv6 clients.
    dualstack: ?InstanceConnectEndpointDnsNames,

    /// The IPv4-only DNS name of the EC2 Instance Connect Endpoint.
    ipv_4: ?InstanceConnectEndpointDnsNames,
};
