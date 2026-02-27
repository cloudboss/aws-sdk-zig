/// Defines the replication type of a key
pub const MultiRegionKeyType = enum {
    primary,
    replica,

    pub const json_field_names = .{
        .primary = "PRIMARY",
        .replica = "REPLICA",
    };
};
