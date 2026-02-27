pub const WebserverAccessMode = enum {
    private_only,
    public_only,

    pub const json_field_names = .{
        .private_only = "PRIVATE_ONLY",
        .public_only = "PUBLIC_ONLY",
    };
};
