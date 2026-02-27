pub const ResourceImportStrategyType = enum {
    add_only,
    replace_all,

    pub const json_field_names = .{
        .add_only = "ADD_ONLY",
        .replace_all = "REPLACE_ALL",
    };
};
