const AllocationStrategy = @import("allocation_strategy.zig").AllocationStrategy;
const ExcessCapacityTerminationPolicy = @import("excess_capacity_termination_policy.zig").ExcessCapacityTerminationPolicy;
const InstanceInterruptionBehavior = @import("instance_interruption_behavior.zig").InstanceInterruptionBehavior;
const SpotFleetLaunchSpecification = @import("spot_fleet_launch_specification.zig").SpotFleetLaunchSpecification;
const LaunchTemplateConfig = @import("launch_template_config.zig").LaunchTemplateConfig;
const LoadBalancersConfig = @import("load_balancers_config.zig").LoadBalancersConfig;
const OnDemandAllocationStrategy = @import("on_demand_allocation_strategy.zig").OnDemandAllocationStrategy;
const SpotMaintenanceStrategies = @import("spot_maintenance_strategies.zig").SpotMaintenanceStrategies;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const TargetCapacityUnitType = @import("target_capacity_unit_type.zig").TargetCapacityUnitType;
const FleetType = @import("fleet_type.zig").FleetType;

/// Describes the configuration of a Spot Fleet request.
pub const SpotFleetRequestConfigData = struct {
    /// The strategy that determines how to allocate the target Spot Instance
    /// capacity across the Spot Instance
    /// pools specified by the Spot Fleet launch configuration. For more
    /// information, see [Allocation
    /// strategies for Spot
    /// Instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-fleet-allocation-strategy.html) in the *Amazon EC2 User Guide*.
    ///
    /// **priceCapacityOptimized (recommended)**
    ///
    /// Spot Fleet identifies the pools with
    /// the highest capacity availability for the number of instances that are
    /// launching. This means
    /// that we will request Spot Instances from the pools that we believe have the
    /// lowest chance of interruption
    /// in the near term. Spot Fleet then requests Spot Instances from the lowest
    /// priced of these pools.
    ///
    /// **capacityOptimized**
    ///
    /// Spot Fleet identifies the pools with
    /// the highest capacity availability for the number of instances that are
    /// launching. This means
    /// that we will request Spot Instances from the pools that we believe have the
    /// lowest chance of interruption
    /// in the near term. To give certain
    /// instance types a higher chance of launching first, use
    /// `capacityOptimizedPrioritized`. Set a priority for each instance type by
    /// using the `Priority` parameter for `LaunchTemplateOverrides`. You can
    /// assign the same priority to different `LaunchTemplateOverrides`. EC2
    /// implements
    /// the priorities on a best-effort basis, but optimizes for capacity first.
    /// `capacityOptimizedPrioritized` is supported only if your Spot Fleet uses a
    /// launch template. Note that if the `OnDemandAllocationStrategy` is set to
    /// `prioritized`, the same priority is applied when fulfilling On-Demand
    /// capacity.
    ///
    /// **diversified**
    ///
    /// Spot Fleet requests instances from all of the Spot Instance pools that you
    /// specify.
    ///
    /// **lowestPrice (not recommended)**
    ///
    /// We don't recommend the `lowestPrice` allocation strategy because
    /// it has the highest risk of interruption for your Spot Instances.
    ///
    /// Spot Fleet requests instances from the lowest priced Spot Instance pool that
    /// has available
    /// capacity. If the lowest priced pool doesn't have available capacity, the
    /// Spot Instances
    /// come from the next lowest priced pool that has available capacity. If a pool
    /// runs
    /// out of capacity before fulfilling your desired capacity, Spot Fleet will
    /// continue to
    /// fulfill your request by drawing from the next lowest priced pool. To ensure
    /// that
    /// your desired capacity is met, you might receive Spot Instances from several
    /// pools. Because
    /// this strategy only considers instance price and not capacity availability,
    /// it
    /// might lead to high interruption rates.
    ///
    /// Default: `lowestPrice`
    allocation_strategy: ?AllocationStrategy,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of your
    /// listings. This helps to avoid duplicate listings. For more information, see
    /// [Ensuring
    /// Idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8,

    /// Reserved.
    context: ?[]const u8,

    /// Indicates whether running instances should be terminated if you decrease the
    /// target capacity of the Spot Fleet request below the current size of the Spot
    /// Fleet.
    ///
    /// Supported only for fleets of type `maintain`.
    excess_capacity_termination_policy: ?ExcessCapacityTerminationPolicy,

    /// The number of units fulfilled by this request compared to the set target
    /// capacity. You
    /// cannot set this value.
    fulfilled_capacity: ?f64,

    /// The Amazon Resource Name (ARN) of an Identity and Access Management (IAM)
    /// role
    /// that grants the Spot Fleet the permission to request, launch, terminate, and
    /// tag instances
    /// on your behalf. For more information, see [Spot
    /// Fleet
    /// prerequisites](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-fleet-requests.html#spot-fleet-prerequisites) in the *Amazon EC2 User Guide*. Spot Fleet can
    /// terminate Spot Instances on your behalf when you cancel its Spot Fleet
    /// request using
    /// [CancelSpotFleetRequests](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CancelSpotFleetRequests) or when the Spot Fleet request expires, if you set
    /// `TerminateInstancesWithExpiration`.
    iam_fleet_role: []const u8,

    /// The behavior when a Spot Instance is interrupted. The default is
    /// `terminate`.
    instance_interruption_behavior: ?InstanceInterruptionBehavior,

    /// The number of Spot pools across which to allocate your target Spot capacity.
    /// Valid
    /// only when Spot **AllocationStrategy** is set to
    /// `lowest-price`. Spot Fleet selects the cheapest Spot pools and evenly
    /// allocates your target Spot capacity across the number of Spot pools that you
    /// specify.
    ///
    /// Note that Spot Fleet attempts to draw Spot Instances from the number of
    /// pools that you specify on a
    /// best effort basis. If a pool runs out of Spot capacity before fulfilling
    /// your target
    /// capacity, Spot Fleet will continue to fulfill your request by drawing from
    /// the next cheapest
    /// pool. To ensure that your target capacity is met, you might receive Spot
    /// Instances from more than
    /// the number of pools that you specified. Similarly, if most of the pools have
    /// no Spot
    /// capacity, you might receive your full target capacity from fewer than the
    /// number of
    /// pools that you specified.
    instance_pools_to_use_count: ?i32,

    /// The launch specifications for the Spot Fleet request. If you specify
    /// `LaunchSpecifications`, you can't specify
    /// `LaunchTemplateConfigs`. If you include On-Demand capacity in your
    /// request, you must use `LaunchTemplateConfigs`.
    ///
    /// If an AMI specified in a launch specification is deregistered or disabled,
    /// no new
    /// instances can be launched from the AMI. For fleets of type `maintain`, the
    /// target capacity will not be maintained.
    launch_specifications: ?[]const SpotFleetLaunchSpecification,

    /// The launch template and overrides. If you specify `LaunchTemplateConfigs`,
    /// you can't specify `LaunchSpecifications`. If you include On-Demand capacity
    /// in your request, you must use `LaunchTemplateConfigs`.
    launch_template_configs: ?[]const LaunchTemplateConfig,

    /// One or more Classic Load Balancers and target groups to attach to the Spot
    /// Fleet
    /// request. Spot Fleet registers the running Spot Instances with the specified
    /// Classic Load
    /// Balancers and target groups.
    ///
    /// With Network Load Balancers, Spot Fleet cannot register instances that have
    /// the
    /// following instance types: C1, CC1, CC2, CG1, CG2, CR1, CS1, G1, G2, HI1,
    /// HS1, M1, M2,
    /// M3, and T1.
    load_balancers_config: ?LoadBalancersConfig,

    /// The order of the launch template overrides to use in fulfilling On-Demand
    /// capacity. If
    /// you specify `lowestPrice`, Spot Fleet uses price to determine the order,
    /// launching
    /// the lowest price first. If you specify `prioritized`, Spot Fleet uses the
    /// priority
    /// that you assign to each Spot Fleet launch template override, launching the
    /// highest priority
    /// first. If you do not specify a value, Spot Fleet defaults to `lowestPrice`.
    on_demand_allocation_strategy: ?OnDemandAllocationStrategy,

    /// The number of On-Demand units fulfilled by this request compared to the set
    /// target
    /// On-Demand capacity.
    on_demand_fulfilled_capacity: ?f64,

    /// The maximum amount per hour for On-Demand Instances that you're willing to
    /// pay. You
    /// can use the `onDemandMaxTotalPrice` parameter, the
    /// `spotMaxTotalPrice` parameter, or both parameters to ensure that your
    /// fleet cost does not exceed your budget. If you set a maximum price per hour
    /// for the
    /// On-Demand Instances and Spot Instances in your request, Spot Fleet will
    /// launch instances until it reaches the
    /// maximum amount you're willing to pay. When the maximum amount you're willing
    /// to pay is
    /// reached, the fleet stops launching instances even if it hasn’t met the
    /// target
    /// capacity.
    ///
    /// If your fleet includes T instances that are configured as `unlimited`,
    /// and if their average CPU usage exceeds the baseline utilization, you will
    /// incur a charge
    /// for surplus credits. The `onDemandMaxTotalPrice` does not account for
    /// surplus
    /// credits, and, if you use surplus credits, your final cost might be higher
    /// than what you
    /// specified for `onDemandMaxTotalPrice`. For more information, see [Surplus
    /// credits can incur
    /// charges](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances-unlimited-mode-concepts.html#unlimited-mode-surplus-credits) in the
    /// *Amazon EC2 User Guide*.
    on_demand_max_total_price: ?[]const u8,

    /// The number of On-Demand units to request. You can choose to set the target
    /// capacity in
    /// terms of instances or a performance characteristic that is important to your
    /// application
    /// workload, such as vCPUs, memory, or I/O. If the request type is `maintain`,
    /// you can specify a target capacity of 0 and add capacity later.
    on_demand_target_capacity: ?i32,

    /// Indicates whether Spot Fleet should replace unhealthy instances.
    replace_unhealthy_instances: ?bool,

    /// The strategies for managing your Spot Instances that are at an elevated risk
    /// of being
    /// interrupted.
    spot_maintenance_strategies: ?SpotMaintenanceStrategies,

    /// The maximum amount per hour for Spot Instances that you're willing to pay.
    /// You can use
    /// the `spotMaxTotalPrice` parameter, the `onDemandMaxTotalPrice`
    /// parameter, or both parameters to ensure that your fleet cost does not exceed
    /// your budget.
    /// If you set a maximum price per hour for the On-Demand Instances and Spot
    /// Instances in your request, Spot Fleet will
    /// launch instances until it reaches the maximum amount you're willing to pay.
    /// When the
    /// maximum amount you're willing to pay is reached, the fleet stops launching
    /// instances even
    /// if it hasn’t met the target capacity.
    ///
    /// If your fleet includes T instances that are configured as `unlimited`,
    /// and if their average CPU usage exceeds the baseline utilization, you will
    /// incur a charge
    /// for surplus credits. The `spotMaxTotalPrice` does not account for surplus
    /// credits, and, if you use surplus credits, your final cost might be higher
    /// than what you
    /// specified for `spotMaxTotalPrice`. For more information, see [Surplus
    /// credits can incur
    /// charges](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances-unlimited-mode-concepts.html#unlimited-mode-surplus-credits) in the
    /// *Amazon EC2 User Guide*.
    spot_max_total_price: ?[]const u8,

    /// The maximum price per unit hour that you are willing to pay for a Spot
    /// Instance. We do not recommend
    /// using this parameter because it can lead to increased interruptions. If you
    /// do not specify this parameter, you will pay the current Spot price.
    ///
    /// If you specify a maximum price, your instances will be interrupted more
    /// frequently than if you do not specify this parameter.
    spot_price: ?[]const u8,

    /// The key-value pair for tagging the Spot Fleet request on creation. The value
    /// for
    /// `ResourceType` must be `spot-fleet-request`, otherwise the
    /// Spot Fleet request fails. To tag instances at launch, specify the tags in
    /// the [launch
    /// template](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-templates.html#create-launch-template) (valid only if you use `LaunchTemplateConfigs`) or in
    /// the `
    /// [SpotFleetTagSpecification](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_SpotFleetTagSpecification.html)
    /// ` (valid only if you use
    /// `LaunchSpecifications`). For information about tagging after launch, see
    /// [Tag your
    /// resources](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html#tag-resources).
    tag_specifications: ?[]const TagSpecification,

    /// The number of units to request for the Spot Fleet. You can choose to set the
    /// target
    /// capacity in terms of instances or a performance characteristic that is
    /// important to your
    /// application workload, such as vCPUs, memory, or I/O. If the request type is
    /// `maintain`, you can specify a target capacity of 0 and add capacity
    /// later.
    target_capacity: i32,

    /// The unit for the target capacity. You can specify this parameter only when
    /// using attribute-based instance type selection.
    ///
    /// Default: `units` (the number of instances)
    target_capacity_unit_type: ?TargetCapacityUnitType,

    /// Indicates whether running Spot Instances are terminated when the Spot Fleet
    /// request
    /// expires.
    terminate_instances_with_expiration: ?bool,

    /// The type of request. Indicates whether the Spot Fleet only requests the
    /// target
    /// capacity or also attempts to maintain it. When this value is `request`, the
    /// Spot Fleet only places the required requests. It does not attempt to
    /// replenish Spot
    /// Instances if capacity is diminished, nor does it submit requests in
    /// alternative Spot
    /// pools if capacity is not available. When this value is `maintain`, the Spot
    /// Fleet maintains the target capacity. The Spot Fleet places the required
    /// requests to meet
    /// capacity and automatically replenishes any interrupted instances. Default:
    /// `maintain`. `instant` is listed but is not used by Spot
    /// Fleet.
    type: ?FleetType,

    /// The start date and time of the request, in UTC format
    /// (*YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z).
    /// By default, Amazon EC2 starts fulfilling the request immediately.
    valid_from: ?i64,

    /// The end date and time of the request, in UTC format
    /// (*YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z).
    /// After the end date and time, no new Spot Instance requests are placed or
    /// able to fulfill
    /// the request. If no value is specified, the Spot Fleet request remains until
    /// you cancel
    /// it.
    valid_until: ?i64,
};
