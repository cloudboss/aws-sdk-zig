pub const Type = enum {
    tag_context,
    request_context,

    pub const json_field_names = .{
        .tag_context = "TagContext",
        .request_context = "RequestContext",
    };
};
