const FleetActivityStatus = @import("fleet_activity_status.zig").FleetActivityStatus;
const DescribeFleetError = @import("describe_fleet_error.zig").DescribeFleetError;
const FleetExcessCapacityTerminationPolicy = @import("fleet_excess_capacity_termination_policy.zig").FleetExcessCapacityTerminationPolicy;
const FleetStateCode = @import("fleet_state_code.zig").FleetStateCode;
const DescribeFleetsInstances = @import("describe_fleets_instances.zig").DescribeFleetsInstances;
const FleetLaunchTemplateConfig = @import("fleet_launch_template_config.zig").FleetLaunchTemplateConfig;
const OnDemandOptions = @import("on_demand_options.zig").OnDemandOptions;
const SpotOptions = @import("spot_options.zig").SpotOptions;
const Tag = @import("tag.zig").Tag;
const TargetCapacitySpecification = @import("target_capacity_specification.zig").TargetCapacitySpecification;
const FleetType = @import("fleet_type.zig").FleetType;

/// Describes an EC2 Fleet.
pub const FleetData = struct {
    /// The progress of the EC2 Fleet.
    ///
    /// For fleets of type `instant`, the status is `fulfilled` after all
    /// requests are placed, regardless of whether target capacity is met (this is
    /// the only
    /// possible status for `instant` fleets).
    ///
    /// For fleets of type `request` or `maintain`, the status is
    /// `pending_fulfillment` after all requests are placed, `fulfilled`
    /// when the fleet size meets or exceeds target capacity, `pending_termination`
    /// while instances are terminating when fleet size is decreased, and `error` if
    /// there's an error.
    activity_status: ?FleetActivityStatus,

    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the
    /// request. For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    ///
    /// Constraints: Maximum 64 ASCII characters
    client_token: ?[]const u8,

    /// Reserved.
    context: ?[]const u8,

    /// The creation date and time of the EC2 Fleet.
    create_time: ?i64,

    /// Information about the instances that could not be launched by the fleet.
    /// Valid only when
    /// **Type** is set to `instant`.
    errors: ?[]const DescribeFleetError,

    /// Indicates whether running instances should be terminated if the target
    /// capacity of the
    /// EC2 Fleet is decreased below the current size of the EC2 Fleet.
    ///
    /// Supported only for fleets of type `maintain`.
    excess_capacity_termination_policy: ?FleetExcessCapacityTerminationPolicy,

    /// The ID of the EC2 Fleet.
    fleet_id: ?[]const u8,

    /// The state of the EC2 Fleet.
    fleet_state: ?FleetStateCode,

    /// The number of units fulfilled by this request compared to the set target
    /// capacity.
    fulfilled_capacity: ?f64,

    /// The number of units fulfilled by this request compared to the set target
    /// On-Demand
    /// capacity.
    fulfilled_on_demand_capacity: ?f64,

    /// Information about the instances that were launched by the fleet. Valid only
    /// when
    /// **Type** is set to `instant`.
    instances: ?[]const DescribeFleetsInstances,

    /// The launch template and overrides.
    launch_template_configs: ?[]const FleetLaunchTemplateConfig,

    /// The allocation strategy of On-Demand Instances in an EC2 Fleet.
    on_demand_options: ?OnDemandOptions,

    /// Indicates whether EC2 Fleet should replace unhealthy Spot Instances.
    /// Supported only for
    /// fleets of type `maintain`. For more information, see [EC2 Fleet
    /// health
    /// checks](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/manage-ec2-fleet.html#ec2-fleet-health-checks) in the *Amazon EC2 User Guide*.
    replace_unhealthy_instances: ?bool,

    /// The configuration of Spot Instances in an EC2 Fleet.
    spot_options: ?SpotOptions,

    /// The tags for an EC2 Fleet resource.
    tags: ?[]const Tag,

    /// The number of units to request. You can choose to set the target capacity in
    /// terms of
    /// instances or a performance characteristic that is important to your
    /// application workload,
    /// such as vCPUs, memory, or I/O. If the request type is `maintain`, you can
    /// specify a target capacity of 0 and add capacity later.
    target_capacity_specification: ?TargetCapacitySpecification,

    /// Indicates whether running instances should be terminated when the EC2 Fleet
    /// expires.
    terminate_instances_with_expiration: ?bool,

    /// The type of request. Indicates whether the EC2 Fleet only `requests` the
    /// target
    /// capacity, or also attempts to `maintain` it. If you request a certain target
    /// capacity, EC2 Fleet only places the required requests; it does not attempt
    /// to replenish
    /// instances if capacity is diminished, and it does not submit requests in
    /// alternative
    /// capacity pools if capacity is unavailable. To maintain a certain target
    /// capacity, EC2 Fleet
    /// places the required requests to meet this target capacity. It also
    /// automatically
    /// replenishes any interrupted Spot Instances. Default: `maintain`.
    type: ?FleetType,

    /// The start date and time of the request, in UTC format (for example,
    /// *YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z).
    /// The default is to start fulfilling the request immediately.
    valid_from: ?i64,

    /// The end date and time of the request, in UTC format (for example,
    /// *YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z).
    /// At this point, no new instance requests are placed or able to fulfill the
    /// request. The
    /// default end date is 7 days from the current date.
    valid_until: ?i64,
};
