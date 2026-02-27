pub const ConfluenceVersion = enum {
    cloud,
    server,

    pub const json_field_names = .{
        .cloud = "CLOUD",
        .server = "SERVER",
    };
};
