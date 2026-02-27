pub const VolumeTypeEnum = enum {
    standard,
    io1,
    io2,
    gp2,
    sc1,
    st1,
    gp3,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .io1 = "IO1",
        .io2 = "IO2",
        .gp2 = "GP2",
        .sc1 = "SC1",
        .st1 = "ST1",
        .gp3 = "GP3",
    };
};
