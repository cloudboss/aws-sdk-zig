pub const TableStatus = enum {
    active,
    deleting,
    restoring,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .deleting = "DELETING",
        .restoring = "RESTORING",
    };
};
