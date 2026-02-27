pub const DatabaseConnectionMethod = enum {
    direct,
    overlay,

    pub const json_field_names = .{
        .direct = "DIRECT",
        .overlay = "OVERLAY",
    };
};
