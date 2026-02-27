pub const MpaSessionStatus = enum {
    pending,
    approved,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .approved = "APPROVED",
        .failed = "FAILED",
    };
};
