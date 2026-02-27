pub const FilterType = enum {
    system,
    endpoint,

    pub const json_field_names = .{
        .system = "SYSTEM",
        .endpoint = "ENDPOINT",
    };
};
