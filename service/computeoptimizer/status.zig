pub const Status = enum {
    active,
    inactive,
    pending,
    failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .pending = "PENDING",
        .failed = "FAILED",
    };
};
