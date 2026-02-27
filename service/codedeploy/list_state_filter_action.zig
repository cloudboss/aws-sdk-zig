pub const ListStateFilterAction = enum {
    include,
    exclude,
    ignore,

    pub const json_field_names = .{
        .include = "Include",
        .exclude = "Exclude",
        .ignore = "Ignore",
    };
};
