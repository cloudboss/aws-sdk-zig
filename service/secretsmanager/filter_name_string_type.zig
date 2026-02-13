pub const FilterNameStringType = enum {
    description,
    name,
    tag_key,
    tag_value,
    primary_region,
    owning_service,
    all,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .tag_key = "tag_key",
        .tag_value = "tag_value",
        .primary_region = "primary_region",
        .owning_service = "owning_service",
        .all = "all",
    };
};
