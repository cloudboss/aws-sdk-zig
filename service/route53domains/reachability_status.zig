pub const ReachabilityStatus = enum {
    pending,
    done,
    expired,

    pub const json_field_names = .{
        .pending = "PENDING",
        .done = "DONE",
        .expired = "EXPIRED",
    };
};
