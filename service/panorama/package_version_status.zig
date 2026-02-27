pub const PackageVersionStatus = enum {
    register_pending,
    register_completed,
    failed,
    deleting,

    pub const json_field_names = .{
        .register_pending = "REGISTER_PENDING",
        .register_completed = "REGISTER_COMPLETED",
        .failed = "FAILED",
        .deleting = "DELETING",
    };
};
