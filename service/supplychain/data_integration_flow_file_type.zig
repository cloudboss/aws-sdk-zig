pub const DataIntegrationFlowFileType = enum {
    csv,
    parquet,
    json,

    pub const json_field_names = .{
        .csv = "CSV",
        .parquet = "PARQUET",
        .json = "JSON",
    };
};
