pub const SearchQueryScopeType = enum {
    name,
    content,

    pub const json_field_names = .{
        .name = "NAME",
        .content = "CONTENT",
    };
};
