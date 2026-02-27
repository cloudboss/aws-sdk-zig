pub const DiscoveryModification = enum {
    discovered,
    updated,
    no_change,

    pub const json_field_names = .{
        .discovered = "DISCOVERED",
        .updated = "UPDATED",
        .no_change = "NO_CHANGE",
    };
};
