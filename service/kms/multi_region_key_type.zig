pub const MultiRegionKeyType = enum {
    primary,
    replica,

    pub const json_field_names = .{
        .primary = "PRIMARY",
        .replica = "REPLICA",
    };
};
