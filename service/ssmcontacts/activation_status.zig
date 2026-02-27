pub const ActivationStatus = enum {
    activated,
    not_activated,

    pub const json_field_names = .{
        .activated = "ACTIVATED",
        .not_activated = "NOT_ACTIVATED",
    };
};
