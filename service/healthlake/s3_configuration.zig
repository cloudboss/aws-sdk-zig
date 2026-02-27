/// The configuration of the S3 bucket for either an import or export job. This
/// includes
/// assigning access permissions.
pub const S3Configuration = struct {
    /// The Key Management Service (KMS) key ID used to access the S3 bucket.
    kms_key_id: []const u8,

    /// The `S3Uri` is the user-specified S3 location of the FHIR data to be
    /// imported into AWS HealthLake.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .s3_uri = "S3Uri",
    };
};
