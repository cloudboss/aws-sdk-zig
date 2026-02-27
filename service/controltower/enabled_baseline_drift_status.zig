pub const EnabledBaselineDriftStatus = enum {
    in_sync,
    drifted,

    pub const json_field_names = .{
        .in_sync = "IN_SYNC",
        .drifted = "DRIFTED",
    };
};
