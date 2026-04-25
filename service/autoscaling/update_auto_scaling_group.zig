const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AvailabilityZoneDistribution = @import("availability_zone_distribution.zig").AvailabilityZoneDistribution;
const AvailabilityZoneImpairmentPolicy = @import("availability_zone_impairment_policy.zig").AvailabilityZoneImpairmentPolicy;
const CapacityReservationSpecification = @import("capacity_reservation_specification.zig").CapacityReservationSpecification;
const DeletionProtection = @import("deletion_protection.zig").DeletionProtection;
const InstanceLifecyclePolicy = @import("instance_lifecycle_policy.zig").InstanceLifecyclePolicy;
const InstanceMaintenancePolicy = @import("instance_maintenance_policy.zig").InstanceMaintenancePolicy;
const LaunchTemplateSpecification = @import("launch_template_specification.zig").LaunchTemplateSpecification;
const MixedInstancesPolicy = @import("mixed_instances_policy.zig").MixedInstancesPolicy;
const serde = @import("serde.zig");

pub const UpdateAutoScalingGroupInput = struct {
    /// The name of the Auto Scaling group.
    auto_scaling_group_name: []const u8,

    /// The instance capacity distribution across Availability Zones.
    availability_zone_distribution: ?AvailabilityZoneDistribution = null,

    /// A list of Availability Zone IDs for the Auto Scaling group. You cannot
    /// specify both AvailabilityZones and AvailabilityZoneIds in the same request.
    availability_zone_ids: ?[]const []const u8 = null,

    /// The policy for Availability Zone impairment.
    availability_zone_impairment_policy: ?AvailabilityZoneImpairmentPolicy = null,

    /// One or more Availability Zones for the group.
    availability_zones: ?[]const []const u8 = null,

    /// Enables or disables Capacity Rebalancing. If Capacity Rebalancing is
    /// disabled, proactive replacement of at-risk Spot Instances does not occur.
    /// For more information, see [Capacity
    /// Rebalancing in Auto Scaling to replace at-risk Spot
    /// Instances](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-capacity-rebalancing.html) in the *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// To suspend rebalancing across Availability Zones, use the
    /// [SuspendProcesses](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_SuspendedProcess.html) API.
    capacity_rebalance: ?bool = null,

    /// The capacity reservation specification for the Auto Scaling group.
    capacity_reservation_specification: ?CapacityReservationSpecification = null,

    /// Reserved.
    context: ?[]const u8 = null,

    /// *Only needed if you use simple scaling policies.*
    ///
    /// The amount of time, in seconds, between one scaling activity ending and
    /// another one
    /// starting due to simple scaling policies. For more information, see [Scaling
    /// cooldowns for Amazon EC2 Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-scaling-cooldowns.html) in the *Amazon EC2 Auto Scaling User Guide*.
    default_cooldown: ?i32 = null,

    /// The amount of time, in seconds, until a new instance is considered to have
    /// finished
    /// initializing and resource consumption to become stable after it enters the
    /// `InService` state.
    ///
    /// During an instance refresh, Amazon EC2 Auto Scaling waits for the warm-up
    /// period after it replaces an
    /// instance before it moves on to replacing the next instance. Amazon EC2 Auto
    /// Scaling also waits for the
    /// warm-up period before aggregating the metrics for new instances with
    /// existing instances
    /// in the Amazon CloudWatch metrics that are used for scaling, resulting in
    /// more reliable usage
    /// data. For more information, see [Set
    /// the default instance warmup for an Auto Scaling
    /// group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-default-instance-warmup.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// To manage various warm-up settings at the group level, we recommend that you
    /// set
    /// the default instance warmup, *even if it is set to 0 seconds*. To
    /// remove a value that you previously set, include the property but specify
    /// `-1` for the value. However, we strongly recommend keeping the
    /// default instance warmup enabled by specifying a value of `0` or other
    /// nominal value.
    default_instance_warmup: ?i32 = null,

    /// The deletion protection setting for the Auto Scaling group. This setting
    /// helps safeguard your Auto Scaling group and its
    /// instances by controlling whether the `DeleteAutoScalingGroup` operation is
    /// allowed. When deletion
    /// protection is enabled, users cannot delete the Auto Scaling group according
    /// to the specified protection level until
    /// the setting is changed back to a less restrictive level.
    ///
    /// The valid values are `none`, `prevent-force-deletion`, and
    /// `prevent-all-deletion`.
    ///
    /// Default: `none`
    ///
    /// For more information, see
    /// [
    /// Configure deletion protection for your Amazon EC2 Auto Scaling
    /// resources](https://docs.aws.amazon.com/autoscaling/ec2/userguide/resource-deletion-protection.html)
    /// in the *Amazon EC2 Auto Scaling User Guide*.
    deletion_protection: ?DeletionProtection = null,

    /// The desired capacity is the initial capacity of the Auto Scaling group after
    /// this operation
    /// completes and the capacity it attempts to maintain. This number must be
    /// greater than or
    /// equal to the minimum size of the group and less than or equal to the maximum
    /// size of the
    /// group.
    desired_capacity: ?i32 = null,

    /// The unit of measurement for the value specified for desired capacity. Amazon
    /// EC2 Auto Scaling
    /// supports `DesiredCapacityType` for attribute-based instance type selection
    /// only. For more information, see [Create a mixed instances group using
    /// attribute-based instance type
    /// selection](https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-mixed-instances-group-attribute-based-instance-type-selection.html) in the *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// By default, Amazon EC2 Auto Scaling specifies `units`, which translates into
    /// number of
    /// instances.
    ///
    /// Valid values: `units` | `vcpu` | `memory-mib`
    desired_capacity_type: ?[]const u8 = null,

    /// The amount of time, in seconds, that Amazon EC2 Auto Scaling waits before
    /// checking the health status
    /// of an EC2 instance that has come into service and marking it unhealthy due
    /// to a failed
    /// health check. This is useful if your instances do not immediately pass their
    /// health
    /// checks after they enter the `InService` state. For more information, see
    /// [Set the health check
    /// grace period for an Auto Scaling
    /// group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/health-check-grace-period.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    health_check_grace_period: ?i32 = null,

    /// A comma-separated value string of one or more health check types.
    ///
    /// The valid values are `EC2`, `EBS`, `ELB`, and
    /// `VPC_LATTICE`. `EC2` is the default health check and cannot be
    /// disabled. For more information, see [Health checks
    /// for instances in an Auto Scaling
    /// group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-health-checks.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// Only specify `EC2` if you must clear a value that was previously
    /// set.
    health_check_type: ?[]const u8 = null,

    /// The instance lifecycle policy for the Auto Scaling group. This policy
    /// controls instance behavior when an instance
    /// transitions through its lifecycle states. Configure retention triggers to
    /// specify when instances should
    /// move to a `Retained` state instead of automatic termination.
    ///
    /// For more information, see
    /// [
    /// Control instance retention with instance lifecycle
    /// policies](https://docs.aws.amazon.com/autoscaling/ec2/userguide/instance-lifecycle-policy.html)
    /// in the *Amazon EC2 Auto Scaling User Guide*.
    instance_lifecycle_policy: ?InstanceLifecyclePolicy = null,

    /// An instance maintenance policy. For more information, see [Set instance
    /// maintenance
    /// policy](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-instance-maintenance-policy.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    instance_maintenance_policy: ?InstanceMaintenancePolicy = null,

    /// The name of the launch configuration. If you specify
    /// `LaunchConfigurationName` in your update request, you can't specify
    /// `LaunchTemplate` or `MixedInstancesPolicy`.
    launch_configuration_name: ?[]const u8 = null,

    /// The launch template and version to use to specify the updates. If you
    /// specify
    /// `LaunchTemplate` in your update request, you can't specify
    /// `LaunchConfigurationName` or `MixedInstancesPolicy`.
    launch_template: ?LaunchTemplateSpecification = null,

    /// The maximum amount of time, in seconds, that an instance can be in service.
    /// The
    /// default is null. If specified, the value must be either 0 or a number equal
    /// to or
    /// greater than 86,400 seconds (1 day). To clear a previously set value,
    /// specify a new
    /// value of 0. For more information, see [Replacing Auto Scaling
    /// instances based on maximum instance
    /// lifetime](https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-max-instance-lifetime.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    max_instance_lifetime: ?i32 = null,

    /// The maximum size of the Auto Scaling group.
    ///
    /// With a mixed instances policy that uses instance weighting, Amazon EC2 Auto
    /// Scaling may need to
    /// go above `MaxSize` to meet your capacity requirements. In this event,
    /// Amazon EC2 Auto Scaling will never go above `MaxSize` by more than your
    /// largest instance
    /// weight (weights that define how many units each instance contributes to the
    /// desired
    /// capacity of the group).
    max_size: ?i32 = null,

    /// The minimum size of the Auto Scaling group.
    min_size: ?i32 = null,

    /// The mixed instances policy. For more information, see [Auto Scaling
    /// groups with multiple instance types and purchase
    /// options](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-mixed-instances-groups.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    mixed_instances_policy: ?MixedInstancesPolicy = null,

    /// Indicates whether newly launched instances are protected from termination by
    /// Amazon EC2 Auto Scaling
    /// when scaling in. For more information about preventing instances from
    /// terminating on
    /// scale in, see [Use
    /// instance scale-in
    /// protection](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-instance-protection.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    new_instances_protected_from_scale_in: ?bool = null,

    /// The name of an existing placement group into which to launch your instances.
    /// To remove the placement group setting, pass an empty string for
    /// `placement-group`. For more
    /// information about placement groups, see [Placement
    /// groups](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html) in the
    /// *Amazon EC2 User Guide*.
    ///
    /// A *cluster* placement group is a logical grouping of instances
    /// within a single Availability Zone. You cannot specify multiple Availability
    /// Zones
    /// and a cluster placement group.
    placement_group: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the service-linked role that the Auto
    /// Scaling group uses to
    /// call other Amazon Web Services on your behalf. For more information, see
    /// [Service-linked
    /// roles](https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-service-linked-role.html) in the *Amazon EC2 Auto Scaling User Guide*.
    service_linked_role_arn: ?[]const u8 = null,

    /// If you enable zonal shift with cross-zone disabled load balancers, capacity
    /// could become imbalanced across Availability Zones. To skip the validation,
    /// specify `true`. For more information, see
    /// [Auto Scaling group zonal
    /// shift](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-zonal-shift.html) in the *Amazon EC2 Auto Scaling User Guide*.
    skip_zonal_shift_validation: ?bool = null,

    /// A policy or a list of policies that are used to select the instances to
    /// terminate. The
    /// policies are executed in the order that you list them. For more information,
    /// see [Configure
    /// termination policies for Amazon EC2 Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-termination-policies.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// Valid values: `Default` | `AllocationStrategy` |
    /// `ClosestToNextInstanceHour` | `NewestInstance` |
    /// `OldestInstance` | `OldestLaunchConfiguration` |
    /// `OldestLaunchTemplate` |
    /// `arn:aws:lambda:region:account-id:function:my-function:my-alias`
    termination_policies: ?[]const []const u8 = null,

    /// A comma-separated list of subnet IDs for a virtual private cloud (VPC). If
    /// you specify
    /// `VPCZoneIdentifier` with `AvailabilityZones`, the subnets that
    /// you specify must reside in those Availability Zones.
    vpc_zone_identifier: ?[]const u8 = null,
};

pub const UpdateAutoScalingGroupOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAutoScalingGroupInput, options: CallOptions) !UpdateAutoScalingGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "autoscaling");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAutoScalingGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=UpdateAutoScalingGroup&Version=2011-01-01");
    try body_buf.appendSlice(allocator, "&AutoScalingGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.auto_scaling_group_name);
    if (input.availability_zone_distribution) |v| {
        if (v.capacity_distribution_strategy) |sv| {
            try body_buf.appendSlice(allocator, "&AvailabilityZoneDistribution.CapacityDistributionStrategy=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
    }
    if (input.availability_zone_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AvailabilityZoneIds.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.availability_zone_impairment_policy) |v| {
        if (v.impaired_zone_health_check_behavior) |sv| {
            try body_buf.appendSlice(allocator, "&AvailabilityZoneImpairmentPolicy.ImpairedZoneHealthCheckBehavior=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
        if (v.zonal_shift_enabled) |sv| {
            try body_buf.appendSlice(allocator, "&AvailabilityZoneImpairmentPolicy.ZonalShiftEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.availability_zones) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AvailabilityZones.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.capacity_rebalance) |v| {
        try body_buf.appendSlice(allocator, "&CapacityRebalance=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.capacity_reservation_specification) |v| {
        if (v.capacity_reservation_preference) |sv| {
            try body_buf.appendSlice(allocator, "&CapacityReservationSpecification.CapacityReservationPreference=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
        if (v.capacity_reservation_target) |sv| {
            if (sv.capacity_reservation_ids) |list_d1| {
                for (list_d1, 0..) |item, idx| {
                    const n = idx + 1;
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CapacityReservationSpecification.CapacityReservationTarget.CapacityReservationIds.member.{d}=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item);
                }
            }
            if (sv.capacity_reservation_resource_group_arns) |list_d1| {
                for (list_d1, 0..) |item, idx| {
                    const n = idx + 1;
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CapacityReservationSpecification.CapacityReservationTarget.CapacityReservationResourceGroupArns.member.{d}=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item);
                }
            }
        }
    }
    if (input.context) |v| {
        try body_buf.appendSlice(allocator, "&Context=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.default_cooldown) |v| {
        try body_buf.appendSlice(allocator, "&DefaultCooldown=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.default_instance_warmup) |v| {
        try body_buf.appendSlice(allocator, "&DefaultInstanceWarmup=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.deletion_protection) |v| {
        try body_buf.appendSlice(allocator, "&DeletionProtection=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.desired_capacity) |v| {
        try body_buf.appendSlice(allocator, "&DesiredCapacity=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.desired_capacity_type) |v| {
        try body_buf.appendSlice(allocator, "&DesiredCapacityType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.health_check_grace_period) |v| {
        try body_buf.appendSlice(allocator, "&HealthCheckGracePeriod=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.health_check_type) |v| {
        try body_buf.appendSlice(allocator, "&HealthCheckType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.instance_lifecycle_policy) |v| {
        if (v.retention_triggers) |sv| {
            if (sv.terminate_hook_abandon) |sv2| {
                try body_buf.appendSlice(allocator, "&InstanceLifecyclePolicy.RetentionTriggers.TerminateHookAbandon=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2.wireName());
            }
        }
    }
    if (input.instance_maintenance_policy) |v| {
        if (v.max_healthy_percentage) |sv| {
            try body_buf.appendSlice(allocator, "&InstanceMaintenancePolicy.MaxHealthyPercentage=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.min_healthy_percentage) |sv| {
            try body_buf.appendSlice(allocator, "&InstanceMaintenancePolicy.MinHealthyPercentage=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
    }
    if (input.launch_configuration_name) |v| {
        try body_buf.appendSlice(allocator, "&LaunchConfigurationName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.launch_template) |v| {
        if (v.launch_template_id) |sv| {
            try body_buf.appendSlice(allocator, "&LaunchTemplate.LaunchTemplateId=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.launch_template_name) |sv| {
            try body_buf.appendSlice(allocator, "&LaunchTemplate.LaunchTemplateName=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.version) |sv| {
            try body_buf.appendSlice(allocator, "&LaunchTemplate.Version=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
    if (input.max_instance_lifetime) |v| {
        try body_buf.appendSlice(allocator, "&MaxInstanceLifetime=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.max_size) |v| {
        try body_buf.appendSlice(allocator, "&MaxSize=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.min_size) |v| {
        try body_buf.appendSlice(allocator, "&MinSize=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.mixed_instances_policy) |v| {
        if (v.instances_distribution) |sv| {
            if (sv.on_demand_allocation_strategy) |sv2| {
                try body_buf.appendSlice(allocator, "&MixedInstancesPolicy.InstancesDistribution.OnDemandAllocationStrategy=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
            if (sv.on_demand_base_capacity) |sv2| {
                try body_buf.appendSlice(allocator, "&MixedInstancesPolicy.InstancesDistribution.OnDemandBaseCapacity=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
            }
            if (sv.on_demand_percentage_above_base_capacity) |sv2| {
                try body_buf.appendSlice(allocator, "&MixedInstancesPolicy.InstancesDistribution.OnDemandPercentageAboveBaseCapacity=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
            }
            if (sv.spot_allocation_strategy) |sv2| {
                try body_buf.appendSlice(allocator, "&MixedInstancesPolicy.InstancesDistribution.SpotAllocationStrategy=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
            if (sv.spot_instance_pools) |sv2| {
                try body_buf.appendSlice(allocator, "&MixedInstancesPolicy.InstancesDistribution.SpotInstancePools=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
            }
            if (sv.spot_max_price) |sv2| {
                try body_buf.appendSlice(allocator, "&MixedInstancesPolicy.InstancesDistribution.SpotMaxPrice=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
        }
        if (v.launch_template) |sv| {
            if (sv.launch_template_specification) |sv2| {
                if (sv2.launch_template_id) |sv3| {
                    try body_buf.appendSlice(allocator, "&MixedInstancesPolicy.LaunchTemplate.LaunchTemplateSpecification.LaunchTemplateId=");
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv3);
                }
                if (sv2.launch_template_name) |sv3| {
                    try body_buf.appendSlice(allocator, "&MixedInstancesPolicy.LaunchTemplate.LaunchTemplateSpecification.LaunchTemplateName=");
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv3);
                }
                if (sv2.version) |sv3| {
                    try body_buf.appendSlice(allocator, "&MixedInstancesPolicy.LaunchTemplate.LaunchTemplateSpecification.Version=");
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv3);
                }
            }
            if (sv.overrides) |list_d1| {
                for (list_d1, 0..) |item, idx| {
                    const n = idx + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item.image_id) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.ImageId=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    if (item.instance_requirements) |sv_2| {
                        if (sv_2.accelerator_count) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.AcceleratorCount.Max=", .{n}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.AcceleratorCount.Min=", .{n}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        if (sv_2.accelerator_manufacturers) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.AcceleratorManufacturers.member.{d}=", .{n, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.wireName());
                                }
                            }
                        }
                        if (sv_2.accelerator_names) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.AcceleratorNames.member.{d}=", .{n, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.wireName());
                                }
                            }
                        }
                        if (sv_2.accelerator_total_memory_mi_b) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.AcceleratorTotalMemoryMiB.Max=", .{n}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.AcceleratorTotalMemoryMiB.Min=", .{n}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        if (sv_2.accelerator_types) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.AcceleratorTypes.member.{d}=", .{n, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.wireName());
                                }
                            }
                        }
                        if (sv_2.allowed_instance_types) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.AllowedInstanceTypes.member.{d}=", .{n, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.bare_metal) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.BareMetal=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3.wireName());
                            }
                        }
                        if (sv_2.baseline_ebs_bandwidth_mbps) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.BaselineEbsBandwidthMbps.Max=", .{n}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.BaselineEbsBandwidthMbps.Min=", .{n}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        if (sv_2.baseline_performance_factors) |sv_3| {
                            if (sv_3.cpu) |sv_4| {
                                if (sv_4.references) |lst_5| {
                                    for (lst_5, 0..) |item_5, idx_5| {
                                        const n_5 = idx_5 + 1;
                                        {
                                            var prefix_buf: [256]u8 = undefined;
                                            if (item_5.instance_family) |fv_6| {
                                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.BaselinePerformanceFactors.Cpu.Reference.item.{d}.InstanceFamily=", .{n, n_5}) catch continue;
                                                try body_buf.appendSlice(allocator, field_prefix);
                                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_6);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.burstable_performance) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.BurstablePerformance=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3.wireName());
                            }
                        }
                        if (sv_2.cpu_manufacturers) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.CpuManufacturers.member.{d}=", .{n, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.wireName());
                                }
                            }
                        }
                        if (sv_2.excluded_instance_types) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.ExcludedInstanceTypes.member.{d}=", .{n, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                                }
                            }
                        }
                        if (sv_2.instance_generations) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.InstanceGenerations.member.{d}=", .{n, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.wireName());
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.local_storage) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.LocalStorage=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3.wireName());
                            }
                        }
                        if (sv_2.local_storage_types) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.LocalStorageTypes.member.{d}=", .{n, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.wireName());
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.max_spot_price_as_percentage_of_optimal_on_demand_price) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.MaxSpotPriceAsPercentageOfOptimalOnDemandPrice=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                        if (sv_2.memory_gi_b_per_v_cpu) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.MemoryGiBPerVCpu.Max=", .{n}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.MemoryGiBPerVCpu.Min=", .{n}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.memory_mi_b.max) |fv_4| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.MemoryMiB.Max=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.MemoryMiB.Min=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv_2.memory_mi_b.min}) catch "");
                        }
                        if (sv_2.network_bandwidth_gbps) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.NetworkBandwidthGbps.Max=", .{n}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.NetworkBandwidthGbps.Min=", .{n}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        if (sv_2.network_interface_count) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.NetworkInterfaceCount.Max=", .{n}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.NetworkInterfaceCount.Min=", .{n}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.on_demand_max_price_percentage_over_lowest_price) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.OnDemandMaxPricePercentageOverLowestPrice=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.require_hibernate_support) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.RequireHibernateSupport=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_3) "true" else "false");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.spot_max_price_percentage_over_lowest_price) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.SpotMaxPricePercentageOverLowestPrice=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                        if (sv_2.total_local_storage_gb) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.TotalLocalStorageGB.Max=", .{n}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.TotalLocalStorageGB.Min=", .{n}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.v_cpu_count.max) |fv_4| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.VCpuCount.Max=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.VCpuCount.Min=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv_2.v_cpu_count.min}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item.instance_type) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceType=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    if (item.launch_template_specification) |sv_2| {
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.launch_template_id) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.LaunchTemplateSpecification.LaunchTemplateId=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.launch_template_name) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.LaunchTemplateSpecification.LaunchTemplateName=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.version) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.LaunchTemplateSpecification.Version=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item.weighted_capacity) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.WeightedCapacity=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.new_instances_protected_from_scale_in) |v| {
        try body_buf.appendSlice(allocator, "&NewInstancesProtectedFromScaleIn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.placement_group) |v| {
        try body_buf.appendSlice(allocator, "&PlacementGroup=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.service_linked_role_arn) |v| {
        try body_buf.appendSlice(allocator, "&ServiceLinkedRoleARN=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.skip_zonal_shift_validation) |v| {
        try body_buf.appendSlice(allocator, "&SkipZonalShiftValidation=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.termination_policies) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TerminationPolicies.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.vpc_zone_identifier) |v| {
        try body_buf.appendSlice(allocator, "&VPCZoneIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAutoScalingGroupOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: UpdateAutoScalingGroupOutput = .{};

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "ActiveInstanceRefreshNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .active_instance_refresh_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchError")) {
        return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InstanceRefreshInProgressFault")) {
        return .{ .arena = arena, .kind = .{ .instance_refresh_in_progress_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextToken")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IrreversibleInstanceRefreshFault")) {
        return .{ .arena = arena, .kind = .{ .irreversible_instance_refresh_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceContentionFault")) {
        return .{ .arena = arena, .kind = .{ .resource_contention_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseFault")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ScalingActivityInProgressFault")) {
        return .{ .arena = arena, .kind = .{ .scaling_activity_in_progress_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceLinkedRoleFailure")) {
        return .{ .arena = arena, .kind = .{ .service_linked_role_failure = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
