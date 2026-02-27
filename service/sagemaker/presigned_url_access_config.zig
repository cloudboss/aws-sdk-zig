/// Configuration for accessing hub content through presigned URLs, including
/// license agreement acceptance and URL validation settings.
pub const PresignedUrlAccessConfig = struct {
    /// Indicates acceptance of the End User License Agreement (EULA) for gated
    /// models. Set to true to acknowledge acceptance of the license terms required
    /// for accessing gated content.
    accept_eula: ?bool,

    /// The expected S3 URL prefix for validation purposes. This parameter helps
    /// ensure consistency between the resolved S3 URIs and the deployment
    /// configuration, reducing potential compatibility issues.
    expected_s3_url: ?[]const u8,

    pub const json_field_names = .{
        .accept_eula = "AcceptEula",
        .expected_s3_url = "ExpectedS3Url",
    };
};
