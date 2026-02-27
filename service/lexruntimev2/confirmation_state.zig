pub const ConfirmationState = enum {
    confirmed,
    denied,
    none,

    pub const json_field_names = .{
        .confirmed = "CONFIRMED",
        .denied = "DENIED",
        .none = "NONE",
    };
};
