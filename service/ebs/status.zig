pub const Status = enum {
    completed,
    pending,
    @"error",

    pub const json_field_names = .{
        .completed = "COMPLETED",
        .pending = "PENDING",
        .@"error" = "ERROR",
    };
};
