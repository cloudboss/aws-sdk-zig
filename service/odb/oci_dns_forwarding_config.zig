/// DNS configuration to forward DNS resolver endpoints to your OCI Private
/// Zone.
pub const OciDnsForwardingConfig = struct {
    /// Domain name to which DNS resolver forwards to.
    domain_name: ?[]const u8,

    /// OCI DNS listener IP for custom DNS setup.
    oci_dns_listener_ip: ?[]const u8,

    pub const json_field_names = .{
        .domain_name = "domainName",
        .oci_dns_listener_ip = "ociDnsListenerIp",
    };
};
