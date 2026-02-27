pub const PortAccessType = enum {
    public,
    private,

    pub const json_field_names = .{
        .public = "Public",
        .private = "Private",
    };
};
