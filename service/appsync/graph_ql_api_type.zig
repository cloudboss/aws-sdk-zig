pub const GraphQLApiType = enum {
    graphql,
    merged,

    pub const json_field_names = .{
        .graphql = "GRAPHQL",
        .merged = "MERGED",
    };
};
