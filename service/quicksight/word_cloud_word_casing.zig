pub const WordCloudWordCasing = enum {
    lower_case,
    existing_case,

    pub const json_field_names = .{
        .lower_case = "LOWER_CASE",
        .existing_case = "EXISTING_CASE",
    };
};
