const aws = @import("aws");

/// Use this structure to propose allowing [cryptographic
/// operations](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#cryptographic-operations) in the grant only when the operation request includes the specified [encryption context](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context). You can specify only one type of encryption context. An empty map is treated as not specified. For more information, see [GrantConstraints](https://docs.aws.amazon.com/kms/latest/APIReference/API_GrantConstraints.html).
pub const KmsGrantConstraints = struct {
    /// A list of key-value pairs that must match the encryption context in the
    /// [cryptographic
    /// operation](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#cryptographic-operations) request. The grant allows the operation only when the encryption context in the request is the same as the encryption context specified in this constraint.
    encryption_context_equals: ?[]const aws.map.StringMapEntry,

    /// A list of key-value pairs that must be included in the encryption context of
    /// the [cryptographic
    /// operation](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#cryptographic-operations) request. The grant allows the cryptographic operation only when the encryption context in the request includes the key-value pairs specified in this constraint, although it can include additional key-value pairs.
    encryption_context_subset: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .encryption_context_equals = "encryptionContextEquals",
        .encryption_context_subset = "encryptionContextSubset",
    };
};
