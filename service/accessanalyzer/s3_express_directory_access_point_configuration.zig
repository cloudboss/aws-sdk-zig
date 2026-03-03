const NetworkOriginConfiguration = @import("network_origin_configuration.zig").NetworkOriginConfiguration;

/// Proposed configuration for an access point attached to an Amazon S3
/// directory bucket. You can propose up to 10 access points per bucket. If the
/// proposed access point configuration is for an existing Amazon S3 directory
/// bucket, the access preview uses the proposed access point configuration in
/// place of the existing access points. To propose an access point without a
/// policy, you can provide an empty string as the access point policy. For more
/// information about access points for Amazon S3 directory buckets, see
/// [Managing access to directory buckets with access
/// points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-points-directory-buckets.html) in the Amazon Simple Storage Service User Guide.
pub const S3ExpressDirectoryAccessPointConfiguration = struct {
    /// The proposed access point policy for an Amazon S3 directory bucket access
    /// point.
    access_point_policy: ?[]const u8 = null,

    network_origin: ?NetworkOriginConfiguration = null,

    pub const json_field_names = .{
        .access_point_policy = "accessPointPolicy",
        .network_origin = "networkOrigin",
    };
};
