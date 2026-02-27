/// The password data for the Windows Server-based instance, including the
/// ciphertext and the
/// key pair name.
pub const PasswordData = struct {
    /// The encrypted password. Ciphertext will be an empty string if access to your
    /// new instance
    /// is not ready yet. When you create an instance, it can take up to 15 minutes
    /// for the instance
    /// to be ready.
    ///
    /// If you use the default key pair (`LightsailDefaultKeyPair`), the decrypted
    /// password will be available in the password field.
    ///
    /// If you are using a custom key pair, you need to use your own means of
    /// decryption.
    ///
    /// If you change the Administrator password on the instance, Lightsail will
    /// continue to
    /// return the original ciphertext value. When accessing the instance using RDP,
    /// you need to
    /// manually enter the Administrator password after changing it from the
    /// default.
    ciphertext: ?[]const u8,

    /// The name of the key pair that you used when creating your instance. If no
    /// key pair name
    /// was specified when creating the instance, Lightsail uses the default key
    /// pair
    /// (`LightsailDefaultKeyPair`).
    ///
    /// If you are using a custom key pair, you need to use your own means of
    /// decrypting your
    /// password using the `ciphertext`. Lightsail creates the ciphertext by
    /// encrypting
    /// your password with the public key part of this key pair.
    key_pair_name: ?[]const u8,

    pub const json_field_names = .{
        .ciphertext = "ciphertext",
        .key_pair_name = "keyPairName",
    };
};
