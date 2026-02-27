/// A structure that pairs a CloudFront distribution ID with its owning Amazon
/// Web Services account ID.
pub const DistributionIdOwner = struct {
    /// The ID of the distribution.
    distribution_id: []const u8,

    /// The ID of the Amazon Web Services account that owns the distribution.
    owner_account_id: []const u8,
};
