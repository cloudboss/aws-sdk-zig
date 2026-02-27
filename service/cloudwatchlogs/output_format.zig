pub const OutputFormat = enum {
    json,
    plain,
    w3_c,
    raw,
    parquet,

    pub const json_field_names = .{
        .json = "JSON",
        .plain = "PLAIN",
        .w3_c = "W3C",
        .raw = "RAW",
        .parquet = "PARQUET",
    };
};
