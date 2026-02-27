pub const ObjectTypeEnum = enum {
    file,
    directory,
    git_link,
    symbolic_link,

    pub const json_field_names = .{
        .file = "FILE",
        .directory = "DIRECTORY",
        .git_link = "GIT_LINK",
        .symbolic_link = "SYMBOLIC_LINK",
    };
};
