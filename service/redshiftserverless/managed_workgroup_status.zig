pub const ManagedWorkgroupStatus = enum {
    creating,
    deleting,
    modifying,
    available,
    not_available,

    pub const json_field_names = .{
        .creating = "CREATING",
        .deleting = "DELETING",
        .modifying = "MODIFYING",
        .available = "AVAILABLE",
        .not_available = "NOT_AVAILABLE",
    };
};
