pub const Mtime = enum {
    none,
    preserve,

    pub const json_field_names = .{
        .none = "NONE",
        .preserve = "PRESERVE",
    };
};
