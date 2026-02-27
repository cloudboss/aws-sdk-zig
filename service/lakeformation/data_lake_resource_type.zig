pub const DataLakeResourceType = enum {
    catalog,
    database,
    table,
    data_location,
    lf_tag,
    lf_tag_policy,
    lf_tag_policy_database,
    lf_tag_policy_table,
    lf_named_tag_expression,

    pub const json_field_names = .{
        .catalog = "CATALOG",
        .database = "DATABASE",
        .table = "TABLE",
        .data_location = "DATA_LOCATION",
        .lf_tag = "LF_TAG",
        .lf_tag_policy = "LF_TAG_POLICY",
        .lf_tag_policy_database = "LF_TAG_POLICY_DATABASE",
        .lf_tag_policy_table = "LF_TAG_POLICY_TABLE",
        .lf_named_tag_expression = "LF_NAMED_TAG_EXPRESSION",
    };
};
