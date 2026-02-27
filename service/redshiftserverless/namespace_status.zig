pub const NamespaceStatus = enum {
    available,
    modifying,
    deleting,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .modifying = "MODIFYING",
        .deleting = "DELETING",
    };
};
