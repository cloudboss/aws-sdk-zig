const ComputeQuotaResourceConfig = @import("compute_quota_resource_config.zig").ComputeQuotaResourceConfig;
const ResourceSharingStrategy = @import("resource_sharing_strategy.zig").ResourceSharingStrategy;

/// Resource sharing configuration.
pub const ResourceSharingConfig = struct {
    /// The absolute limits on compute resources that can be borrowed from idle
    /// compute. When specified, these limits define the maximum amount of specific
    /// resource types (such as accelerators, vCPU, or memory) that an entity can
    /// borrow, regardless of the percentage-based `BorrowLimit`.
    absolute_borrow_limits: ?[]const ComputeQuotaResourceConfig,

    /// The limit on how much idle compute can be borrowed.The values can be 1 - 500
    /// percent of idle compute that the team is allowed to borrow.
    ///
    /// Default is `50`.
    borrow_limit: ?i32,

    /// The strategy of how idle compute is shared within the cluster. The following
    /// are the options of strategies.
    ///
    /// * `DontLend`: entities do not lend idle compute.
    /// * `Lend`: entities can lend idle compute to entities that can borrow.
    /// * `LendandBorrow`: entities can lend idle compute and borrow idle compute
    ///   from other entities.
    ///
    /// Default is `LendandBorrow`.
    strategy: ResourceSharingStrategy,

    pub const json_field_names = .{
        .absolute_borrow_limits = "AbsoluteBorrowLimits",
        .borrow_limit = "BorrowLimit",
        .strategy = "Strategy",
    };
};
