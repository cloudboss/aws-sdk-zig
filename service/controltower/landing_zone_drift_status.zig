pub const LandingZoneDriftStatus = enum {
    drifted,
    in_sync,

    pub const json_field_names = .{
        .drifted = "DRIFTED",
        .in_sync = "IN_SYNC",
    };
};
