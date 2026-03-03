/// Information about the DNSSEC key.
///
/// You get this from your DNS provider and then give it to Route 53 (by using
/// [AssociateDelegationSignerToDomain](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_AssociateDelegationSignerToDomain.html)) to pass it to the registry to establish
/// the chain of trust.
pub const DnssecKey = struct {
    /// The number of the public key’s cryptographic algorithm according to an
    /// [IANA](https://www.iana.org/assignments/dns-sec-alg-numbers/dns-sec-alg-numbers.xml) assignment.
    ///
    /// If Route 53 is your DNS service, set this to 13.
    ///
    /// For more information about enabling DNSSEC signing, see [Enabling DNSSEC
    /// signing and establishing a chain of
    /// trust](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-configuring-dnssec-enable-signing.html).
    algorithm: ?i32 = null,

    /// The delegation signer digest.
    ///
    /// Digest is calculated from the public key provided using specified digest
    /// algorithm and
    /// this digest is the actual value returned from the registry nameservers as
    /// the value of
    /// DS records.
    digest: ?[]const u8 = null,

    /// The number of the DS digest algorithm according to an IANA assignment.
    ///
    /// For more information, see
    /// [IANA](https://www.iana.org/assignments/ds-rr-types/ds-rr-types.xhtml)
    /// for DNSSEC Delegation Signer (DS) Resource Record (RR) Type Digest
    /// Algorithms.
    digest_type: ?i32 = null,

    /// Defines the type of key. It can be either a KSK (key-signing-key, value 257)
    /// or ZSK
    /// (zone-signing-key, value 256). Using KSK is always encouraged. Only use ZSK
    /// if your DNS
    /// provider isn't Route 53 and you don’t have KSK available.
    ///
    /// If you have KSK and ZSK keys, always use KSK to create a delegations signer
    /// (DS)
    /// record. If you have ZSK keys only – use ZSK to create a DS record.
    flags: ?i32 = null,

    /// An ID assigned to each DS record created by
    /// [AssociateDelegationSignerToDomain](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_AssociateDelegationSignerToDomain.html).
    id: ?[]const u8 = null,

    /// A numeric identification of the DNSKEY record referred to by this DS record.
    key_tag: ?i32 = null,

    /// The base64-encoded public key part of the key pair that is passed to the
    /// registry
    /// .
    public_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .algorithm = "Algorithm",
        .digest = "Digest",
        .digest_type = "DigestType",
        .flags = "Flags",
        .id = "Id",
        .key_tag = "KeyTag",
        .public_key = "PublicKey",
    };
};
