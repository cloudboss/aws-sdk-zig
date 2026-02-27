/// Information about the [external key
/// ](https://docs.aws.amazon.com/kms/latest/developerguide/keystore-external.html#concept-external-key)that is
/// associated with a KMS key in an external key store.
///
/// This element appears in a CreateKey or DescribeKey
/// response only for a KMS key in an external key store.
///
/// The *external key* is a symmetric encryption key that is hosted by an
/// external key manager outside of Amazon Web Services. When you use the KMS
/// key in an external key store in a
/// cryptographic operation, the cryptographic operation is performed in the
/// external key manager
/// using the specified external key. For more information, see [External
/// key](https://docs.aws.amazon.com/kms/latest/developerguide/keystore-external.html#concept-external-key) in the
/// *Key Management Service Developer Guide*.
pub const XksKeyConfigurationType = struct {
    /// The ID of the external key in its external key manager. This is the ID that
    /// the external
    /// key store proxy uses to identify the external key.
    id: ?[]const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};
