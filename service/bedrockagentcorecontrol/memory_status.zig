pub const MemoryStatus = enum {
    creating,
    active,
    failed,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .failed = "FAILED",
        .deleting = "DELETING",
    };
};
