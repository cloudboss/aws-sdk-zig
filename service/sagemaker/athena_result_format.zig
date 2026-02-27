/// The data storage format for Athena query results.
pub const AthenaResultFormat = enum {
    parquet,
    orc,
    avro,
    json,
    textfile,

    pub const json_field_names = .{
        .parquet = "PARQUET",
        .orc = "ORC",
        .avro = "AVRO",
        .json = "JSON",
        .textfile = "TEXTFILE",
    };
};
