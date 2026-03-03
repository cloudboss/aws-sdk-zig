/// Describes the public SSH host keys or the RDP certificate.
pub const HostKeyAttributes = struct {
    /// The SSH host key algorithm or the RDP certificate format.
    ///
    /// For SSH host keys, the algorithm may be `ssh-rsa`,
    /// `ecdsa-sha2-nistp256`, `ssh-ed25519`, etc. For RDP certificates, the
    /// algorithm is always `x509-cert`.
    algorithm: ?[]const u8 = null,

    /// The SHA-1 fingerprint of the returned SSH host key or RDP certificate.
    ///
    /// * Example of an SHA-1 SSH fingerprint:
    ///
    /// `SHA1:1CHH6FaAaXjtFOsR/t83vf91SR0`
    ///
    /// * Example of an SHA-1 RDP fingerprint:
    ///
    /// `af:34:51:fe:09:f0:e0:da:b8:4e:56:ca:60:c2:10:ff:38:06:db:45`
    fingerprint_sha1: ?[]const u8 = null,

    /// The SHA-256 fingerprint of the returned SSH host key or RDP certificate.
    ///
    /// * Example of an SHA-256 SSH fingerprint:
    ///
    /// `SHA256:KTsMnRBh1IhD17HpdfsbzeGA4jOijm5tyXsMjKVbB8o`
    ///
    /// * Example of an SHA-256 RDP fingerprint:
    ///
    /// `03:9b:36:9f:4b:de:4e:61:70:fc:7c:c9:78:e7:d2:1a:1c:25:a8:0c:91:f6:7c:e4:d6:a0:85:c8:b4:53:99:68`
    fingerprint_sha256: ?[]const u8 = null,

    /// The returned RDP certificate is not valid after this point in time.
    ///
    /// This value is listed only for RDP certificates.
    not_valid_after: ?i64 = null,

    /// The returned RDP certificate is valid after this point in time.
    ///
    /// This value is listed only for RDP certificates.
    not_valid_before: ?i64 = null,

    /// The public SSH host key or the RDP certificate.
    public_key: ?[]const u8 = null,

    /// The time that the SSH host key or RDP certificate was recorded by Lightsail.
    witnessed_at: ?i64 = null,

    pub const json_field_names = .{
        .algorithm = "algorithm",
        .fingerprint_sha1 = "fingerprintSHA1",
        .fingerprint_sha256 = "fingerprintSHA256",
        .not_valid_after = "notValidAfter",
        .not_valid_before = "notValidBefore",
        .public_key = "publicKey",
        .witnessed_at = "witnessedAt",
    };
};
