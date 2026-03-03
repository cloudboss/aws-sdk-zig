/// Information about an origin that is an Amazon S3 bucket that is not
/// configured with static website
/// hosting.
pub const AwsCloudFrontDistributionOriginS3OriginConfig = struct {
    /// The CloudFront origin access identity to associate with the origin.
    origin_access_identity: ?[]const u8 = null,

    pub const json_field_names = .{
        .origin_access_identity = "OriginAccessIdentity",
    };
};
