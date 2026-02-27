const NoAuthentication = @import("no_authentication.zig").NoAuthentication;

/// Authentication for the relay destination server—specify the secretARN where
/// the SMTP credentials are stored, or specify an empty NoAuthentication
/// structure if the relay destination server does not require SMTP credential
/// authentication.
pub const RelayAuthentication = union(enum) {
    /// Keep an empty structure if the relay destination server does not require
    /// SMTP credential authentication.
    no_authentication: ?NoAuthentication,
    /// The ARN of the secret created in secrets manager where the relay server's
    /// SMTP credentials are stored.
    secret_arn: ?[]const u8,

    pub const json_field_names = .{
        .no_authentication = "NoAuthentication",
        .secret_arn = "SecretArn",
    };
};
