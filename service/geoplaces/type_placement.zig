pub const TypePlacement = enum {
    before_base_name,
    after_base_name,

    pub const json_field_names = .{
        .before_base_name = "BEFORE_BASE_NAME",
        .after_base_name = "AFTER_BASE_NAME",
    };
};
