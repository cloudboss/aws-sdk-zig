pub const AnalysisFormat = enum {
    sql,
    pyspark_1_0,

    pub const json_field_names = .{
        .sql = "SQL",
        .pyspark_1_0 = "PYSPARK_1_0",
    };
};
