const SpotProvisioningAllocationStrategy = @import("spot_provisioning_allocation_strategy.zig").SpotProvisioningAllocationStrategy;
const SpotProvisioningTimeoutAction = @import("spot_provisioning_timeout_action.zig").SpotProvisioningTimeoutAction;

/// The launch specification for Spot Instances in the instance fleet, which
/// determines the
/// defined duration, provisioning timeout behavior, and allocation strategy.
///
/// The instance fleet configuration is available only in Amazon EMR releases
/// 4.8.0 and later, excluding 5.0.x versions. Spot Instance allocation strategy
/// is
/// available in Amazon EMR releases 5.12.1 and later.
///
/// Spot Instances with a defined duration (also known as Spot blocks) are no
/// longer
/// available to new customers from July 1, 2021. For customers who have
/// previously used the
/// feature, we will continue to support Spot Instances with a defined duration
/// until
/// December 31, 2022.
pub const SpotProvisioningSpecification = struct {
    /// Specifies one of the following strategies to launch Spot Instance fleets:
    /// `capacity-optimized`, `price-capacity-optimized`, `lowest-price`, or
    /// `diversified`, and `capacity-optimized-prioritized`. For more information on
    /// the provisioning strategies, see [Allocation strategies for Spot
    /// Instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-fleet-allocation-strategy.html) in the *Amazon EC2 User Guide for Linux Instances*.
    ///
    /// When you launch a Spot Instance fleet with the old console, it automatically
    /// launches with the `capacity-optimized` strategy. You can't change the
    /// allocation strategy from the old console.
    allocation_strategy: ?SpotProvisioningAllocationStrategy = null,

    /// The defined duration for Spot Instances (also known as Spot blocks) in
    /// minutes. When
    /// specified, the Spot Instance does not terminate before the defined duration
    /// expires, and
    /// defined duration pricing for Spot Instances applies. Valid values are 60,
    /// 120, 180, 240,
    /// 300, or 360. The duration period starts as soon as a Spot Instance receives
    /// its instance
    /// ID. At the end of the duration, Amazon EC2 marks the Spot Instance for
    /// termination
    /// and provides a Spot Instance termination notice, which gives the instance a
    /// two-minute
    /// warning before it terminates.
    ///
    /// Spot Instances with a defined duration (also known as Spot blocks) are no
    /// longer
    /// available to new customers from July 1, 2021. For customers who have
    /// previously used the
    /// feature, we will continue to support Spot Instances with a defined duration
    /// until
    /// December 31, 2022.
    block_duration_minutes: ?i32 = null,

    /// The action to take when `TargetSpotCapacity` has not been fulfilled when the
    /// `TimeoutDurationMinutes` has expired; that is, when all Spot Instances could
    /// not be provisioned within the Spot provisioning timeout. Valid values are
    /// `TERMINATE_CLUSTER` and `SWITCH_TO_ON_DEMAND`. SWITCH_TO_ON_DEMAND
    /// specifies that if no Spot Instances are available, On-Demand Instances
    /// should be
    /// provisioned to fulfill any remaining Spot capacity.
    timeout_action: SpotProvisioningTimeoutAction,

    /// The Spot provisioning timeout period in minutes. If Spot Instances are not
    /// provisioned
    /// within this time period, the `TimeOutAction` is taken. Minimum value is 5
    /// and
    /// maximum value is 1440. The timeout applies only during initial provisioning,
    /// when the
    /// cluster is first created.
    timeout_duration_minutes: i32,

    pub const json_field_names = .{
        .allocation_strategy = "AllocationStrategy",
        .block_duration_minutes = "BlockDurationMinutes",
        .timeout_action = "TimeoutAction",
        .timeout_duration_minutes = "TimeoutDurationMinutes",
    };
};
