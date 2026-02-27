pub const PhaseStatus = enum {
    pending,
    success,
    @"error",

    pub const json_field_names = .{
        .pending = "PENDING",
        .success = "SUCCESS",
        .@"error" = "ERROR",
    };
};
