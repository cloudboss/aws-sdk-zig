pub const BlueprintType = enum {
    os,
    app,

    pub const json_field_names = .{
        .os = "os",
        .app = "app",
    };
};
