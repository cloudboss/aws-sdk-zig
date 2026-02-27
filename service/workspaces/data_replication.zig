pub const DataReplication = enum {
    no_replication,
    primary_as_source,

    pub const json_field_names = .{
        .no_replication = "NO_REPLICATION",
        .primary_as_source = "PRIMARY_AS_SOURCE",
    };
};
