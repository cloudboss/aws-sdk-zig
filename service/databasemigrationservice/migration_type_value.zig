pub const MigrationTypeValue = enum {
    full_load,
    cdc,
    full_load_and_cdc,

    pub const json_field_names = .{
        .full_load = "FULL_LOAD",
        .cdc = "CDC",
        .full_load_and_cdc = "FULL_LOAD_AND_CDC",
    };
};
