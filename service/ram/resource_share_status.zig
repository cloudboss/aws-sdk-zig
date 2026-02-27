pub const ResourceShareStatus = enum {
    pending,
    active,
    failed,
    deleting,
    deleted,

    pub const json_field_names = .{
        .pending = "PENDING",
        .active = "ACTIVE",
        .failed = "FAILED",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };
};
