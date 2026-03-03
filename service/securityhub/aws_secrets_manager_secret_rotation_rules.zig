/// Defines the rotation schedule for the secret.
pub const AwsSecretsManagerSecretRotationRules = struct {
    /// The number of days after the previous rotation to rotate the secret.
    automatically_after_days: ?i32 = null,

    pub const json_field_names = .{
        .automatically_after_days = "AutomaticallyAfterDays",
    };
};
