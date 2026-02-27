pub const AgreementStatus = enum {
    available,
    pending,
    not_available,
    @"error",

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .pending = "PENDING",
        .not_available = "NOT_AVAILABLE",
        .@"error" = "ERROR",
    };
};
