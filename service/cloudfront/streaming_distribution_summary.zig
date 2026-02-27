const Aliases = @import("aliases.zig").Aliases;
const PriceClass = @import("price_class.zig").PriceClass;
const S3Origin = @import("s3_origin.zig").S3Origin;
const TrustedSigners = @import("trusted_signers.zig").TrustedSigners;

/// A summary of the information for a CloudFront streaming distribution.
pub const StreamingDistributionSummary = struct {
    /// A complex type that contains information about CNAMEs (alternate domain
    /// names), if any, for this streaming distribution.
    aliases: Aliases,

    /// The ARN (Amazon Resource Name) for the streaming distribution. For example:
    /// `arn:aws:cloudfront::123456789012:streaming-distribution/EDFDVBD632BHDS5`,
    /// where `123456789012` is your Amazon Web Services account ID.
    arn: []const u8,

    /// The comment originally specified when this distribution was created.
    comment: []const u8,

    /// The domain name corresponding to the distribution, for example,
    /// `d111111abcdef8.cloudfront.net`.
    domain_name: []const u8,

    /// Whether the distribution is enabled to accept end user requests for content.
    enabled: bool,

    /// The identifier for the distribution, for example, `EDFDVBD632BHDS5`.
    id: []const u8,

    /// The date and time the distribution was last modified.
    last_modified_time: i64,

    /// A complex type that contains information about price class for this
    /// streaming distribution.
    price_class: PriceClass,

    /// A complex type that contains information about the Amazon S3 bucket from
    /// which you want CloudFront to get your media files for distribution.
    s3_origin: S3Origin,

    /// Indicates the current status of the distribution. When the status is
    /// `Deployed`, the distribution's information is fully propagated throughout
    /// the Amazon CloudFront system.
    status: []const u8,

    /// A complex type that specifies the Amazon Web Services accounts, if any, that
    /// you want to allow to create signed URLs for private content. If you want to
    /// require signed URLs in requests for objects in the target origin that match
    /// the `PathPattern` for this cache behavior, specify `true` for `Enabled`, and
    /// specify the applicable values for `Quantity` and `Items`.If you don't want
    /// to require signed URLs in requests for objects that match `PathPattern`,
    /// specify `false` for `Enabled` and `0` for `Quantity`. Omit `Items`. To add,
    /// change, or remove one or more trusted signers, change `Enabled` to `true`
    /// (if it's currently `false`), change `Quantity` as applicable, and specify
    /// all of the trusted signers that you want to include in the updated
    /// distribution.
    ///
    /// For more information, see [Serving Private Content through
    /// CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PrivateContent.html) in the *Amazon CloudFront Developer Guide*.
    trusted_signers: TrustedSigners,
};
