pub const ResourceType = enum {
    system,
    custom,

    pub const json_field_names = .{
        .system = "SYSTEM",
        .custom = "CUSTOM",
    };
};
