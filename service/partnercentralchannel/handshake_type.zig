pub const HandshakeType = enum {
    start_service_period,
    revoke_service_period,
    program_management_account,

    pub const json_field_names = .{
        .start_service_period = "START_SERVICE_PERIOD",
        .revoke_service_period = "REVOKE_SERVICE_PERIOD",
        .program_management_account = "PROGRAM_MANAGEMENT_ACCOUNT",
    };
};
