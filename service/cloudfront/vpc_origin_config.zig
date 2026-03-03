/// An Amazon CloudFront VPC origin configuration.
pub const VpcOriginConfig = struct {
    /// Specifies how long, in seconds, CloudFront persists its connection to the
    /// origin. The minimum timeout is 1 second, the maximum is 120 seconds, and the
    /// default (if you don't specify otherwise) is 5 seconds.
    ///
    /// For more information, see [Keep-alive timeout (custom origins
    /// only)](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/DownloadDistValuesOrigin.html#DownloadDistValuesOriginKeepaliveTimeout) in the *Amazon CloudFront Developer Guide*.
    origin_keepalive_timeout: ?i32 = null,

    /// Specifies how long, in seconds, CloudFront waits for a response from the
    /// origin. This is also known as the *origin response timeout*. The minimum
    /// timeout is 1 second, the maximum is 120 seconds, and the default (if you
    /// don't specify otherwise) is 30 seconds.
    ///
    /// For more information, see [Response
    /// timeout](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/DownloadDistValuesOrigin.html#DownloadDistValuesOriginResponseTimeout) in the *Amazon CloudFront Developer Guide*.
    origin_read_timeout: ?i32 = null,

    /// The account ID of the Amazon Web Services account that owns the VPC origin.
    owner_account_id: ?[]const u8 = null,

    /// The VPC origin ID.
    vpc_origin_id: []const u8,
};
