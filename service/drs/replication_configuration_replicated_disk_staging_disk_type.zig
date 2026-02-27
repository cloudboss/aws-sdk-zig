pub const ReplicationConfigurationReplicatedDiskStagingDiskType = enum {
    auto,
    gp2,
    gp3,
    io1,
    sc1,
    st1,
    standard,

    pub const json_field_names = .{
        .auto = "AUTO",
        .gp2 = "GP2",
        .gp3 = "GP3",
        .io1 = "IO1",
        .sc1 = "SC1",
        .st1 = "ST1",
        .standard = "STANDARD",
    };
};
