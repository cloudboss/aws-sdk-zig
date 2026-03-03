/// Contains the IP address block. This is often the address block of the DNS
/// server used
/// for your self-managed domain.
pub const IpRoute = struct {
    /// IP address block in CIDR format, such as 10.0.0.0/24. This is often the
    /// address block of
    /// the DNS server used for your self-managed domain. For a single IP address,
    /// use a CIDR
    /// address block with /32. For example, 10.0.0.0/32.
    cidr_ip: ?[]const u8 = null,

    /// IPv6 address block in CIDR format, such as 2001:db8::/32. This is often the
    /// address
    /// block of the DNS server used for your self-managed domain. For a single IPv6
    /// address, use a
    /// CIDR address block with /128. For example, 2001:db8::1/128.
    cidr_ipv_6: ?[]const u8 = null,

    /// Description of the address block.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .cidr_ip = "CidrIp",
        .cidr_ipv_6 = "CidrIpv6",
        .description = "Description",
    };
};
