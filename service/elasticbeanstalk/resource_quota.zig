/// The AWS Elastic Beanstalk quota information for a single resource type in an
/// AWS account. It
/// reflects the resource's limits for this account.
pub const ResourceQuota = struct {
    /// The maximum number of instances of this Elastic Beanstalk resource type that
    /// an AWS account can
    /// use.
    maximum: ?i32,
};
