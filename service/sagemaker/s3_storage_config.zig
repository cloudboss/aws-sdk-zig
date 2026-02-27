/// The Amazon Simple Storage (Amazon S3) location and security configuration
/// for `OfflineStore`.
pub const S3StorageConfig = struct {
    /// The Amazon Web Services Key Management Service (KMS) key ARN of the key used
    /// to encrypt any objects written into the `OfflineStore` S3 location.
    ///
    /// The IAM `roleARN` that is passed as a parameter to `CreateFeatureGroup` must
    /// have below permissions to the `KmsKeyId`:
    ///
    /// * `"kms:GenerateDataKey"`
    kms_key_id: ?[]const u8,

    /// The S3 path where offline records are written.
    resolved_output_s3_uri: ?[]const u8,

    /// The S3 URI, or location in Amazon S3, of `OfflineStore`.
    ///
    /// S3 URIs have a format similar to the following:
    /// `s3://example-bucket/prefix/`.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .resolved_output_s3_uri = "ResolvedOutputS3Uri",
        .s3_uri = "S3Uri",
    };
};
