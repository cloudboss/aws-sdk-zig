pub const ComponentStatus = enum {
    deprecated,
    disabled,
    active,

    pub const json_field_names = .{
        .deprecated = "DEPRECATED",
        .disabled = "DISABLED",
        .active = "ACTIVE",
    };
};
