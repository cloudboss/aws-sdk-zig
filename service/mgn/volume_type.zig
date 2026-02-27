pub const VolumeType = enum {
    io_1,
    io_2,
    gp_3,
    gp_2,
    st_1,
    sc_1,
    standard,

    pub const json_field_names = .{
        .io_1 = "io1",
        .io_2 = "io2",
        .gp_3 = "gp3",
        .gp_2 = "gp2",
        .st_1 = "st1",
        .sc_1 = "sc1",
        .standard = "standard",
    };
};
