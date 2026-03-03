const ActiveTrustedSigners = @import("active_trusted_signers.zig").ActiveTrustedSigners;
const StreamingDistributionConfig = @import("streaming_distribution_config.zig").StreamingDistributionConfig;

/// A streaming distribution tells CloudFront where you want RTMP content to be
/// delivered from, and the details about how to track and manage content
/// delivery.
pub const StreamingDistribution = struct {
    /// A complex type that lists the Amazon Web Services accounts, if any, that you
    /// included in the `TrustedSigners` complex type for this distribution. These
    /// are the accounts that you want to allow to create signed URLs for private
    /// content.
    ///
    /// The `Signer` complex type lists the Amazon Web Services account number of
    /// the trusted signer or `self` if the signer is the Amazon Web Services
    /// account that created the distribution. The `Signer` element also includes
    /// the IDs of any active CloudFront key pairs that are associated with the
    /// trusted signer's Amazon Web Services account. If no `KeyPairId` element
    /// appears for a `Signer`, that signer can't create signed URLs.
    ///
    /// For more information, see [Serving Private Content through
    /// CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PrivateContent.html) in the *Amazon CloudFront Developer Guide*.
    active_trusted_signers: ActiveTrustedSigners,

    /// The ARN (Amazon Resource Name) for the distribution. For example:
    /// `arn:aws:cloudfront::123456789012:distribution/EDFDVBD632BHDS5`, where
    /// `123456789012` is your Amazon Web Services account ID.
    arn: []const u8,

    /// The domain name that corresponds to the streaming distribution, for example,
    /// `s5c39gqb8ow64r.cloudfront.net`.
    domain_name: []const u8,

    /// The identifier for the RTMP distribution. For example: `EGTXBD79EXAMPLE`.
    id: []const u8,

    /// The date and time that the distribution was last modified.
    last_modified_time: ?i64 = null,

    /// The current status of the RTMP distribution. When the status is `Deployed`,
    /// the distribution's information is propagated to all CloudFront edge
    /// locations.
    status: []const u8,

    /// The current configuration information for the RTMP distribution.
    streaming_distribution_config: StreamingDistributionConfig,
};
