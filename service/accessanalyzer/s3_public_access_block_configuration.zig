/// The `PublicAccessBlock` configuration to apply to this Amazon S3 bucket. If
/// the proposed configuration is for an existing Amazon S3 bucket and the
/// configuration is not specified, the access preview uses the existing
/// setting. If the proposed configuration is for a new bucket and the
/// configuration is not specified, the access preview uses `false`. If the
/// proposed configuration is for a new access point or multi-region access
/// point and the access point BPA configuration is not specified, the access
/// preview uses `true`. For more information, see
/// [PublicAccessBlockConfiguration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-bucket-publicaccessblockconfiguration.html).
pub const S3PublicAccessBlockConfiguration = struct {
    /// Specifies whether Amazon S3 should ignore public ACLs for this bucket and
    /// objects in this bucket.
    ignore_public_acls: bool,

    /// Specifies whether Amazon S3 should restrict public bucket policies for this
    /// bucket.
    restrict_public_buckets: bool,

    pub const json_field_names = .{
        .ignore_public_acls = "ignorePublicAcls",
        .restrict_public_buckets = "restrictPublicBuckets",
    };
};
