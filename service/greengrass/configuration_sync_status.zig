pub const ConfigurationSyncStatus = enum {
    in_sync,
    out_of_sync,

    pub const json_field_names = .{
        .in_sync = "InSync",
        .out_of_sync = "OutOfSync",
    };
};
