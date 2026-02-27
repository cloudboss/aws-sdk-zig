const NetworkOriginConfiguration = @import("network_origin_configuration.zig").NetworkOriginConfiguration;
const S3PublicAccessBlockConfiguration = @import("s3_public_access_block_configuration.zig").S3PublicAccessBlockConfiguration;

/// The configuration for an Amazon S3 access point or multi-region access point
/// for the bucket. You can propose up to 10 access points or multi-region
/// access points per bucket. If the proposed Amazon S3 access point
/// configuration is for an existing bucket, the access preview uses the
/// proposed access point configuration in place of the existing access points.
/// To propose an access point without a policy, you can provide an empty string
/// as the access point policy. For more information, see [Creating access
/// points](https://docs.aws.amazon.com/AmazonS3/latest/dev/creating-access-points.html). For more information about access point policy limits, see [Access points restrictions and limitations](https://docs.aws.amazon.com/AmazonS3/latest/dev/access-points-restrictions-limitations.html).
pub const S3AccessPointConfiguration = struct {
    /// The access point or multi-region access point policy.
    access_point_policy: ?[]const u8,

    /// The proposed `Internet` and `VpcConfiguration` to apply to this Amazon S3
    /// access point. `VpcConfiguration` does not apply to multi-region access
    /// points. If the access preview is for a new resource and neither is
    /// specified, the access preview uses `Internet` for the network origin. If the
    /// access preview is for an existing resource and neither is specified, the
    /// access preview uses the existing network origin.
    network_origin: ?NetworkOriginConfiguration,

    /// The proposed `S3PublicAccessBlock` configuration to apply to this Amazon S3
    /// access point or multi-region access point.
    public_access_block: ?S3PublicAccessBlockConfiguration,

    pub const json_field_names = .{
        .access_point_policy = "accessPointPolicy",
        .network_origin = "networkOrigin",
        .public_access_block = "publicAccessBlock",
    };
};
