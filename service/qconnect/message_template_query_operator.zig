pub const MessageTemplateQueryOperator = enum {
    contains,
    contains_and_prefix,

    pub const json_field_names = .{
        .contains = "CONTAINS",
        .contains_and_prefix = "CONTAINS_AND_PREFIX",
    };
};
