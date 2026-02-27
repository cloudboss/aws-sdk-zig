pub const SharedResourceSortByType = enum {
    arn,
    modified_time,

    pub const json_field_names = .{
        .arn = "ARN",
        .modified_time = "MODIFIED_TIME",
    };
};
