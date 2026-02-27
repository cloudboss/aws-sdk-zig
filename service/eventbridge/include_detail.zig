pub const IncludeDetail = enum {
    none,
    full,

    pub const json_field_names = .{
        .none = "NONE",
        .full = "FULL",
    };
};
