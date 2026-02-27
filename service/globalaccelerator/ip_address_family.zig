pub const IpAddressFamily = enum {
    i_pv_4,
    i_pv_6,

    pub const json_field_names = .{
        .i_pv_4 = "IPv4",
        .i_pv_6 = "IPv6",
    };
};
