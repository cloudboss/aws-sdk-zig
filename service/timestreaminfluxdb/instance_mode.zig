pub const InstanceMode = enum {
    primary,
    standby,
    replica,
    ingest,
    query,
    compact,
    process,

    pub const json_field_names = .{
        .primary = "PRIMARY",
        .standby = "STANDBY",
        .replica = "REPLICA",
        .ingest = "INGEST",
        .query = "QUERY",
        .compact = "COMPACT",
        .process = "PROCESS",
    };
};
