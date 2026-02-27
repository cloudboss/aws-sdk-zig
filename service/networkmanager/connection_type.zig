pub const ConnectionType = enum {
    bgp,
    ipsec,

    pub const json_field_names = .{
        .bgp = "BGP",
        .ipsec = "IPSEC",
    };
};
