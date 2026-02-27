pub const ReplicationConfigurationDefaultLargeStagingDiskType = enum {
    gp2,
    gp3,
    st1,
    auto,

    pub const json_field_names = .{
        .gp2 = "GP2",
        .gp3 = "GP3",
        .st1 = "ST1",
        .auto = "AUTO",
    };
};
