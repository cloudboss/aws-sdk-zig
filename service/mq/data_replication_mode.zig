/// Specifies whether a broker is a part of a data replication pair.
pub const DataReplicationMode = enum {
    none,
    crdr,

    pub const json_field_names = .{
        .none = "NONE",
        .crdr = "CRDR",
    };
};
