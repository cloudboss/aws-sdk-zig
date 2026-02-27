pub const PromptRouterType = enum {
    custom,
    default,

    pub const json_field_names = .{
        .custom = "CUSTOM",
        .default = "DEFAULT",
    };
};
