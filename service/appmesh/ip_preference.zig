pub const IpPreference = enum {
    i_pv_6_preferred,
    i_pv_4_preferred,
    i_pv_4_only,
    i_pv_6_only,

    pub const json_field_names = .{
        .i_pv_6_preferred = "IPv6_PREFERRED",
        .i_pv_4_preferred = "IPv4_PREFERRED",
        .i_pv_4_only = "IPv4_ONLY",
        .i_pv_6_only = "IPv6_ONLY",
    };
};
