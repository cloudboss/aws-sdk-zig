/// Information about a delegation signer (DS) record that was created in the
/// registry by
/// [AssociateDelegationSignerToDomain](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_AssociateDelegationSignerToDomain.html).
pub const DnssecSigningAttributes = struct {
    /// Algorithm which was used to generate the digest from the public key.
    algorithm: ?i32 = null,

    /// Defines the type of key. It can be either a KSK (key-signing-key, value 257)
    /// or ZSK
    /// (zone-signing-key, value 256). Using KSK is always encouraged. Only use ZSK
    /// if your DNS
    /// provider isn't Route 53 and you don’t have KSK available.
    ///
    /// If you have KSK and ZSK keys, always use KSK to create a delegations signer
    /// (DS)
    /// record. If you have ZSK keys only – use ZSK to create a DS record.
    flags: ?i32 = null,

    /// The base64-encoded public key part of the key pair that is passed to the
    /// registry.
    public_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .algorithm = "Algorithm",
        .flags = "Flags",
        .public_key = "PublicKey",
    };
};
