pub const EnvironmentAccountConnectionRequesterAccountType = enum {
    management_account,
    environment_account,

    pub const json_field_names = .{
        .management_account = "MANAGEMENT_ACCOUNT",
        .environment_account = "ENVIRONMENT_ACCOUNT",
    };
};
