pub const Type = enum {
    pull_request,
    repository_analysis,

    pub const json_field_names = .{
        .pull_request = "PULL_REQUEST",
        .repository_analysis = "REPOSITORY_ANALYSIS",
    };
};
