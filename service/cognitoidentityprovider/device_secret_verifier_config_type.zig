/// A Secure Remote Password (SRP) value that your application generates when
/// you register
/// a user's device. For more information, see [Getting a device
/// key](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-device-tracking.html#user-pools-remembered-devices-getting-a-device-key).
pub const DeviceSecretVerifierConfigType = struct {
    /// A password verifier for a user's device. Used in SRP authentication.
    password_verifier: ?[]const u8,

    /// The salt that you want to use in SRP authentication with the user's device.
    salt: ?[]const u8,

    pub const json_field_names = .{
        .password_verifier = "PasswordVerifier",
        .salt = "Salt",
    };
};
