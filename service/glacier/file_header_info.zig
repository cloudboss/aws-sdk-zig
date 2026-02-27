pub const FileHeaderInfo = enum {
    use,
    ignore,
    none,

    pub const json_field_names = .{
        .use = "Use",
        .ignore = "Ignore",
        .none = "None",
    };
};
