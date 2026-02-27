pub const RepositoryFilterType = enum {
    prefix_match,

    pub const json_field_names = .{
        .prefix_match = "PREFIX_MATCH",
    };
};
