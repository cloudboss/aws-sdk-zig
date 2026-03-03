const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AvailabilityZoneDistribution = @import("availability_zone_distribution.zig").AvailabilityZoneDistribution;
const AvailabilityZoneImpairmentPolicy = @import("availability_zone_impairment_policy.zig").AvailabilityZoneImpairmentPolicy;
const CapacityReservationSpecification = @import("capacity_reservation_specification.zig").CapacityReservationSpecification;
const DeletionProtection = @import("deletion_protection.zig").DeletionProtection;
const InstanceLifecyclePolicy = @import("instance_lifecycle_policy.zig").InstanceLifecyclePolicy;
const InstanceMaintenancePolicy = @import("instance_maintenance_policy.zig").InstanceMaintenancePolicy;
const LaunchTemplateSpecification = @import("launch_template_specification.zig").LaunchTemplateSpecification;
const LifecycleHookSpecification = @import("lifecycle_hook_specification.zig").LifecycleHookSpecification;
const MixedInstancesPolicy = @import("mixed_instances_policy.zig").MixedInstancesPolicy;
const Tag = @import("tag.zig").Tag;
const TrafficSourceIdentifier = @import("traffic_source_identifier.zig").TrafficSourceIdentifier;
const serde = @import("serde.zig");

pub const CreateAutoScalingGroupInput = struct {
    /// The name of the Auto Scaling group. This name must be unique per Region per
    /// account.
    ///
    /// The name can contain any ASCII character 33 to 126 including most
    /// punctuation
    /// characters, digits, and upper and lowercased letters.
    ///
    /// You cannot use a colon (:) in the name.
    auto_scaling_group_name: []const u8,

    /// The instance capacity distribution across Availability Zones.
    availability_zone_distribution: ?AvailabilityZoneDistribution = null,

    /// The policy for Availability Zone impairment.
    availability_zone_impairment_policy: ?AvailabilityZoneImpairmentPolicy = null,

    /// A list of Availability Zones where instances in the Auto Scaling group can
    /// be created. Used
    /// for launching into the default VPC subnet in each Availability Zone when not
    /// using the
    /// `VPCZoneIdentifier` property, or for attaching a network interface when
    /// an existing network interface ID is specified in a launch template.
    availability_zones: ?[]const []const u8 = null,

    /// Indicates whether Capacity Rebalancing is enabled. Otherwise, Capacity
    /// Rebalancing is
    /// disabled. When you turn on Capacity Rebalancing, Amazon EC2 Auto Scaling
    /// attempts to launch a Spot
    /// Instance whenever Amazon EC2 notifies that a Spot Instance is at an elevated
    /// risk of
    /// interruption. After launching a new instance, it then terminates an old
    /// instance. For
    /// more information, see [Use Capacity
    /// Rebalancing to handle Amazon EC2 Spot
    /// Interruptions](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-capacity-rebalancing.html) in the in the *Amazon EC2 Auto Scaling User Guide*.
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
    ///
    /// Default: `300` seconds
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
    ///
    /// Default: None
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
    deletion_protection: ?DeletionProtection = null,

    /// The desired capacity is the initial capacity of the Auto Scaling group at
    /// the time of its
    /// creation and the capacity it attempts to maintain. It can scale beyond this
    /// capacity if
    /// you configure auto scaling. This number must be greater than or equal to the
    /// minimum
    /// size of the group and less than or equal to the maximum size of the group.
    /// If you do not
    /// specify a desired capacity, the default is the minimum size of the group.
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
    ///
    /// Default: `0` seconds
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

    /// The ID of the instance used to base the launch configuration on. If
    /// specified, Amazon EC2 Auto Scaling uses the configuration values from the
    /// specified instance to create a
    /// new launch configuration. To get the instance ID, use the Amazon EC2
    /// [DescribeInstances](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstances.html) API operation. For more information, see [Create an Auto Scaling group using parameters from an existing instance](https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-asg-from-instance.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    instance_id: ?[]const u8 = null,

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
    ///
    /// Instances in a Retained state will continue to incur standard EC2 charges
    /// until terminated.
    instance_lifecycle_policy: ?InstanceLifecyclePolicy = null,

    /// An instance maintenance policy. For more information, see [Set instance
    /// maintenance
    /// policy](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-instance-maintenance-policy.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    instance_maintenance_policy: ?InstanceMaintenancePolicy = null,

    /// The name of the launch configuration to use to launch instances.
    ///
    /// Conditional: You must specify either a launch template (`LaunchTemplate` or
    /// `MixedInstancesPolicy`) or a launch configuration
    /// (`LaunchConfigurationName` or `InstanceId`).
    launch_configuration_name: ?[]const u8 = null,

    /// Information used to specify the launch template and version to use to launch
    /// instances.
    ///
    /// Conditional: You must specify either a launch template (`LaunchTemplate` or
    /// `MixedInstancesPolicy`) or a launch configuration
    /// (`LaunchConfigurationName` or `InstanceId`).
    ///
    /// The launch template that is specified must be configured for use with an
    /// Auto Scaling
    /// group. For more information, see [Create a launch
    /// template for an Auto Scaling
    /// group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-launch-template.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    launch_template: ?LaunchTemplateSpecification = null,

    /// One or more lifecycle hooks to add to the Auto Scaling group before
    /// instances are
    /// launched.
    lifecycle_hook_specification_list: ?[]const LifecycleHookSpecification = null,

    /// A list of Classic Load Balancers associated with this Auto Scaling group.
    /// For Application Load Balancers, Network Load Balancers, and Gateway Load
    /// Balancers,
    /// specify the `TargetGroupARNs` property instead.
    load_balancer_names: ?[]const []const u8 = null,

    /// The maximum amount of time, in seconds, that an instance can be in service.
    /// The
    /// default is null. If specified, the value must be either 0 or a number equal
    /// to or
    /// greater than 86,400 seconds (1 day). For more information, see [Replace Auto
    /// Scaling instances based on maximum instance
    /// lifetime](https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-max-instance-lifetime.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    max_instance_lifetime: ?i32 = null,

    /// The maximum size of the group.
    ///
    /// With a mixed instances policy that uses instance weighting, Amazon EC2 Auto
    /// Scaling may need to
    /// go above `MaxSize` to meet your capacity requirements. In this event,
    /// Amazon EC2 Auto Scaling will never go above `MaxSize` by more than your
    /// largest instance
    /// weight (weights that define how many units each instance contributes to the
    /// desired
    /// capacity of the group).
    max_size: i32,

    /// The minimum size of the group.
    min_size: i32,

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

    /// The name of the placement group into which to launch your instances. For
    /// more
    /// information, see [Placement
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
    /// call other Amazon Web Services service on your behalf. By default, Amazon
    /// EC2 Auto Scaling uses a service-linked role
    /// named `AWSServiceRoleForAutoScaling`, which it creates if it does not exist.
    /// For more information, see [Service-linked
    /// roles](https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-service-linked-role.html) in the *Amazon EC2 Auto Scaling User Guide*.
    service_linked_role_arn: ?[]const u8 = null,

    /// If you enable zonal shift with cross-zone disabled load balancers, capacity
    /// could become imbalanced across Availability Zones. To skip the validation,
    /// specify `true`. For more information, see
    /// [Auto Scaling group zonal
    /// shift](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-zonal-shift.html) in the *Amazon EC2 Auto Scaling User Guide*.
    skip_zonal_shift_validation: ?bool = null,

    /// One or more tags. You can tag your Auto Scaling group and propagate the tags
    /// to the Amazon EC2
    /// instances it launches. Tags are not propagated to Amazon EBS volumes. To add
    /// tags to Amazon EBS
    /// volumes, specify the tags in a launch template but use caution. If the
    /// launch template
    /// specifies an instance tag with a key that is also specified for the Auto
    /// Scaling group, Amazon EC2 Auto Scaling
    /// overrides the value of that instance tag with the value specified by the
    /// Auto Scaling group. For
    /// more information, see [Tag Auto Scaling groups and
    /// instances](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-tagging.html) in the *Amazon EC2 Auto Scaling User Guide*.
    tags: ?[]const Tag = null,

    /// The Amazon Resource Names (ARN) of the Elastic Load Balancing target groups
    /// to associate with the Auto Scaling
    /// group. Instances are registered as targets with the target groups. The
    /// target groups
    /// receive incoming traffic and route requests to one or more registered
    /// targets. For more
    /// information, see [Use Elastic Load Balancing to
    /// distribute traffic across the instances in your Auto Scaling
    /// group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-load-balancer.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    target_group_ar_ns: ?[]const []const u8 = null,

    /// A policy or a list of policies that are used to select the instance to
    /// terminate.
    /// These policies are executed in the order that you list them. For more
    /// information, see
    /// [Configure
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

    /// The list of traffic sources to attach to this Auto Scaling group. You can
    /// use any of the
    /// following as traffic sources for an Auto Scaling group: Classic Load
    /// Balancer, Application Load Balancer, Gateway Load Balancer, Network Load
    /// Balancer, and
    /// VPC Lattice.
    traffic_sources: ?[]const TrafficSourceIdentifier = null,

    /// A comma-separated list of subnet IDs for a virtual private cloud (VPC) where
    /// instances
    /// in the Auto Scaling group can be created. If you specify `VPCZoneIdentifier`
    /// with
    /// `AvailabilityZones`, the subnets that you specify must reside in those
    /// Availability Zones.
    vpc_zone_identifier: ?[]const u8 = null,
};

const CreateAutoScalingGroupOutput = struct {};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAutoScalingGroupInput, options: Options) !CreateAutoScalingGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAutoScalingGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateAutoScalingGroup&Version=2011-01-01");
    try body_buf.appendSlice(allocator, "&AutoScalingGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.auto_scaling_group_name);
    if (input.availability_zone_distribution) |v| {
        if (v.capacity_distribution_strategy) |sv| {
            try body_buf.appendSlice(allocator, "&AvailabilityZoneDistribution.CapacityDistributionStrategy=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
    }
    if (input.availability_zone_impairment_policy) |v| {
        if (v.impaired_zone_health_check_behavior) |sv| {
            try body_buf.appendSlice(allocator, "&AvailabilityZoneImpairmentPolicy.ImpairedZoneHealthCheckBehavior=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
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
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
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
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
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
    if (input.instance_id) |v| {
        try body_buf.appendSlice(allocator, "&InstanceId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.instance_lifecycle_policy) |v| {
        if (v.retention_triggers) |sv| {
            if (sv.terminate_hook_abandon) |sv2| {
                try body_buf.appendSlice(allocator, "&InstanceLifecyclePolicy.RetentionTriggers.TerminateHookAbandon=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv2));
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
    if (input.lifecycle_hook_specification_list) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LifecycleHookSpecificationList.member.{d}.DefaultResult=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.default_result) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LifecycleHookSpecificationList.member.{d}.HeartbeatTimeout=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.heartbeat_timeout) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LifecycleHookSpecificationList.member.{d}.LifecycleHookName=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.lifecycle_hook_name);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LifecycleHookSpecificationList.member.{d}.LifecycleTransition=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.lifecycle_transition);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LifecycleHookSpecificationList.member.{d}.NotificationMetadata=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.notification_metadata) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LifecycleHookSpecificationList.member.{d}.NotificationTargetARN=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.notification_target_arn) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LifecycleHookSpecificationList.member.{d}.RoleARN=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.role_arn) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.load_balancer_names) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LoadBalancerNames.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.max_instance_lifetime) |v| {
        try body_buf.appendSlice(allocator, "&MaxInstanceLifetime=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&MaxSize=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.max_size}) catch "");
    try body_buf.appendSlice(allocator, "&MinSize=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.min_size}) catch "");
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
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.ImageId=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item.image_id) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    if (item.instance_requirements) |sv_2| {
                        if (sv_2.accelerator_count) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.AcceleratorCount.Max=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.AcceleratorCount.Min=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                if (sv_3.min) |fv_4| {
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
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
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
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                                }
                            }
                        }
                        if (sv_2.accelerator_total_memory_mi_b) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.AcceleratorTotalMemoryMiB.Max=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.AcceleratorTotalMemoryMiB.Min=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                if (sv_3.min) |fv_4| {
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
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
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
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.BareMetal=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            if (sv_2.bare_metal) |fv_3| {
                                try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(fv_3));
                            }
                        }
                        if (sv_2.baseline_ebs_bandwidth_mbps) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.BaselineEbsBandwidthMbps.Max=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.BaselineEbsBandwidthMbps.Min=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                if (sv_3.min) |fv_4| {
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
                                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.BaselinePerformanceFactors.Cpu.References.item.{d}.InstanceFamily=", .{n, n_5}) catch continue;
                                            try body_buf.appendSlice(allocator, field_prefix);
                                            if (item_5.instance_family) |fv_6| {
                                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_6);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.BurstablePerformance=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            if (sv_2.burstable_performance) |fv_3| {
                                try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(fv_3));
                            }
                        }
                        if (sv_2.cpu_manufacturers) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.CpuManufacturers.member.{d}=", .{n, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
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
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.LocalStorage=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            if (sv_2.local_storage) |fv_3| {
                                try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(fv_3));
                            }
                        }
                        if (sv_2.local_storage_types) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.LocalStorageTypes.member.{d}=", .{n, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.MaxSpotPriceAsPercentageOfOptimalOnDemandPrice=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            if (sv_2.max_spot_price_as_percentage_of_optimal_on_demand_price) |fv_3| {
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                        if (sv_2.memory_gi_b_per_v_cpu) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.MemoryGiBPerVCpu.Max=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_4);
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.MemoryGiBPerVCpu.Min=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                if (sv_3.min) |fv_4| {
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_4);
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.MemoryMiB.Max=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            if (sv_2.memory_mi_b.max) |fv_4| {
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
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.NetworkBandwidthGbps.Max=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_4);
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.NetworkBandwidthGbps.Min=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                if (sv_3.min) |fv_4| {
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_4);
                                }
                            }
                        }
                        if (sv_2.network_interface_count) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.NetworkInterfaceCount.Max=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.NetworkInterfaceCount.Min=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                if (sv_3.min) |fv_4| {
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.OnDemandMaxPricePercentageOverLowestPrice=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            if (sv_2.on_demand_max_price_percentage_over_lowest_price) |fv_3| {
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.RequireHibernateSupport=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            if (sv_2.require_hibernate_support) |fv_3| {
                                try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_3) "true" else "false");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.SpotMaxPricePercentageOverLowestPrice=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            if (sv_2.spot_max_price_percentage_over_lowest_price) |fv_3| {
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                        if (sv_2.total_local_storage_gb) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.TotalLocalStorageGB.Max=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_4);
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.TotalLocalStorageGB.Min=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                if (sv_3.min) |fv_4| {
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_4);
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.VCpuCount.Max=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            if (sv_2.v_cpu_count.max) |fv_4| {
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
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceType=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item.instance_type) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    if (item.launch_template_specification) |sv_2| {
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.LaunchTemplateSpecification.LaunchTemplateId=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            if (sv_2.launch_template_id) |fv_3| {
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.LaunchTemplateSpecification.LaunchTemplateName=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            if (sv_2.launch_template_name) |fv_3| {
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.LaunchTemplateSpecification.Version=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            if (sv_2.version) |fv_3| {
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.WeightedCapacity=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item.weighted_capacity) |fv_2| {
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
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.key);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.PropagateAtLaunch=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.propagate_at_launch) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.ResourceId=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.resource_id) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.value) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.target_group_ar_ns) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetGroupARNs.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
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
    if (input.traffic_sources) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TrafficSources.member.{d}.Identifier=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.identifier);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TrafficSources.member.{d}.Type=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.@"type") |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAutoScalingGroupOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: CreateAutoScalingGroupOutput = .{};

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
