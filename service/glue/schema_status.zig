pub const SchemaStatus = enum {
    available,
    pending,
    deleting,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .pending = "PENDING",
        .deleting = "DELETING",
    };
};
