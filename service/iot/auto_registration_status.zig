pub const AutoRegistrationStatus = enum {
    enable,
    disable,

    pub const json_field_names = .{
        .enable = "ENABLE",
        .disable = "DISABLE",
    };
};
