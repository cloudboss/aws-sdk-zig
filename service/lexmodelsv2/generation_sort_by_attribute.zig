pub const GenerationSortByAttribute = enum {
    creation_start_time,
    last_updated_time,

    pub const json_field_names = .{
        .creation_start_time = "creationStartTime",
        .last_updated_time = "lastUpdatedTime",
    };
};
