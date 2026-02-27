pub const RegistryStatus = enum {
    available,
    deleting,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .deleting = "DELETING",
    };
};
