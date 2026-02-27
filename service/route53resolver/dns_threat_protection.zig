pub const DnsThreatProtection = enum {
    dga,
    dns_tunneling,
    dictionary_dga,

    pub const json_field_names = .{
        .dga = "DGA",
        .dns_tunneling = "DNS_TUNNELING",
        .dictionary_dga = "DICTIONARY_DGA",
    };
};
