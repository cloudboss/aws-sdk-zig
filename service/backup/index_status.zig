pub const IndexStatus = enum {
    pending,
    active,
    failed,
    deleting,

    pub const json_field_names = .{
        .pending = "PENDING",
        .active = "ACTIVE",
        .failed = "FAILED",
        .deleting = "DELETING",
    };
};
