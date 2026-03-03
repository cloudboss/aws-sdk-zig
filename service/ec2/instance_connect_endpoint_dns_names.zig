/// The DNS names of the endpoint.
pub const InstanceConnectEndpointDnsNames = struct {
    /// The DNS name of the EC2 Instance Connect Endpoint.
    dns_name: ?[]const u8 = null,

    /// The Federal Information Processing Standards (FIPS) compliant DNS name of
    /// the EC2 Instance Connect Endpoint.
    fips_dns_name: ?[]const u8 = null,
};
