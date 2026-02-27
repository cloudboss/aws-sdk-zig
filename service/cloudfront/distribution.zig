const ActiveTrustedKeyGroups = @import("active_trusted_key_groups.zig").ActiveTrustedKeyGroups;
const ActiveTrustedSigners = @import("active_trusted_signers.zig").ActiveTrustedSigners;
const AliasICPRecordal = @import("alias_icp_recordal.zig").AliasICPRecordal;
const DistributionConfig = @import("distribution_config.zig").DistributionConfig;

/// A distribution tells CloudFront where you want content to be delivered from,
/// and the details about how to track and manage content delivery.
pub const Distribution = struct {
    /// This field contains a list of key groups and the public keys in each key
    /// group that CloudFront can use to verify the signatures of signed URLs or
    /// signed cookies.
    active_trusted_key_groups: ?ActiveTrustedKeyGroups,

    /// We recommend using `TrustedKeyGroups` instead of `TrustedSigners`.
    ///
    /// This field contains a list of Amazon Web Services account IDs and the active
    /// CloudFront key pairs in each account that CloudFront can use to verify the
    /// signatures of signed URLs or signed cookies.
    active_trusted_signers: ?ActiveTrustedSigners,

    /// Amazon Web Services services in China customers must file for an Internet
    /// Content Provider (ICP) recordal if they want to serve content publicly on an
    /// alternate domain name, also known as a CNAME, that they've added to
    /// CloudFront. AliasICPRecordal provides the ICP recordal status for CNAMEs
    /// associated with distributions.
    ///
    /// For more information about ICP recordals, see [ Signup, Accounts, and
    /// Credentials](https://docs.amazonaws.cn/en_us/aws/latest/userguide/accounts-and-credentials.html) in *Getting Started with Amazon Web Services services in China*.
    alias_icp_recordals: ?[]const AliasICPRecordal,

    /// The distribution's Amazon Resource Name (ARN).
    arn: []const u8,

    /// The distribution's configuration.
    distribution_config: DistributionConfig,

    /// The distribution's CloudFront domain name. For example:
    /// `d111111abcdef8.cloudfront.net`.
    domain_name: []const u8,

    /// The distribution's identifier. For example: `E1U5RQF7T870K0`.
    id: []const u8,

    /// The number of invalidation batches currently in progress.
    in_progress_invalidation_batches: i32,

    /// The date and time when the distribution was last modified.
    last_modified_time: i64,

    /// The distribution's status. When the status is `Deployed`, the distribution's
    /// information is fully propagated to all CloudFront edge locations.
    status: []const u8,
};
