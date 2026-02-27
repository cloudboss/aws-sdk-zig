pub const OperationMode = enum {
    primary,
    logreplay,
    delta_datashipping,
    logreplay_readaccess,
    none,

    pub const json_field_names = .{
        .primary = "PRIMARY",
        .logreplay = "LOGREPLAY",
        .delta_datashipping = "DELTA_DATASHIPPING",
        .logreplay_readaccess = "LOGREPLAY_READACCESS",
        .none = "NONE",
    };
};
