pub const ConfirmationStatus = enum {
    none,
    confirmed,
    denied,

    pub const json_field_names = .{
        .none = "NONE",
        .confirmed = "CONFIRMED",
        .denied = "DENIED",
    };
};
