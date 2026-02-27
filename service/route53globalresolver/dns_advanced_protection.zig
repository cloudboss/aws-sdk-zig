pub const DnsAdvancedProtection = enum {
    dga,
    dns_tunneling,

    pub const json_field_names = .{
        .dga = "DGA",
        .dns_tunneling = "DNS_TUNNELING",
    };
};
