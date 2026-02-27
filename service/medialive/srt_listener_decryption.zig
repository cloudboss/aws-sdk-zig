const Algorithm = @import("algorithm.zig").Algorithm;

/// Decryption settings for SRT listener. If present, both algorithm and
/// passphraseSecretArn are required.
pub const SrtListenerDecryption = struct {
    /// The algorithm used to decrypt content.
    algorithm: Algorithm,

    /// The ARN for the secret in Secrets Manager that holds the passphrase for
    /// decryption.
    passphrase_secret_arn: []const u8,

    pub const json_field_names = .{
        .algorithm = "Algorithm",
        .passphrase_secret_arn = "PassphraseSecretArn",
    };
};
