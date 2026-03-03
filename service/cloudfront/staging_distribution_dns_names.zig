/// The CloudFront domain name of the staging distribution.
pub const StagingDistributionDnsNames = struct {
    /// The CloudFront domain name of the staging distribution.
    items: ?[]const []const u8 = null,

    /// The number of CloudFront domain names in your staging distribution.
    quantity: i32,
};
