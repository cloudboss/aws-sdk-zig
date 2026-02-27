pub const Tcs = enum {
    sdr,
    pq,
    hlg,
    linear,
    bt2100_linpq,
    bt2100_linhlg,
    st2065_1,
    st428_1,
    density,

    pub const json_field_names = .{
        .sdr = "SDR",
        .pq = "PQ",
        .hlg = "HLG",
        .linear = "LINEAR",
        .bt2100_linpq = "BT2100LINPQ",
        .bt2100_linhlg = "BT2100LINHLG",
        .st2065_1 = "ST2065_1",
        .st428_1 = "ST428_1",
        .density = "DENSITY",
    };
};
