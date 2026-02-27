const ReplicationScope = @import("replication_scope.zig").ReplicationScope;

/// Points to a remote domain with which you are setting up a trust
/// relationship.
/// Conditional forwarders are required in order to set up a trust relationship
/// with another
/// domain.
pub const ConditionalForwarder = struct {
    /// The IP addresses of the remote DNS server associated with RemoteDomainName.
    /// This is the
    /// IP address of the DNS server that your conditional forwarder points to.
    dns_ip_addrs: ?[]const []const u8,

    /// The IPv6 addresses of the remote DNS server associated with
    /// RemoteDomainName. This is the
    /// IPv6 address of the DNS server that your conditional forwarder points to.
    dns_ipv_6_addrs: ?[]const []const u8,

    /// The fully qualified domain name (FQDN) of the remote domains pointed to by
    /// the
    /// conditional forwarder.
    remote_domain_name: ?[]const u8,

    /// The replication scope of the conditional forwarder. The only allowed value
    /// is
    /// `Domain`, which will replicate the conditional forwarder to all of the
    /// domain
    /// controllers for your Amazon Web Services directory.
    replication_scope: ?ReplicationScope,

    pub const json_field_names = .{
        .dns_ip_addrs = "DnsIpAddrs",
        .dns_ipv_6_addrs = "DnsIpv6Addrs",
        .remote_domain_name = "RemoteDomainName",
        .replication_scope = "ReplicationScope",
    };
};
