pub const StorageAccessLevel = enum {
    public,
    protected,
    private,

    pub const json_field_names = .{
        .public = "PUBLIC",
        .protected = "PROTECTED",
        .private = "PRIVATE",
    };
};
