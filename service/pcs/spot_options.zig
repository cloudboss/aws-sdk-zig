const SpotAllocationStrategy = @import("spot_allocation_strategy.zig").SpotAllocationStrategy;

/// Additional configuration when you specify `SPOT` as the `purchaseOption` for
/// the `CreateComputeNodeGroup` API action.
pub const SpotOptions = struct {
    /// The Amazon EC2 allocation strategy PCS uses to provision EC2 instances. PCS
    /// supports **lowest price**, **capacity optimized**, and **price capacity
    /// optimized**. For more information, see [Use allocation strategies to
    /// determine how EC2 Fleet or Spot Fleet fulfills Spot and On-Demand
    /// capacity](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-fleet-allocation-strategy.html) in the *Amazon Elastic Compute Cloud User Guide*. If you don't provide this option, it defaults to **price capacity optimized**.
    allocation_strategy: ?SpotAllocationStrategy,

    pub const json_field_names = .{
        .allocation_strategy = "allocationStrategy",
    };
};
