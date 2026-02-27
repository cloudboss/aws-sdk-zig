/// An alias (also called a CNAME) and the CloudFront standard distribution and
/// Amazon Web Services account ID that it's associated with. The standard
/// distribution and account IDs are partially hidden, which allows you to
/// identify the standard distributions and accounts that you own, and helps to
/// protect the information of ones that you don't own.
pub const ConflictingAlias = struct {
    /// The (partially hidden) ID of the Amazon Web Services account that owns the
    /// standard distribution that's associated with the alias.
    account_id: ?[]const u8,

    /// An alias (also called a CNAME).
    alias: ?[]const u8,

    /// The (partially hidden) ID of the CloudFront standard distribution associated
    /// with the alias.
    distribution_id: ?[]const u8,
};
