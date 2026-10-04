/// The Elastic Beanstalk quota information for a single resource type in an
/// Amazon Web Services account. It
/// reflects the resource's limits for this account.
pub const ResourceQuota = struct {
    /// The maximum number of instances of this Elastic Beanstalk resource type that
    /// an Amazon Web Services account can
    /// use.
    maximum: ?i32 = null,
};
