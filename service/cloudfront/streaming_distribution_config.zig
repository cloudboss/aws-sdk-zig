const Aliases = @import("aliases.zig").Aliases;
const StreamingLoggingConfig = @import("streaming_logging_config.zig").StreamingLoggingConfig;
const PriceClass = @import("price_class.zig").PriceClass;
const S3Origin = @import("s3_origin.zig").S3Origin;
const TrustedSigners = @import("trusted_signers.zig").TrustedSigners;

/// The RTMP distribution's configuration information.
pub const StreamingDistributionConfig = struct {
    /// A complex type that contains information about CNAMEs (alternate domain
    /// names), if any, for this streaming distribution.
    aliases: ?Aliases = null,

    /// A unique value (for example, a date-time stamp) that ensures that the
    /// request can't be replayed.
    ///
    /// If the value of `CallerReference` is new (regardless of the content of the
    /// `StreamingDistributionConfig` object), CloudFront creates a new
    /// distribution.
    ///
    /// If `CallerReference` is a value that you already sent in a previous request
    /// to create a distribution, CloudFront returns a `DistributionAlreadyExists`
    /// error.
    caller_reference: []const u8,

    /// Any comments you want to include about the streaming distribution.
    comment: []const u8,

    /// Whether the streaming distribution is enabled to accept user requests for
    /// content.
    enabled: bool,

    /// A complex type that controls whether access logs are written for the
    /// streaming distribution.
    logging: ?StreamingLoggingConfig = null,

    /// A complex type that contains information about price class for this
    /// streaming distribution.
    price_class: ?PriceClass = null,

    /// A complex type that contains information about the Amazon S3 bucket from
    /// which you want CloudFront to get your media files for distribution.
    s3_origin: S3Origin,

    /// A complex type that specifies any Amazon Web Services accounts that you want
    /// to permit to create signed URLs for private content. If you want the
    /// distribution to use signed URLs, include this element; if you want the
    /// distribution to use public URLs, remove this element. For more information,
    /// see [Serving Private Content through
    /// CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PrivateContent.html) in the *Amazon CloudFront Developer Guide*.
    trusted_signers: TrustedSigners,
};
