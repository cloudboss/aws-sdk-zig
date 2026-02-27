pub const FilterAction = enum {
    noop,
    archive,

    pub const json_field_names = .{
        .noop = "NOOP",
        .archive = "ARCHIVE",
    };
};
