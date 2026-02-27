pub const RestoreTestingRecoveryPointType = enum {
    continuous,
    snapshot,

    pub const json_field_names = .{
        .continuous = "CONTINUOUS",
        .snapshot = "SNAPSHOT",
    };
};
