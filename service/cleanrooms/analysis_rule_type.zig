pub const AnalysisRuleType = enum {
    aggregation,
    list,
    custom,
    id_mapping_table,

    pub const json_field_names = .{
        .aggregation = "AGGREGATION",
        .list = "LIST",
        .custom = "CUSTOM",
        .id_mapping_table = "ID_MAPPING_TABLE",
    };
};
