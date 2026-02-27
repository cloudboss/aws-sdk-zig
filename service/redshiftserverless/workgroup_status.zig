pub const WorkgroupStatus = enum {
    creating,
    available,
    modifying,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .available = "AVAILABLE",
        .modifying = "MODIFYING",
        .deleting = "DELETING",
    };
};
