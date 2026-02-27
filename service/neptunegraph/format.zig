pub const Format = enum {
    csv,
    open_cypher,
    parquet,
    ntriples,

    pub const json_field_names = .{
        .csv = "CSV",
        .open_cypher = "OPEN_CYPHER",
        .parquet = "PARQUET",
        .ntriples = "NTRIPLES",
    };
};
