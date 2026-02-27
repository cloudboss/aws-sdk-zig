pub const ClientCredentialsSource = enum {
    plain_credentials,

    pub const json_field_names = .{
        .plain_credentials = "PLAIN_CREDENTIALS",
    };
};
