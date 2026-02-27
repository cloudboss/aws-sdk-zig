pub const TargetFormat = enum {
    json,
    csv,
    avro,
    orc,
    parquet,
    hudi,
    delta,
    iceberg,
    hyper,
    xml,

    pub const json_field_names = .{
        .json = "JSON",
        .csv = "CSV",
        .avro = "AVRO",
        .orc = "ORC",
        .parquet = "PARQUET",
        .hudi = "HUDI",
        .delta = "DELTA",
        .iceberg = "ICEBERG",
        .hyper = "HYPER",
        .xml = "XML",
    };
};
