pub const AssemblyType = enum {
    none,
    line,

    pub const json_field_names = .{
        .none = "NONE",
        .line = "LINE",
    };
};
