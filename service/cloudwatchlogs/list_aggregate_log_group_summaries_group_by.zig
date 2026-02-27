pub const ListAggregateLogGroupSummariesGroupBy = enum {
    data_source_name_type_and_format,
    data_source_name_and_type,

    pub const json_field_names = .{
        .data_source_name_type_and_format = "DATA_SOURCE_NAME_TYPE_AND_FORMAT",
        .data_source_name_and_type = "DATA_SOURCE_NAME_AND_TYPE",
    };
};
