pub const RegistrationStatus = enum {
    registration_pending,
    registration_success,
    registration_failure,

    pub const json_field_names = .{
        .registration_pending = "REGISTRATION_PENDING",
        .registration_success = "REGISTRATION_SUCCESS",
        .registration_failure = "REGISTRATION_FAILURE",
    };
};
