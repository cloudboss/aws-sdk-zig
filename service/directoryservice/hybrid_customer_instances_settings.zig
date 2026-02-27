/// Contains configuration settings for self-managed instances with SSM used in
/// hybrid
/// directory operations.
pub const HybridCustomerInstancesSettings = struct {
    /// The IP addresses of the DNS servers or domain controllers in your
    /// self-managed AD
    /// environment.
    customer_dns_ips: []const []const u8,

    /// The identifiers of the self-managed instances with SSM used in hybrid
    /// directory.
    instance_ids: []const []const u8,

    pub const json_field_names = .{
        .customer_dns_ips = "CustomerDnsIps",
        .instance_ids = "InstanceIds",
    };
};
