const AvailabilityZoneDistribution = @import("availability_zone_distribution.zig").AvailabilityZoneDistribution;
const AvailabilityZoneImpairmentPolicy = @import("availability_zone_impairment_policy.zig").AvailabilityZoneImpairmentPolicy;
const CapacityReservationSpecification = @import("capacity_reservation_specification.zig").CapacityReservationSpecification;
const DeletionProtection = @import("deletion_protection.zig").DeletionProtection;
const EnabledMetric = @import("enabled_metric.zig").EnabledMetric;
const InstanceLifecyclePolicy = @import("instance_lifecycle_policy.zig").InstanceLifecyclePolicy;
const InstanceMaintenancePolicy = @import("instance_maintenance_policy.zig").InstanceMaintenancePolicy;
const Instance = @import("instance.zig").Instance;
const LaunchTemplateSpecification = @import("launch_template_specification.zig").LaunchTemplateSpecification;
const MixedInstancesPolicy = @import("mixed_instances_policy.zig").MixedInstancesPolicy;
const SuspendedProcess = @import("suspended_process.zig").SuspendedProcess;
const TagDescription = @import("tag_description.zig").TagDescription;
const TrafficSourceIdentifier = @import("traffic_source_identifier.zig").TrafficSourceIdentifier;
const WarmPoolConfiguration = @import("warm_pool_configuration.zig").WarmPoolConfiguration;

/// Describes an Auto Scaling group.
pub const AutoScalingGroup = struct {
    /// The Amazon Resource Name (ARN) of the Auto Scaling group.
    auto_scaling_group_arn: ?[]const u8 = null,

    /// The name of the Auto Scaling group.
    auto_scaling_group_name: []const u8,

    /// The EC2 instance capacity distribution across Availability Zones for the
    /// Auto Scaling group.
    availability_zone_distribution: ?AvailabilityZoneDistribution = null,

    /// The Availability Zone impairment policy for the Auto Scaling group.
    availability_zone_impairment_policy: ?AvailabilityZoneImpairmentPolicy = null,

    /// One or more Availability Zones for the Auto Scaling group.
    availability_zones: []const []const u8,

    /// Indicates whether Capacity Rebalancing is enabled.
    capacity_rebalance: ?bool = null,

    /// The capacity reservation specification for the Auto Scaling group.
    capacity_reservation_specification: ?CapacityReservationSpecification = null,

    /// Reserved.
    context: ?[]const u8 = null,

    /// The date and time the Auto Scaling group was created.
    created_time: i64,

    /// The duration of the default cooldown period, in seconds, for the Auto
    /// Scaling group.
    default_cooldown: i32,

    /// The duration of the default EC2 instance warmup time, in seconds, for the
    /// Auto Scaling group.
    default_instance_warmup: ?i32 = null,

    /// The deletion protection setting for the Auto Scaling group.
    deletion_protection: ?DeletionProtection = null,

    /// The desired size of the Auto Scaling group.
    desired_capacity: i32,

    /// The unit of measurement for the value specified for desired capacity. Amazon
    /// EC2 Auto Scaling
    /// supports `DesiredCapacityType` for attribute-based instance type selection
    /// only.
    desired_capacity_type: ?[]const u8 = null,

    /// The metrics enabled for the Auto Scaling group.
    enabled_metrics: ?[]const EnabledMetric = null,

    /// The duration of the health check grace period, in seconds, for the Auto
    /// Scaling group.
    health_check_grace_period: ?i32 = null,

    /// One or more comma-separated health check types for the Auto Scaling group.
    health_check_type: []const u8,

    /// The instance lifecycle policy for the Auto Scaling group.
    instance_lifecycle_policy: ?InstanceLifecyclePolicy = null,

    /// An instance maintenance policy.
    instance_maintenance_policy: ?InstanceMaintenancePolicy = null,

    /// The EC2 instances associated with the Auto Scaling group.
    instances: ?[]const Instance = null,

    /// The name of the associated launch configuration for the Auto Scaling group.
    launch_configuration_name: ?[]const u8 = null,

    /// The launch template for the Auto Scaling group.
    launch_template: ?LaunchTemplateSpecification = null,

    /// One or more load balancers associated with the group.
    load_balancer_names: ?[]const []const u8 = null,

    /// The maximum amount of time, in seconds, that an EC2 instance can be in
    /// service for the Auto Scaling group.
    max_instance_lifetime: ?i32 = null,

    /// The maximum size of the Auto Scaling group.
    max_size: i32,

    /// The minimum size of the Auto Scaling group.
    min_size: i32,

    /// The mixed instances policy for the group.
    mixed_instances_policy: ?MixedInstancesPolicy = null,

    /// Indicates whether newly launched EC2 instances are protected from
    /// termination when scaling in for the Auto Scaling group.
    ///
    /// For more information about preventing instances from terminating on scale
    /// in, see
    /// [Use instance scale-in
    /// protection](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-instance-protection.html)
    /// in the *Amazon EC2 Auto Scaling User Guide*.
    new_instances_protected_from_scale_in: ?bool = null,

    /// The name of the placement group into which to launch EC2 instances for the
    /// Auto Scaling group.
    placement_group: ?[]const u8 = null,

    /// The predicted capacity of the group when it has a predictive scaling policy.
    predicted_capacity: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the service-linked role that the Auto
    /// Scaling group uses to call other Amazon Web Services on your behalf.
    service_linked_role_arn: ?[]const u8 = null,

    /// The current state of the Auto Scaling group when the
    /// [DeleteAutoScalingGroup](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DeleteAutoScalingGroup.html)
    /// operation is in progress.
    status: ?[]const u8 = null,

    /// The suspended processes associated with the Auto Scaling group.
    suspended_processes: ?[]const SuspendedProcess = null,

    /// The tags for the Auto Scaling group.
    tags: ?[]const TagDescription = null,

    /// The Amazon Resource Names (ARN) of the target groups for your load balancer.
    target_group_ar_ns: ?[]const []const u8 = null,

    /// The termination policies for the Auto Scaling group.
    termination_policies: ?[]const []const u8 = null,

    /// The traffic sources associated with this Auto Scaling group.
    traffic_sources: ?[]const TrafficSourceIdentifier = null,

    /// One or more comma-separated subnet IDs for the Auto Scaling group.
    vpc_zone_identifier: ?[]const u8 = null,

    /// The warm pool for the group.
    warm_pool_configuration: ?WarmPoolConfiguration = null,

    /// The current size of the warm pool.
    warm_pool_size: ?i32 = null,
};
