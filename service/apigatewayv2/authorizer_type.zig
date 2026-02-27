/// The authorizer type. Specify REQUEST for a Lambda function using incoming
/// request parameters. Specify JWT to use JSON Web Tokens (supported only for
/// HTTP APIs).
pub const AuthorizerType = enum {
    request,
    jwt,

    pub const json_field_names = .{
        .request = "REQUEST",
        .jwt = "JWT",
    };
};
