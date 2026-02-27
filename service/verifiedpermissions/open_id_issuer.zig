pub const OpenIdIssuer = enum {
    cognito,

    pub const json_field_names = .{
        .cognito = "COGNITO",
    };
};
