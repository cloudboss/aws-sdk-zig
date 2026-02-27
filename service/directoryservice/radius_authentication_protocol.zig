pub const RadiusAuthenticationProtocol = enum {
    pap,
    chap,
    mschapv1,
    mschapv2,

    pub const json_field_names = .{
        .pap = "PAP",
        .chap = "CHAP",
        .mschapv1 = "MSCHAPV1",
        .mschapv2 = "MSCHAPV2",
    };
};
