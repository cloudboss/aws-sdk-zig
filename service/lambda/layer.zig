/// An [Lambda
/// layer](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html).
pub const Layer = struct {
    /// The Amazon Resource Name (ARN) of the function layer.
    arn: ?[]const u8 = null,

    /// The size of the layer archive in bytes.
    code_size: i64 = 0,

    /// The Amazon Resource Name (ARN) of a signing job.
    signing_job_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for a signing profile version.
    signing_profile_version_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .code_size = "CodeSize",
        .signing_job_arn = "SigningJobArn",
        .signing_profile_version_arn = "SigningProfileVersionArn",
    };
};
