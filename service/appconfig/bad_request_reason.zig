pub const BadRequestReason = enum {
    invalid_configuration,

    pub const json_field_names = .{
        .invalid_configuration = "INVALID_CONFIGURATION",
    };
};
