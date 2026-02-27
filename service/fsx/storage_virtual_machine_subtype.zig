pub const StorageVirtualMachineSubtype = enum {
    default,
    dp_destination,
    sync_destination,
    sync_source,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .dp_destination = "DP_DESTINATION",
        .sync_destination = "SYNC_DESTINATION",
        .sync_source = "SYNC_SOURCE",
    };
};
