pub const MessageTemplateFilterOperator = enum {
    equals,
    prefix,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .prefix = "PREFIX",
    };
};
