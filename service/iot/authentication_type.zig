pub const AuthenticationType = enum {
    custom_auth_x509,
    custom_auth,
    aws_x509,
    aws_sigv4,
    default,

    pub const json_field_names = .{
        .custom_auth_x509 = "CUSTOM_AUTH_X509",
        .custom_auth = "CUSTOM_AUTH",
        .aws_x509 = "AWS_X509",
        .aws_sigv4 = "AWS_SIGV4",
        .default = "DEFAULT",
    };
};
