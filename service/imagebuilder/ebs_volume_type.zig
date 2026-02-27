pub const EbsVolumeType = enum {
    standard,
    io1,
    io2,
    gp2,
    gp3,
    sc1,
    st1,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .io1 = "IO1",
        .io2 = "IO2",
        .gp2 = "GP2",
        .gp3 = "GP3",
        .sc1 = "SC1",
        .st1 = "ST1",
    };
};
