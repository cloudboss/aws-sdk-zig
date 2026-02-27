pub const PropagateMITags = enum {
    capacity_provider,
    none,

    pub const json_field_names = .{
        .capacity_provider = "CAPACITY_PROVIDER",
        .none = "NONE",
    };
};
