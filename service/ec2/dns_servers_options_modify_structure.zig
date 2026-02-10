/// Information about the DNS server to be used.
pub const DnsServersOptionsModifyStructure = struct {
    /// The IPv4 address range, in CIDR notation, of the DNS servers to be used. You
    /// can specify up to
    /// two DNS servers. Ensure that the DNS servers can be reached by the clients.
    /// The specified values
    /// overwrite the existing values.
    custom_dns_servers: ?[]const []const u8,

    /// Indicates whether DNS servers should be used. Specify `False` to delete the
    /// existing DNS
    /// servers.
    enabled: ?bool,
};
