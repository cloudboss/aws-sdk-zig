pub const PatchAction = enum {
    allow_as_dependency,
    block,

    pub const json_field_names = .{
        .allow_as_dependency = "AllowAsDependency",
        .block = "Block",
    };
};
