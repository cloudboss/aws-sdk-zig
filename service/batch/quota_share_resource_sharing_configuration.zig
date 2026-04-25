const QuotaShareResourceSharingStrategy = @import("quota_share_resource_sharing_strategy.zig").QuotaShareResourceSharingStrategy;

/// Specifies whether a quota share reserves, lends, or both lends and borrows
/// idle compute capacity.
pub const QuotaShareResourceSharingConfiguration = struct {
    /// The maximum percentage of additional capacity that the quota share can
    /// borrow from other shares. `borrowLimit` can only be applied to quota shares
    /// with a strategy of `LEND_AND_BORROW`.
    /// This value is expressed as a percentage of the quota share's configured
    /// [CapacityLimits](https://docs.aws.amazon.com/batch/latest/APIReference/API_QuotaShareCapacityLimit.html).
    ///
    /// The `borrowLimit` is applied uniformly across all capacity units.
    /// For example, if the `borrowLimit` is 200, the quota
    /// share can borrow up to 200% of its configured `maxCapacity` for each
    /// capacity unit. The default `borrowLimit` is -1, which indicates unlimited
    /// borrowing.
    borrow_limit: ?i32 = null,

    /// The resource sharing strategy for the quota share. The `RESERVE` strategy
    /// allows a quota share to reserve idle capacity for itself.
    /// `LEND` configures the share to lend its idle capacity to another share in
    /// need of capacity.
    /// The `LEND_AND_BORROW` strategy configures the share to borrow idle capacity
    /// from an underutilized share, as well as lend to another share.
    strategy: QuotaShareResourceSharingStrategy,

    pub const json_field_names = .{
        .borrow_limit = "borrowLimit",
        .strategy = "strategy",
    };
};
