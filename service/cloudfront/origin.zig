const CustomHeaders = @import("custom_headers.zig").CustomHeaders;
const CustomOriginConfig = @import("custom_origin_config.zig").CustomOriginConfig;
const OriginShield = @import("origin_shield.zig").OriginShield;
const S3OriginConfig = @import("s3_origin_config.zig").S3OriginConfig;
const VpcOriginConfig = @import("vpc_origin_config.zig").VpcOriginConfig;

/// An origin.
///
/// An origin is the location where content is stored, and from which CloudFront
/// gets content to serve to viewers. To specify an origin:
///
/// * Use `S3OriginConfig` to specify an Amazon S3 bucket that is not configured
///   with static website hosting.
/// * Use `VpcOriginConfig` to specify a VPC origin.
/// * Use `CustomOriginConfig` to specify all other kinds of origins, including:
///
/// * An Amazon S3 bucket that is configured with static website hosting
/// * An Elastic Load Balancing load balancer
/// * An Elemental MediaPackage endpoint
/// * An Elemental MediaStore container
/// * Any other HTTP server, running on an Amazon EC2 instance or any other kind
///   of host
///
/// For the current maximum number of origins that you can specify per
/// distribution, see [General Quotas on Web
/// Distributions](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/cloudfront-limits.html#limits-web-distributions) in the *Amazon CloudFront Developer Guide* (quotas were formerly referred to as limits).
pub const Origin = struct {
    /// The number of times that CloudFront attempts to connect to the origin. The
    /// minimum number is 1, the maximum is 3, and the default (if you don't specify
    /// otherwise) is 3.
    ///
    /// For a custom origin (including an Amazon S3 bucket that's configured with
    /// static website hosting), this value also specifies the number of times that
    /// CloudFront attempts to get a response from the origin, in the case of an
    /// [Origin Response
    /// Timeout](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#DownloadDistValuesOriginResponseTimeout).
    ///
    /// For more information, see [Origin Connection
    /// Attempts](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#origin-connection-attempts) in the *Amazon CloudFront Developer Guide*.
    connection_attempts: ?i32 = null,

    /// The number of seconds that CloudFront waits when trying to establish a
    /// connection to the origin. The minimum timeout is 1 second, the maximum is 10
    /// seconds, and the default (if you don't specify otherwise) is 10 seconds.
    ///
    /// For more information, see [Origin Connection
    /// Timeout](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#origin-connection-timeout) in the *Amazon CloudFront Developer Guide*.
    connection_timeout: ?i32 = null,

    /// A list of HTTP header names and values that CloudFront adds to the requests
    /// that it sends to the origin.
    ///
    /// For more information, see [Adding Custom Headers to Origin
    /// Requests](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/add-origin-custom-headers.html) in the *Amazon CloudFront Developer Guide*.
    custom_headers: ?CustomHeaders = null,

    /// Use this type to specify an origin that is not an Amazon S3 bucket, with one
    /// exception. If the Amazon S3 bucket is configured with static website
    /// hosting, use this type. If the Amazon S3 bucket is not configured with
    /// static website hosting, use the `S3OriginConfig` type instead.
    custom_origin_config: ?CustomOriginConfig = null,

    /// The domain name for the origin.
    ///
    /// For more information, see [Origin Domain
    /// Name](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#DownloadDistValuesDomainName) in the *Amazon CloudFront Developer Guide*.
    domain_name: []const u8,

    /// A unique identifier for the origin. This value must be unique within the
    /// distribution.
    ///
    /// Use this value to specify the `TargetOriginId` in a `CacheBehavior` or
    /// `DefaultCacheBehavior`.
    id: []const u8,

    /// The unique identifier of an origin access control for this origin.
    ///
    /// For more information, see [Restricting access to an Amazon S3
    /// origin](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html) in the *Amazon CloudFront Developer Guide*.
    origin_access_control_id: ?[]const u8 = null,

    /// An optional path that CloudFront appends to the origin domain name when
    /// CloudFront requests content from the origin.
    ///
    /// For more information, see [Origin
    /// Path](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#DownloadDistValuesOriginPath) in the *Amazon CloudFront Developer Guide*.
    origin_path: ?[]const u8 = null,

    /// CloudFront Origin Shield. Using Origin Shield can help reduce the load on
    /// your origin.
    ///
    /// For more information, see [Using Origin
    /// Shield](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/origin-shield.html) in the *Amazon CloudFront Developer Guide*.
    origin_shield: ?OriginShield = null,

    /// The time (in seconds) that a request from CloudFront to the origin can stay
    /// open and wait for a response. If the complete response isn't received from
    /// the origin by this time, CloudFront ends the connection.
    ///
    /// The value for `ResponseCompletionTimeout` must be equal to or greater than
    /// the value for `OriginReadTimeout`. If you don't set a value for
    /// `ResponseCompletionTimeout`, CloudFront doesn't enforce a maximum value.
    ///
    /// For more information, see [Response completion
    /// timeout](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/DownloadDistValuesOrigin.html#response-completion-timeout) in the *Amazon CloudFront Developer Guide*.
    response_completion_timeout: ?i32 = null,

    /// Use this type to specify an origin that is an Amazon S3 bucket that is not
    /// configured with static website hosting. To specify any other type of origin,
    /// including an Amazon S3 bucket that is configured with static website
    /// hosting, use the `CustomOriginConfig` type instead.
    s3_origin_config: ?S3OriginConfig = null,

    /// The VPC origin configuration.
    vpc_origin_config: ?VpcOriginConfig = null,
};
