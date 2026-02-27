pub const ConfigurationSyncState = enum {
    pending,
    in_sync,
    capacity_constrained,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_sync = "IN_SYNC",
        .capacity_constrained = "CAPACITY_CONSTRAINED",
    };
};
