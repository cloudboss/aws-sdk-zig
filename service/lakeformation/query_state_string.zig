pub const QueryStateString = enum {
    pending,
    workunits_available,
    @"error",
    finished,
    expired,

    pub const json_field_names = .{
        .pending = "PENDING",
        .workunits_available = "WORKUNITS_AVAILABLE",
        .@"error" = "ERROR",
        .finished = "FINISHED",
        .expired = "EXPIRED",
    };
};
