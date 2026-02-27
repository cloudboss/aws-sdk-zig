pub const OutputFormat = enum {
    csv,
    json,
    parquet,
    glueparquet,
    avro,
    orc,
    xml,
    tableauhyper,

    pub const json_field_names = .{
        .csv = "CSV",
        .json = "JSON",
        .parquet = "PARQUET",
        .glueparquet = "GLUEPARQUET",
        .avro = "AVRO",
        .orc = "ORC",
        .xml = "XML",
        .tableauhyper = "TABLEAUHYPER",
    };
};
