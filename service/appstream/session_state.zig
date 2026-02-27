/// Possible values for the state of a streaming session.
pub const SessionState = enum {
    active,
    pending,
    expired,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .pending = "PENDING",
        .expired = "EXPIRED",
    };
};
