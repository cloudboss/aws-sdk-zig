pub const VisibilityType = enum {
    public,
    private,
    shared,

    pub const json_field_names = .{
        .public = "PUBLIC",
        .private = "PRIVATE",
        .shared = "SHARED",
    };
};
