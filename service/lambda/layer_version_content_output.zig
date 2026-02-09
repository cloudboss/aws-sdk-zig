/// Details about a version of an [Lambda
/// layer](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html).
pub const LayerVersionContentOutput = struct {
    /// The SHA-256 hash of the layer archive.
    code_sha_256: ?[]const u8,

    /// The size of the layer archive in bytes.
    code_size: ?i64,

    /// A link to the layer archive in Amazon S3 that is valid for 10 minutes.
    location: ?[]const u8,

    /// The Amazon Resource Name (ARN) of a signing job.
    signing_job_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) for a signing profile version.
    signing_profile_version_arn: ?[]const u8,
};
