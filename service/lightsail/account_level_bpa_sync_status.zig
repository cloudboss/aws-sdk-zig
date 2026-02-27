pub const AccountLevelBpaSyncStatus = enum {
    in_sync,
    failed,
    never_synced,
    defaulted,

    pub const json_field_names = .{
        .in_sync = "InSync",
        .failed = "Failed",
        .never_synced = "NeverSynced",
        .defaulted = "Defaulted",
    };
};
