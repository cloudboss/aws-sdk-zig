pub const SessionStatusCode = enum {
    rejected,
    expired,
    configuration_changed,

    pub const json_field_names = .{
        .rejected = "REJECTED",
        .expired = "EXPIRED",
        .configuration_changed = "CONFIGURATION_CHANGED",
    };
};
