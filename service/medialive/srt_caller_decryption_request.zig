const Algorithm = @import("algorithm.zig").Algorithm;

/// Complete these parameters only if the content is encrypted.
pub const SrtCallerDecryptionRequest = struct {
    /// The algorithm used to encrypt content.
    algorithm: ?Algorithm,

    /// The ARN for the secret in Secrets Manager. Someone in your organization must
    /// create a secret and provide you with its ARN. This secret holds the
    /// passphrase that MediaLive will use to decrypt the source content.
    passphrase_secret_arn: ?[]const u8,

    pub const json_field_names = .{
        .algorithm = "Algorithm",
        .passphrase_secret_arn = "PassphraseSecretArn",
    };
};
