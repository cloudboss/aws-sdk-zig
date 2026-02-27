pub const DataFormat = enum {
    json,
    parquet,

    pub const json_field_names = .{
        .json = "JSON",
        .parquet = "PARQUET",
    };
};
