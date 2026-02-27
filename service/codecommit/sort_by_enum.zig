pub const SortByEnum = enum {
    repository_name,
    modified_date,

    pub const json_field_names = .{
        .repository_name = "REPOSITORY_NAME",
        .modified_date = "MODIFIED_DATE",
    };
};
