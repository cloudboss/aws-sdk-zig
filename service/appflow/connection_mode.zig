pub const ConnectionMode = enum {
    public,
    private,

    pub const json_field_names = .{
        .public = "PUBLIC",
        .private = "PRIVATE",
    };
};
