pub const QuerySuggestionsStatus = enum {
    active,
    updating,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .updating = "UPDATING",
    };
};
