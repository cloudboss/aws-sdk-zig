pub const SortAssociationsBy = enum {
    source_arn,
    destination_arn,
    source_type,
    destination_type,
    creation_time,

    pub const json_field_names = .{
        .source_arn = "SOURCE_ARN",
        .destination_arn = "DESTINATION_ARN",
        .source_type = "SOURCE_TYPE",
        .destination_type = "DESTINATION_TYPE",
        .creation_time = "CREATION_TIME",
    };
};
