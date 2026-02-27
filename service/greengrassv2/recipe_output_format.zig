pub const RecipeOutputFormat = enum {
    json,
    yaml,

    pub const json_field_names = .{
        .json = "JSON",
        .yaml = "YAML",
    };
};
