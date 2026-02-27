pub const MpaRevokeSessionStatus = enum {
    pending,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .failed = "FAILED",
    };
};
