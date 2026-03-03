/// The Amazon S3 data for the Vector Enrichment job.
pub const VectorEnrichmentJobS3Data = struct {
    /// The Key Management Service key ID for server-side encryption.
    kms_key_id: ?[]const u8 = null,

    /// The URL to the Amazon S3 data for the Vector Enrichment job.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .s3_uri = "S3Uri",
    };
};
