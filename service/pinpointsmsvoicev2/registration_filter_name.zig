pub const RegistrationFilterName = enum {
    registration_type,
    registration_status,

    pub const json_field_names = .{
        .registration_type = "REGISTRATION_TYPE",
        .registration_status = "REGISTRATION_STATUS",
    };
};
