pub const ApiKeySourceType = enum {
    header,
    authorizer,

    pub const json_field_names = .{
        .header = "HEADER",
        .authorizer = "AUTHORIZER",
    };
};
