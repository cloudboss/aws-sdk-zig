pub const ApprovalStatus = enum {
    approved,
    denied,
    pending,

    pub const json_field_names = .{
        .approved = "APPROVED",
        .denied = "DENIED",
        .pending = "PENDING",
    };
};
