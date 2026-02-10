const KeyType = @import("key_type.zig").KeyType;
const Tag = @import("tag.zig").Tag;

/// Describes a key pair.
pub const KeyPairInfo = struct {
    /// If you used Amazon EC2 to create the key pair, this is the date and time
    /// when the key
    /// was created, in [ISO
    /// 8601 date-time
    /// format](https://www.iso.org/iso-8601-date-and-time-format.html), in the UTC
    /// time zone.
    ///
    /// If you imported an existing key pair to Amazon EC2, this is the date and
    /// time the key
    /// was imported, in [ISO
    /// 8601 date-time
    /// format](https://www.iso.org/iso-8601-date-and-time-format.html), in the UTC
    /// time zone.
    create_time: ?i64,

    /// If you used CreateKeyPair to create the key pair:
    ///
    /// * For RSA key pairs, the key fingerprint is the SHA-1 digest of the DER
    ///   encoded private key.
    ///
    /// * For ED25519 key pairs, the key fingerprint is the base64-encoded SHA-256
    ///   digest, which
    /// is the default for OpenSSH, starting with [OpenSSH
    /// 6.8](http://www.openssh.com/txt/release-6.8).
    ///
    /// If you used ImportKeyPair to provide Amazon Web Services the public key:
    ///
    /// * For RSA key pairs, the key fingerprint is the MD5 public key fingerprint
    ///   as specified in section 4 of RFC4716.
    ///
    /// * For ED25519 key pairs, the key fingerprint is the base64-encoded SHA-256
    /// digest, which is the default for OpenSSH, starting with [OpenSSH
    /// 6.8](http://www.openssh.com/txt/release-6.8).
    key_fingerprint: ?[]const u8,

    /// The name of the key pair.
    key_name: ?[]const u8,

    /// The ID of the key pair.
    key_pair_id: ?[]const u8,

    /// The type of key pair.
    key_type: ?KeyType,

    /// The public key material.
    public_key: ?[]const u8,

    /// Any tags applied to the key pair.
    tags: ?[]const Tag,
};
