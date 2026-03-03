/// Information about an Elastic Load Balancing resource limit for your Amazon
/// Web Services
/// account.
///
/// For more information, see the following:
///
/// * [Quotas for your
/// Application Load
/// Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-limits.html)
///
/// * [Quotas for your
/// Network Load
/// Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/load-balancer-limits.html)
///
/// * [Quotas for your Gateway
/// Load
/// Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/gateway/quotas-limits.html)
pub const Limit = struct {
    /// The maximum value of the limit.
    max: ?[]const u8 = null,

    /// The name of the limit.
    name: ?[]const u8 = null,
};
