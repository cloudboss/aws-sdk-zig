/// Information about the Private DNS name for interface endpoints.
pub const PrivateDnsDetails = struct {
    /// The private DNS name assigned to the VPC endpoint service.
    private_dns_name: ?[]const u8,
};
