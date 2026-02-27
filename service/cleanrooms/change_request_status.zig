pub const ChangeRequestStatus = enum {
    pending,
    approved,
    cancelled,
    denied,
    committed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .approved = "APPROVED",
        .cancelled = "CANCELLED",
        .denied = "DENIED",
        .committed = "COMMITTED",
    };
};
