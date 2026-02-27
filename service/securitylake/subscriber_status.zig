pub const SubscriberStatus = enum {
    active,
    deactivated,
    pending,
    ready,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .deactivated = "DEACTIVATED",
        .pending = "PENDING",
        .ready = "READY",
    };
};
