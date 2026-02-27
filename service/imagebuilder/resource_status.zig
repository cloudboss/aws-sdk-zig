pub const ResourceStatus = enum {
    available,
    deleted,
    deprecated,
    disabled,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .deleted = "DELETED",
        .deprecated = "DEPRECATED",
        .disabled = "DISABLED",
    };
};
