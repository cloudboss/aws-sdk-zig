pub const ComponentVisibilityScope = enum {
    private,
    public,

    pub const json_field_names = .{
        .private = "PRIVATE",
        .public = "PUBLIC",
    };
};
