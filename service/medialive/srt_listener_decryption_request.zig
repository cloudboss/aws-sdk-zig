const Algorithm = @import("algorithm.zig").Algorithm;

/// Decryption settings. If specified, both algorithm and passphraseSecretArn
/// are required.
pub const SrtListenerDecryptionRequest = struct {
    /// Required. The decryption algorithm.
    algorithm: Algorithm,

    /// Required. The ARN for the secret in Secrets Manager that holds the
    /// passphrase.
    passphrase_secret_arn: []const u8,

    pub const json_field_names = .{
        .algorithm = "Algorithm",
        .passphrase_secret_arn = "PassphraseSecretArn",
    };
};
