pub const TunnelProtocol = enum {
    gre,
    no_encap,

    pub const json_field_names = .{
        .gre = "GRE",
        .no_encap = "NO_ENCAP",
    };
};
