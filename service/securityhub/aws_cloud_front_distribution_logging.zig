/// A complex type that controls whether access logs are written for the
/// CloudFront distribution.
pub const AwsCloudFrontDistributionLogging = struct {
    /// The S3 bucket to store the access logs in.
    bucket: ?[]const u8,

    /// With this field, you can enable or disable the selected distribution.
    enabled: ?bool,

    /// Specifies whether you want CloudFront to include cookies in access logs.
    include_cookies: ?bool,

    /// An optional string that you want CloudFront to use as a prefix to the access
    /// log
    /// filenames for this distribution.
    prefix: ?[]const u8,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .enabled = "Enabled",
        .include_cookies = "IncludeCookies",
        .prefix = "Prefix",
    };
};
