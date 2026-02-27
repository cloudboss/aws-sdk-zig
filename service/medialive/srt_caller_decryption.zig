const Algorithm = @import("algorithm.zig").Algorithm;

/// The decryption settings for the SRT caller source. Present only if the
/// source has decryption enabled.
pub const SrtCallerDecryption = struct {
    /// The algorithm used to encrypt content.
    algorithm: ?Algorithm,

    /// The ARN for the secret in Secrets Manager. Someone in your organization must
    /// create a secret and provide you with its ARN. The secret holds the
    /// passphrase that MediaLive uses to decrypt the source content.
    passphrase_secret_arn: ?[]const u8,

    pub const json_field_names = .{
        .algorithm = "Algorithm",
        .passphrase_secret_arn = "PassphraseSecretArn",
    };
};
