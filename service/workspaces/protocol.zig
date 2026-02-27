pub const Protocol = enum {
    pcoip,
    wsp,

    pub const json_field_names = .{
        .pcoip = "PCOIP",
        .wsp = "WSP",
    };
};
