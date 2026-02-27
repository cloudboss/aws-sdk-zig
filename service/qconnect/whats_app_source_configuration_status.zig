pub const WhatsAppSourceConfigurationStatus = enum {
    valid,
    invalid,
    rejected,

    pub const json_field_names = .{
        .valid = "VALID",
        .invalid = "INVALID",
        .rejected = "REJECTED",
    };
};
