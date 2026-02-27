pub const ApiCacheStatus = enum {
    available,
    creating,
    deleting,
    modifying,
    failed,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .creating = "CREATING",
        .deleting = "DELETING",
        .modifying = "MODIFYING",
        .failed = "FAILED",
    };
};
