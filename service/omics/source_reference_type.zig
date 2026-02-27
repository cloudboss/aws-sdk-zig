pub const SourceReferenceType = enum {
    branch,
    tag,
    commit,

    pub const json_field_names = .{
        .branch = "BRANCH",
        .tag = "TAG",
        .commit = "COMMIT",
    };
};
