pub const DriftStatus = enum {
    drifted,
    in_sync,
    not_checking,
    unknown,

    pub const json_field_names = .{
        .drifted = "DRIFTED",
        .in_sync = "IN_SYNC",
        .not_checking = "NOT_CHECKING",
        .unknown = "UNKNOWN",
    };
};
