/// A key-signing key (KSK) is a complex type that represents a public/private
/// key pair.
/// The private key is used to generate a digital signature for the zone signing
/// key (ZSK).
/// The public key is stored in the DNS and is used to authenticate the ZSK. A
/// KSK is always
/// associated with a hosted zone; it cannot exist by itself.
pub const KeySigningKey = struct {
    /// The date when the key-signing key (KSK) was created.
    created_date: ?i64,

    /// A string used to represent the delegation signer digest algorithm. This
    /// value must
    /// follow the guidelines provided by [RFC-8624 Section
    /// 3.3](https://tools.ietf.org/html/rfc8624#section-3.3).
    digest_algorithm_mnemonic: ?[]const u8,

    /// An integer used to represent the delegation signer digest algorithm. This
    /// value must
    /// follow the guidelines provided by [RFC-8624 Section
    /// 3.3](https://tools.ietf.org/html/rfc8624#section-3.3).
    digest_algorithm_type: i32 = 0,

    /// A cryptographic digest of a DNSKEY resource record (RR). DNSKEY records are
    /// used to
    /// publish the public key that resolvers can use to verify DNSSEC signatures
    /// that are used
    /// to secure certain kinds of information provided by the DNS system.
    digest_value: ?[]const u8,

    /// A string that represents a DNSKEY record.
    dnskey_record: ?[]const u8,

    /// A string that represents a delegation signer (DS) record.
    ds_record: ?[]const u8,

    /// An integer that specifies how the key is used. For key-signing key (KSK),
    /// this value
    /// is always 257.
    flag: i32 = 0,

    /// An integer used to identify the DNSSEC record for the domain name. The
    /// process used to
    /// calculate the value is described in [RFC-4034 Appendix
    /// B](https://tools.ietf.org/rfc/rfc4034.txt).
    key_tag: i32 = 0,

    /// The Amazon resource name (ARN) used to identify the customer managed key in
    /// Key Management Service (KMS). The `KmsArn` must be unique for each
    /// key-signing key (KSK) in a single hosted zone.
    ///
    /// You must configure the customer managed key as follows:
    ///
    /// **Status**
    ///
    /// Enabled
    ///
    /// **Key spec**
    ///
    /// ECC_NIST_P256
    ///
    /// **Key usage**
    ///
    /// Sign and verify
    ///
    /// **Key policy**
    ///
    /// The key policy must give permission for the following actions:
    ///
    /// * DescribeKey
    ///
    /// * GetPublicKey
    ///
    /// * Sign
    ///
    /// The key policy must also include the Amazon Route 53 service in the
    /// principal for your account. Specify the following:
    ///
    /// * `"Service": "dnssec-route53.amazonaws.com"`
    ///
    /// For more information about working with the customer managed key in KMS, see
    /// [Key Management Service
    /// concepts](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html).
    kms_arn: ?[]const u8,

    /// The last time that the key-signing key (KSK) was changed.
    last_modified_date: ?i64,

    /// A string used to identify a key-signing key (KSK). `Name` can include
    /// numbers, letters, and underscores (_). `Name` must be unique for each
    /// key-signing key in the same hosted zone.
    name: ?[]const u8,

    /// The public key, represented as a Base64 encoding, as required by [ RFC-4034
    /// Page 5](https://tools.ietf.org/rfc/rfc4034.txt).
    public_key: ?[]const u8,

    /// A string used to represent the signing algorithm. This value must follow the
    /// guidelines provided by [RFC-8624 Section
    /// 3.1](https://tools.ietf.org/html/rfc8624#section-3.1).
    signing_algorithm_mnemonic: ?[]const u8,

    /// An integer used to represent the signing algorithm. This value must follow
    /// the
    /// guidelines provided by [RFC-8624 Section
    /// 3.1](https://tools.ietf.org/html/rfc8624#section-3.1).
    signing_algorithm_type: i32 = 0,

    /// A string that represents the current key-signing key (KSK) status.
    ///
    /// Status can have one of the following values:
    ///
    /// **ACTIVE**
    ///
    /// The KSK is being used for signing.
    ///
    /// **INACTIVE**
    ///
    /// The KSK is not being used for signing.
    ///
    /// **DELETING**
    ///
    /// The KSK is in the process of being deleted.
    ///
    /// **ACTION_NEEDED**
    ///
    /// There is a problem with the KSK that requires you to take action to
    /// resolve. For example, the customer managed key might have been deleted,
    /// or the permissions for the customer managed key might have been
    /// changed.
    ///
    /// **INTERNAL_FAILURE**
    ///
    /// There was an error during a request. Before you can continue to work with
    /// DNSSEC signing, including actions that involve this KSK, you must correct
    /// the problem. For example, you may need to activate or deactivate the
    /// KSK.
    status: ?[]const u8,

    /// The status message provided for the following key-signing key (KSK)
    /// statuses:
    /// `ACTION_NEEDED` or `INTERNAL_FAILURE`. The status message
    /// includes information about what the problem might be and steps that you can
    /// take to
    /// correct the issue.
    status_message: ?[]const u8,
};
