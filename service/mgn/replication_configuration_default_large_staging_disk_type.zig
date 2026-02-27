pub const ReplicationConfigurationDefaultLargeStagingDiskType = enum {
    gp2,
    st1,
    gp3,

    pub const json_field_names = .{
        .gp2 = "GP2",
        .st1 = "ST1",
        .gp3 = "GP3",
    };
};
