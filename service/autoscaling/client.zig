const aws = @import("aws");
const std = @import("std");

const attach_instances = @import("attach_instances.zig");
const attach_load_balancer_target_groups = @import("attach_load_balancer_target_groups.zig");
const attach_load_balancers = @import("attach_load_balancers.zig");
const attach_traffic_sources = @import("attach_traffic_sources.zig");
const batch_delete_scheduled_action = @import("batch_delete_scheduled_action.zig");
const batch_put_scheduled_update_group_action = @import("batch_put_scheduled_update_group_action.zig");
const cancel_instance_refresh = @import("cancel_instance_refresh.zig");
const complete_lifecycle_action = @import("complete_lifecycle_action.zig");
const create_auto_scaling_group = @import("create_auto_scaling_group.zig");
const create_launch_configuration = @import("create_launch_configuration.zig");
const create_or_update_tags = @import("create_or_update_tags.zig");
const delete_auto_scaling_group = @import("delete_auto_scaling_group.zig");
const delete_launch_configuration = @import("delete_launch_configuration.zig");
const delete_lifecycle_hook = @import("delete_lifecycle_hook.zig");
const delete_notification_configuration = @import("delete_notification_configuration.zig");
const delete_policy = @import("delete_policy.zig");
const delete_scheduled_action = @import("delete_scheduled_action.zig");
const delete_tags = @import("delete_tags.zig");
const delete_warm_pool = @import("delete_warm_pool.zig");
const describe_account_limits = @import("describe_account_limits.zig");
const describe_adjustment_types = @import("describe_adjustment_types.zig");
const describe_auto_scaling_groups = @import("describe_auto_scaling_groups.zig");
const describe_auto_scaling_instances = @import("describe_auto_scaling_instances.zig");
const describe_auto_scaling_notification_types = @import("describe_auto_scaling_notification_types.zig");
const describe_instance_refreshes = @import("describe_instance_refreshes.zig");
const describe_launch_configurations = @import("describe_launch_configurations.zig");
const describe_lifecycle_hook_types = @import("describe_lifecycle_hook_types.zig");
const describe_lifecycle_hooks = @import("describe_lifecycle_hooks.zig");
const describe_load_balancer_target_groups = @import("describe_load_balancer_target_groups.zig");
const describe_load_balancers = @import("describe_load_balancers.zig");
const describe_metric_collection_types = @import("describe_metric_collection_types.zig");
const describe_notification_configurations = @import("describe_notification_configurations.zig");
const describe_policies = @import("describe_policies.zig");
const describe_scaling_activities = @import("describe_scaling_activities.zig");
const describe_scaling_process_types = @import("describe_scaling_process_types.zig");
const describe_scheduled_actions = @import("describe_scheduled_actions.zig");
const describe_tags = @import("describe_tags.zig");
const describe_termination_policy_types = @import("describe_termination_policy_types.zig");
const describe_traffic_sources = @import("describe_traffic_sources.zig");
const describe_warm_pool = @import("describe_warm_pool.zig");
const detach_instances = @import("detach_instances.zig");
const detach_load_balancer_target_groups = @import("detach_load_balancer_target_groups.zig");
const detach_load_balancers = @import("detach_load_balancers.zig");
const detach_traffic_sources = @import("detach_traffic_sources.zig");
const disable_metrics_collection = @import("disable_metrics_collection.zig");
const enable_metrics_collection = @import("enable_metrics_collection.zig");
const enter_standby = @import("enter_standby.zig");
const execute_policy = @import("execute_policy.zig");
const exit_standby = @import("exit_standby.zig");
const get_predictive_scaling_forecast = @import("get_predictive_scaling_forecast.zig");
const launch_instances = @import("launch_instances.zig");
const put_lifecycle_hook = @import("put_lifecycle_hook.zig");
const put_notification_configuration = @import("put_notification_configuration.zig");
const put_scaling_policy = @import("put_scaling_policy.zig");
const put_scheduled_update_group_action = @import("put_scheduled_update_group_action.zig");
const put_warm_pool = @import("put_warm_pool.zig");
const record_lifecycle_action_heartbeat = @import("record_lifecycle_action_heartbeat.zig");
const resume_processes = @import("resume_processes.zig");
const rollback_instance_refresh = @import("rollback_instance_refresh.zig");
const set_desired_capacity = @import("set_desired_capacity.zig");
const set_instance_health = @import("set_instance_health.zig");
const set_instance_protection = @import("set_instance_protection.zig");
const start_instance_refresh = @import("start_instance_refresh.zig");
const suspend_processes = @import("suspend_processes.zig");
const terminate_instance_in_auto_scaling_group = @import("terminate_instance_in_auto_scaling_group.zig");
const update_auto_scaling_group = @import("update_auto_scaling_group.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Auto Scaling";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Attaches one or more EC2 instances to the specified Auto Scaling group.
    ///
    /// When you attach instances, Amazon EC2 Auto Scaling increases the desired
    /// capacity of the group by the
    /// number of instances being attached. If the number of instances being
    /// attached plus the
    /// desired capacity of the group exceeds the maximum size of the group, the
    /// operation
    /// fails.
    ///
    /// If there is a Classic Load Balancer attached to your Auto Scaling group, the
    /// instances are
    /// also registered with the load balancer. If there are target groups attached
    /// to your Auto Scaling
    /// group, the instances are also registered with the target groups.
    ///
    /// For more information, see [Detach
    /// or attach
    /// instances](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-detach-attach-instances.html) in the *Amazon EC2 Auto Scaling User Guide*.
    pub fn attachInstances(self: *Self, allocator: std.mem.Allocator, input: attach_instances.AttachInstancesInput, options: attach_instances.Options) !attach_instances.AttachInstancesOutput {
        return attach_instances.execute(self, allocator, input, options);
    }

    /// This API operation is superseded by
    /// [AttachTrafficSources](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_AttachTrafficSources.html), which
    /// can attach multiple traffic sources types. We recommend using
    /// `AttachTrafficSources` to simplify how you manage traffic sources.
    /// However, we continue to support `AttachLoadBalancerTargetGroups`. You can
    /// use both the original `AttachLoadBalancerTargetGroups` API operation and
    /// `AttachTrafficSources` on the same Auto Scaling group.
    ///
    /// Attaches one or more target groups to the specified Auto Scaling group.
    ///
    /// This operation is used with the following load balancer types:
    ///
    /// * Application Load Balancer - Operates at the application layer (layer 7)
    ///   and supports HTTP and
    /// HTTPS.
    ///
    /// * Network Load Balancer - Operates at the transport layer (layer 4) and
    ///   supports TCP, TLS, and
    /// UDP.
    ///
    /// * Gateway Load Balancer - Operates at the network layer (layer 3).
    ///
    /// To describe the target groups for an Auto Scaling group, call the
    /// [DescribeLoadBalancerTargetGroups](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeLoadBalancerTargetGroups.html)
    /// API. To detach the target group from
    /// the Auto Scaling group, call the
    /// [DetachLoadBalancerTargetGroups](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DetachLoadBalancerTargetGroups.html) API.
    ///
    /// This operation is additive and does not detach existing target groups or
    /// Classic Load
    /// Balancers from the Auto Scaling group.
    ///
    /// For more information, see [Use Elastic Load Balancing to
    /// distribute traffic across the instances in your Auto Scaling
    /// group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-load-balancer.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    pub fn attachLoadBalancerTargetGroups(self: *Self, allocator: std.mem.Allocator, input: attach_load_balancer_target_groups.AttachLoadBalancerTargetGroupsInput, options: attach_load_balancer_target_groups.Options) !attach_load_balancer_target_groups.AttachLoadBalancerTargetGroupsOutput {
        return attach_load_balancer_target_groups.execute(self, allocator, input, options);
    }

    /// This API operation is superseded by
    /// [AttachTrafficSources](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_AttachTrafficSources.html), which
    /// can attach multiple traffic sources types. We recommend using
    /// `AttachTrafficSources` to simplify how you manage traffic sources.
    /// However, we continue to support `AttachLoadBalancers`. You can use both
    /// the original `AttachLoadBalancers` API operation and
    /// `AttachTrafficSources` on the same Auto Scaling group.
    ///
    /// Attaches one or more Classic Load Balancers to the specified Auto Scaling
    /// group. Amazon EC2 Auto Scaling registers the
    /// running instances with these Classic Load Balancers.
    ///
    /// To describe the load balancers for an Auto Scaling group, call the
    /// [DescribeLoadBalancers](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeLoadBalancers.html) API.
    /// To detach a load balancer from the Auto Scaling group, call the
    /// [DetachLoadBalancers](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DetachLoadBalancers.html)
    /// API.
    ///
    /// This operation is additive and does not detach existing Classic Load
    /// Balancers or
    /// target groups from the Auto Scaling group.
    ///
    /// For more information, see [Use Elastic Load Balancing to
    /// distribute traffic across the instances in your Auto Scaling
    /// group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-load-balancer.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    pub fn attachLoadBalancers(self: *Self, allocator: std.mem.Allocator, input: attach_load_balancers.AttachLoadBalancersInput, options: attach_load_balancers.Options) !attach_load_balancers.AttachLoadBalancersOutput {
        return attach_load_balancers.execute(self, allocator, input, options);
    }

    /// Attaches one or more traffic sources to the specified Auto Scaling group.
    ///
    /// You can use any of the following as traffic sources for an Auto Scaling
    /// group:
    ///
    /// * Application Load Balancer
    ///
    /// * Classic Load Balancer
    ///
    /// * Gateway Load Balancer
    ///
    /// * Network Load Balancer
    ///
    /// * VPC Lattice
    ///
    /// This operation is additive and does not detach existing traffic sources from
    /// the Auto Scaling
    /// group.
    ///
    /// After the operation completes, use the
    /// [DescribeTrafficSources](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeTrafficSources.html) API to
    /// return details about the state of the attachments between traffic sources
    /// and your Auto Scaling
    /// group. To detach a traffic source from the Auto Scaling group, call the
    /// [DetachTrafficSources](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DetachTrafficSources.html) API.
    pub fn attachTrafficSources(self: *Self, allocator: std.mem.Allocator, input: attach_traffic_sources.AttachTrafficSourcesInput, options: attach_traffic_sources.Options) !attach_traffic_sources.AttachTrafficSourcesOutput {
        return attach_traffic_sources.execute(self, allocator, input, options);
    }

    /// Deletes one or more scheduled actions for the specified Auto Scaling group.
    pub fn batchDeleteScheduledAction(self: *Self, allocator: std.mem.Allocator, input: batch_delete_scheduled_action.BatchDeleteScheduledActionInput, options: batch_delete_scheduled_action.Options) !batch_delete_scheduled_action.BatchDeleteScheduledActionOutput {
        return batch_delete_scheduled_action.execute(self, allocator, input, options);
    }

    /// Creates or updates one or more scheduled scaling actions for an Auto Scaling
    /// group.
    pub fn batchPutScheduledUpdateGroupAction(self: *Self, allocator: std.mem.Allocator, input: batch_put_scheduled_update_group_action.BatchPutScheduledUpdateGroupActionInput, options: batch_put_scheduled_update_group_action.Options) !batch_put_scheduled_update_group_action.BatchPutScheduledUpdateGroupActionOutput {
        return batch_put_scheduled_update_group_action.execute(self, allocator, input, options);
    }

    /// Cancels an instance refresh or rollback that is in progress. If an instance
    /// refresh or
    /// rollback is not in progress, an `ActiveInstanceRefreshNotFound` error
    /// occurs.
    ///
    /// This operation is part of the [instance refresh
    /// feature](https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-instance-refresh.html) in Amazon EC2 Auto Scaling, which helps you update instances in your Auto Scaling group
    /// after you make configuration changes.
    ///
    /// When you cancel an instance refresh, this does not roll back any changes
    /// that it made.
    /// Use the
    /// [RollbackInstanceRefresh](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_RollbackInstanceRefresh.html) API to roll back instead.
    pub fn cancelInstanceRefresh(self: *Self, allocator: std.mem.Allocator, input: cancel_instance_refresh.CancelInstanceRefreshInput, options: cancel_instance_refresh.Options) !cancel_instance_refresh.CancelInstanceRefreshOutput {
        return cancel_instance_refresh.execute(self, allocator, input, options);
    }

    /// Completes the lifecycle action for the specified token or instance with the
    /// specified
    /// result.
    ///
    /// This step is a part of the procedure for adding a lifecycle hook to an Auto
    /// Scaling
    /// group:
    ///
    /// * (Optional) Create a launch template or launch configuration with a user
    ///   data
    /// script that runs while an instance is in a wait state due to a lifecycle
    /// hook.
    ///
    /// * (Optional) Create a Lambda function and a rule that allows Amazon
    ///   EventBridge to invoke
    /// your Lambda function when an instance is put into a wait state due to a
    /// lifecycle hook.
    ///
    /// * (Optional) Create a notification target and an IAM role. The target can be
    /// either an Amazon SQS queue or an Amazon SNS topic. The role allows Amazon
    /// EC2 Auto Scaling to publish
    /// lifecycle notifications to the target.
    ///
    /// * Create the lifecycle hook. Specify whether the hook is used when the
    ///   instances
    /// launch or terminate.
    ///
    /// * If you need more time, record the lifecycle action heartbeat to keep the
    /// instance in a wait state.
    ///
    /// * **If you finish before the timeout period ends, send a
    /// callback by using the
    /// [CompleteLifecycleAction](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_CompleteLifecycleAction.html) API
    /// call.**
    ///
    /// For more information, see [Complete a lifecycle
    /// action](https://docs.aws.amazon.com/autoscaling/ec2/userguide/completing-lifecycle-hooks.html) in the *Amazon EC2 Auto Scaling User Guide*.
    pub fn completeLifecycleAction(self: *Self, allocator: std.mem.Allocator, input: complete_lifecycle_action.CompleteLifecycleActionInput, options: complete_lifecycle_action.Options) !complete_lifecycle_action.CompleteLifecycleActionOutput {
        return complete_lifecycle_action.execute(self, allocator, input, options);
    }

    /// **We strongly recommend using a launch template when calling this operation
    /// to ensure full functionality for Amazon EC2 Auto Scaling and Amazon EC2.**
    ///
    /// Creates an Auto Scaling group with the specified name and attributes.
    ///
    /// If you exceed your maximum limit of Auto Scaling groups, the call fails. To
    /// query this limit,
    /// call the
    /// [DescribeAccountLimits](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeAccountLimits.html) API. For information about updating
    /// this limit, see [Quotas for
    /// Amazon EC2 Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-quotas.html) in the *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// If you're new to Amazon EC2 Auto Scaling, see the introductory tutorials in
    /// [Get started
    /// with Amazon EC2 Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/get-started-with-ec2-auto-scaling.html) in the *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// Every Auto Scaling group has three size properties (`DesiredCapacity`,
    /// `MaxSize`, and `MinSize`). Usually, you set these sizes based
    /// on a specific number of instances. However, if you configure a mixed
    /// instances policy
    /// that defines weights for the instance types, you must specify these sizes
    /// with the same
    /// units that you use for weighting instances.
    pub fn createAutoScalingGroup(self: *Self, allocator: std.mem.Allocator, input: create_auto_scaling_group.CreateAutoScalingGroupInput, options: create_auto_scaling_group.Options) !create_auto_scaling_group.CreateAutoScalingGroupOutput {
        return create_auto_scaling_group.execute(self, allocator, input, options);
    }

    /// Creates a launch configuration.
    ///
    /// If you exceed your maximum limit of launch configurations, the call fails.
    /// To query
    /// this limit, call the
    /// [DescribeAccountLimits](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeAccountLimits.html) API.
    /// For information about updating this limit, see [Quotas for
    /// Amazon EC2 Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-quotas.html) in the *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// For more information, see [Launch
    /// configurations](https://docs.aws.amazon.com/autoscaling/ec2/userguide/launch-configurations.html) in the *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// Amazon EC2 Auto Scaling configures instances launched as part of an Auto
    /// Scaling group using either a
    /// launch template or a launch configuration. We strongly recommend that you do
    /// not use
    /// launch configurations. They do not provide full functionality for Amazon EC2
    /// Auto Scaling or Amazon EC2.
    /// For information about using launch templates, see [Launch
    /// templates](https://docs.aws.amazon.com/autoscaling/ec2/userguide/launch-templates.html) in the *Amazon EC2 Auto Scaling User Guide*.
    pub fn createLaunchConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_launch_configuration.CreateLaunchConfigurationInput, options: create_launch_configuration.Options) !create_launch_configuration.CreateLaunchConfigurationOutput {
        return create_launch_configuration.execute(self, allocator, input, options);
    }

    /// Creates or updates tags for the specified Auto Scaling group.
    ///
    /// When you specify a tag with a key that already exists, the operation
    /// overwrites the
    /// previous tag definition, and you do not get an error message.
    ///
    /// For more information, see [Tag Auto Scaling groups and
    /// instances](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-tagging.html) in the *Amazon EC2 Auto Scaling User Guide*.
    pub fn createOrUpdateTags(self: *Self, allocator: std.mem.Allocator, input: create_or_update_tags.CreateOrUpdateTagsInput, options: create_or_update_tags.Options) !create_or_update_tags.CreateOrUpdateTagsOutput {
        return create_or_update_tags.execute(self, allocator, input, options);
    }

    /// Deletes the specified Auto Scaling group.
    ///
    /// If the group has instances or scaling activities in progress, you must
    /// specify the
    /// option to force the deletion in order for it to succeed. The force delete
    /// operation will
    /// also terminate the EC2 instances. If the group has a warm pool, the force
    /// delete option
    /// also deletes the warm pool.
    ///
    /// To remove instances from the Auto Scaling group before deleting it, call the
    /// [DetachInstances](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DetachInstances.html) API with the list of instances and the option to
    /// decrement the desired capacity. This ensures that Amazon EC2 Auto Scaling
    /// does not launch replacement
    /// instances.
    ///
    /// To terminate all instances before deleting the Auto Scaling group, call the
    /// [UpdateAutoScalingGroup](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_UpdateAutoScalingGroup.html) API and set the minimum size and desired capacity
    /// of the Auto Scaling group to
    /// zero.
    ///
    /// If the group has scaling policies, deleting the group deletes the policies,
    /// the
    /// underlying alarm actions, and any alarm that no longer has an associated
    /// action.
    ///
    /// For more information, see [Delete your Auto Scaling
    /// infrastructure](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-process-shutdown.html) in the *Amazon EC2 Auto Scaling User Guide*.
    pub fn deleteAutoScalingGroup(self: *Self, allocator: std.mem.Allocator, input: delete_auto_scaling_group.DeleteAutoScalingGroupInput, options: delete_auto_scaling_group.Options) !delete_auto_scaling_group.DeleteAutoScalingGroupOutput {
        return delete_auto_scaling_group.execute(self, allocator, input, options);
    }

    /// Deletes the specified launch configuration.
    ///
    /// The launch configuration must not be attached to an Auto Scaling group. When
    /// this call
    /// completes, the launch configuration is no longer available for use.
    pub fn deleteLaunchConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_launch_configuration.DeleteLaunchConfigurationInput, options: delete_launch_configuration.Options) !delete_launch_configuration.DeleteLaunchConfigurationOutput {
        return delete_launch_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the specified lifecycle hook.
    ///
    /// If there are any outstanding lifecycle actions, they are completed first
    /// (`ABANDON` for launching instances, `CONTINUE` for terminating
    /// instances).
    pub fn deleteLifecycleHook(self: *Self, allocator: std.mem.Allocator, input: delete_lifecycle_hook.DeleteLifecycleHookInput, options: delete_lifecycle_hook.Options) !delete_lifecycle_hook.DeleteLifecycleHookOutput {
        return delete_lifecycle_hook.execute(self, allocator, input, options);
    }

    /// Deletes the specified notification.
    pub fn deleteNotificationConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_notification_configuration.DeleteNotificationConfigurationInput, options: delete_notification_configuration.Options) !delete_notification_configuration.DeleteNotificationConfigurationOutput {
        return delete_notification_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the specified scaling policy.
    ///
    /// Deleting either a step scaling policy or a simple scaling policy deletes the
    /// underlying alarm action, but does not delete the alarm, even if it no longer
    /// has an
    /// associated action.
    ///
    /// For more information, see [Delete a scaling
    /// policy](https://docs.aws.amazon.com/autoscaling/ec2/userguide/deleting-scaling-policy.html) in the *Amazon EC2 Auto Scaling User Guide*.
    pub fn deletePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_policy.DeletePolicyInput, options: delete_policy.Options) !delete_policy.DeletePolicyOutput {
        return delete_policy.execute(self, allocator, input, options);
    }

    /// Deletes the specified scheduled action.
    pub fn deleteScheduledAction(self: *Self, allocator: std.mem.Allocator, input: delete_scheduled_action.DeleteScheduledActionInput, options: delete_scheduled_action.Options) !delete_scheduled_action.DeleteScheduledActionOutput {
        return delete_scheduled_action.execute(self, allocator, input, options);
    }

    /// Deletes the specified tags.
    pub fn deleteTags(self: *Self, allocator: std.mem.Allocator, input: delete_tags.DeleteTagsInput, options: delete_tags.Options) !delete_tags.DeleteTagsOutput {
        return delete_tags.execute(self, allocator, input, options);
    }

    /// Deletes the warm pool for the specified Auto Scaling group.
    ///
    /// For more information, see [Warm pools for
    /// Amazon EC2 Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-warm-pools.html) in the *Amazon EC2 Auto Scaling User Guide*.
    pub fn deleteWarmPool(self: *Self, allocator: std.mem.Allocator, input: delete_warm_pool.DeleteWarmPoolInput, options: delete_warm_pool.Options) !delete_warm_pool.DeleteWarmPoolOutput {
        return delete_warm_pool.execute(self, allocator, input, options);
    }

    /// Describes the current Amazon EC2 Auto Scaling resource quotas for your
    /// account.
    ///
    /// When you establish an Amazon Web Services account, the account has initial
    /// quotas on the maximum
    /// number of Auto Scaling groups and launch configurations that you can create
    /// in a given Region.
    /// For more information, see [Quotas for
    /// Amazon EC2 Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-quotas.html) in the *Amazon EC2 Auto Scaling User Guide*.
    pub fn describeAccountLimits(self: *Self, allocator: std.mem.Allocator, input: describe_account_limits.DescribeAccountLimitsInput, options: describe_account_limits.Options) !describe_account_limits.DescribeAccountLimitsOutput {
        return describe_account_limits.execute(self, allocator, input, options);
    }

    /// Describes the available adjustment types for step scaling and simple scaling
    /// policies.
    ///
    /// The following adjustment types are supported:
    ///
    /// * `ChangeInCapacity`
    ///
    /// * `ExactCapacity`
    ///
    /// * `PercentChangeInCapacity`
    pub fn describeAdjustmentTypes(self: *Self, allocator: std.mem.Allocator, input: describe_adjustment_types.DescribeAdjustmentTypesInput, options: describe_adjustment_types.Options) !describe_adjustment_types.DescribeAdjustmentTypesOutput {
        return describe_adjustment_types.execute(self, allocator, input, options);
    }

    /// Gets information about the Auto Scaling groups in the account and Region.
    ///
    /// If you specify Auto Scaling group names, the output includes information for
    /// only the
    /// specified Auto Scaling groups. If you specify filters, the output includes
    /// information for only
    /// those Auto Scaling groups that meet the filter criteria. If you do not
    /// specify group names or
    /// filters, the output includes information for all Auto Scaling groups.
    ///
    /// This operation also returns information about instances in Auto Scaling
    /// groups. To retrieve
    /// information about the instances in a warm pool, you must call the
    /// [DescribeWarmPool](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeWarmPool.html) API.
    pub fn describeAutoScalingGroups(self: *Self, allocator: std.mem.Allocator, input: describe_auto_scaling_groups.DescribeAutoScalingGroupsInput, options: describe_auto_scaling_groups.Options) !describe_auto_scaling_groups.DescribeAutoScalingGroupsOutput {
        return describe_auto_scaling_groups.execute(self, allocator, input, options);
    }

    /// Gets information about the Auto Scaling instances in the account and Region.
    pub fn describeAutoScalingInstances(self: *Self, allocator: std.mem.Allocator, input: describe_auto_scaling_instances.DescribeAutoScalingInstancesInput, options: describe_auto_scaling_instances.Options) !describe_auto_scaling_instances.DescribeAutoScalingInstancesOutput {
        return describe_auto_scaling_instances.execute(self, allocator, input, options);
    }

    /// Describes the notification types that are supported by Amazon EC2 Auto
    /// Scaling.
    pub fn describeAutoScalingNotificationTypes(self: *Self, allocator: std.mem.Allocator, input: describe_auto_scaling_notification_types.DescribeAutoScalingNotificationTypesInput, options: describe_auto_scaling_notification_types.Options) !describe_auto_scaling_notification_types.DescribeAutoScalingNotificationTypesOutput {
        return describe_auto_scaling_notification_types.execute(self, allocator, input, options);
    }

    /// Gets information about the instance refreshes for the specified Auto Scaling
    /// group from the
    /// previous six weeks.
    ///
    /// This operation is part of the [instance refresh
    /// feature](https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-instance-refresh.html) in Amazon EC2 Auto Scaling, which helps you update instances in your Auto Scaling group
    /// after you make configuration changes.
    ///
    /// To help you determine the status of an instance refresh, Amazon EC2 Auto
    /// Scaling returns information
    /// about the instance refreshes you previously initiated, including their
    /// status, start
    /// time, end time, the percentage of the instance refresh that is complete, and
    /// the number
    /// of instances remaining to update before the instance refresh is complete. If
    /// a rollback
    /// is initiated while an instance refresh is in progress, Amazon EC2 Auto
    /// Scaling also returns information
    /// about the rollback of the instance refresh.
    pub fn describeInstanceRefreshes(self: *Self, allocator: std.mem.Allocator, input: describe_instance_refreshes.DescribeInstanceRefreshesInput, options: describe_instance_refreshes.Options) !describe_instance_refreshes.DescribeInstanceRefreshesOutput {
        return describe_instance_refreshes.execute(self, allocator, input, options);
    }

    /// Gets information about the launch configurations in the account and Region.
    pub fn describeLaunchConfigurations(self: *Self, allocator: std.mem.Allocator, input: describe_launch_configurations.DescribeLaunchConfigurationsInput, options: describe_launch_configurations.Options) !describe_launch_configurations.DescribeLaunchConfigurationsOutput {
        return describe_launch_configurations.execute(self, allocator, input, options);
    }

    /// Describes the available types of lifecycle hooks.
    ///
    /// The following hook types are supported:
    ///
    /// * `autoscaling:EC2_INSTANCE_LAUNCHING`
    ///
    /// * `autoscaling:EC2_INSTANCE_TERMINATING`
    pub fn describeLifecycleHookTypes(self: *Self, allocator: std.mem.Allocator, input: describe_lifecycle_hook_types.DescribeLifecycleHookTypesInput, options: describe_lifecycle_hook_types.Options) !describe_lifecycle_hook_types.DescribeLifecycleHookTypesOutput {
        return describe_lifecycle_hook_types.execute(self, allocator, input, options);
    }

    /// Gets information about the lifecycle hooks for the specified Auto Scaling
    /// group.
    pub fn describeLifecycleHooks(self: *Self, allocator: std.mem.Allocator, input: describe_lifecycle_hooks.DescribeLifecycleHooksInput, options: describe_lifecycle_hooks.Options) !describe_lifecycle_hooks.DescribeLifecycleHooksOutput {
        return describe_lifecycle_hooks.execute(self, allocator, input, options);
    }

    /// This API operation is superseded by
    /// [DescribeTrafficSources](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeTrafficSources.html),
    /// which can describe multiple traffic sources types. We recommend using
    /// `DetachTrafficSources` to simplify how you manage traffic sources.
    /// However, we continue to support `DescribeLoadBalancerTargetGroups`. You
    /// can use both the original `DescribeLoadBalancerTargetGroups` API
    /// operation and `DescribeTrafficSources` on the same Auto Scaling group.
    ///
    /// Gets information about the Elastic Load Balancing target groups for the
    /// specified Auto Scaling group.
    ///
    /// To determine the attachment status of the target group, use the `State`
    /// element in the response. When you attach a target group to an Auto Scaling
    /// group, the initial
    /// `State` value is `Adding`. The state transitions to
    /// `Added` after all Auto Scaling instances are registered with the target
    /// group. If
    /// Elastic Load Balancing health checks are enabled for the Auto Scaling group,
    /// the state transitions to
    /// `InService` after at least one Auto Scaling instance passes the health
    /// check.
    /// When the target group is in the `InService` state, Amazon EC2 Auto Scaling
    /// can terminate and
    /// replace any instances that are reported as unhealthy. If no registered
    /// instances pass
    /// the health checks, the target group doesn't enter the `InService` state.
    ///
    /// Target groups also have an `InService` state if you attach them in the
    /// [CreateAutoScalingGroup](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_CreateAutoScalingGroup.html) API call. If your target group state is
    /// `InService`, but it is not working properly, check the scaling activities
    /// by calling
    /// [DescribeScalingActivities](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeScalingActivities.html) and take any corrective actions
    /// necessary.
    ///
    /// For help with failed health checks, see [Troubleshooting Amazon EC2 Auto
    /// Scaling:
    /// Health
    /// checks](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ts-as-healthchecks.html) in the *Amazon EC2 Auto Scaling User Guide*. For more
    /// information, see [Use Elastic Load Balancing to
    /// distribute traffic across the instances in your Auto Scaling
    /// group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-load-balancer.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// You can use this operation to describe target groups that were attached by
    /// using
    /// [AttachLoadBalancerTargetGroups](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_AttachLoadBalancerTargetGroups.html), but not for target groups that
    /// were attached by using
    /// [AttachTrafficSources](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_AttachTrafficSources.html).
    pub fn describeLoadBalancerTargetGroups(self: *Self, allocator: std.mem.Allocator, input: describe_load_balancer_target_groups.DescribeLoadBalancerTargetGroupsInput, options: describe_load_balancer_target_groups.Options) !describe_load_balancer_target_groups.DescribeLoadBalancerTargetGroupsOutput {
        return describe_load_balancer_target_groups.execute(self, allocator, input, options);
    }

    /// This API operation is superseded by
    /// [DescribeTrafficSources](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeTrafficSources.html),
    /// which can describe multiple traffic sources types. We recommend using
    /// `DescribeTrafficSources` to simplify how you manage traffic sources.
    /// However, we continue to support `DescribeLoadBalancers`. You can use both
    /// the original `DescribeLoadBalancers` API operation and
    /// `DescribeTrafficSources` on the same Auto Scaling group.
    ///
    /// Gets information about the load balancers for the specified Auto Scaling
    /// group.
    ///
    /// This operation describes only Classic Load Balancers. If you have
    /// Application Load Balancers, Network Load Balancers, or Gateway Load
    /// Balancers, use the
    /// [DescribeLoadBalancerTargetGroups](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeLoadBalancerTargetGroups.html) API instead.
    ///
    /// To determine the attachment status of the load balancer, use the `State`
    /// element in the response. When you attach a load balancer to an Auto Scaling
    /// group, the initial
    /// `State` value is `Adding`. The state transitions to
    /// `Added` after all Auto Scaling instances are registered with the load
    /// balancer.
    /// If Elastic Load Balancing health checks are enabled for the Auto Scaling
    /// group, the state transitions to
    /// `InService` after at least one Auto Scaling instance passes the health
    /// check.
    /// When the load balancer is in the `InService` state, Amazon EC2 Auto Scaling
    /// can terminate
    /// and replace any instances that are reported as unhealthy. If no registered
    /// instances
    /// pass the health checks, the load balancer doesn't enter the `InService`
    /// state.
    ///
    /// Load balancers also have an `InService` state if you attach them in the
    /// [CreateAutoScalingGroup](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_CreateAutoScalingGroup.html) API call. If your load balancer state is
    /// `InService`, but it is not working properly, check the scaling activities
    /// by calling
    /// [DescribeScalingActivities](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeScalingActivities.html) and take any corrective actions
    /// necessary.
    ///
    /// For help with failed health checks, see [Troubleshooting Amazon EC2 Auto
    /// Scaling:
    /// Health
    /// checks](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ts-as-healthchecks.html) in the *Amazon EC2 Auto Scaling User Guide*. For more
    /// information, see [Use Elastic Load Balancing to
    /// distribute traffic across the instances in your Auto Scaling
    /// group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-load-balancer.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    pub fn describeLoadBalancers(self: *Self, allocator: std.mem.Allocator, input: describe_load_balancers.DescribeLoadBalancersInput, options: describe_load_balancers.Options) !describe_load_balancers.DescribeLoadBalancersOutput {
        return describe_load_balancers.execute(self, allocator, input, options);
    }

    /// Describes the available CloudWatch metrics for Amazon EC2 Auto Scaling.
    pub fn describeMetricCollectionTypes(self: *Self, allocator: std.mem.Allocator, input: describe_metric_collection_types.DescribeMetricCollectionTypesInput, options: describe_metric_collection_types.Options) !describe_metric_collection_types.DescribeMetricCollectionTypesOutput {
        return describe_metric_collection_types.execute(self, allocator, input, options);
    }

    /// Gets information about the Amazon SNS notifications that are configured for
    /// one or more
    /// Auto Scaling groups.
    pub fn describeNotificationConfigurations(self: *Self, allocator: std.mem.Allocator, input: describe_notification_configurations.DescribeNotificationConfigurationsInput, options: describe_notification_configurations.Options) !describe_notification_configurations.DescribeNotificationConfigurationsOutput {
        return describe_notification_configurations.execute(self, allocator, input, options);
    }

    /// Gets information about the scaling policies in the account and Region.
    pub fn describePolicies(self: *Self, allocator: std.mem.Allocator, input: describe_policies.DescribePoliciesInput, options: describe_policies.Options) !describe_policies.DescribePoliciesOutput {
        return describe_policies.execute(self, allocator, input, options);
    }

    /// Gets information about the scaling activities in the account and Region.
    ///
    /// When scaling events occur, you see a record of the scaling activity in the
    /// scaling
    /// activities. For more information, see [Verify a scaling
    /// activity for an Auto Scaling
    /// group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-verify-scaling-activity.html) in the *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// If the scaling event succeeds, the value of the `StatusCode` element in the
    /// response is `Successful`. If an attempt to launch instances failed, the
    /// `StatusCode` value is `Failed` or `Cancelled` and
    /// the `StatusMessage` element in the response indicates the cause of the
    /// failure. For help interpreting the `StatusMessage`, see [Troubleshooting
    /// Amazon EC2 Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/CHAP_Troubleshooting.html) in the *Amazon EC2 Auto Scaling User Guide*.
    pub fn describeScalingActivities(self: *Self, allocator: std.mem.Allocator, input: describe_scaling_activities.DescribeScalingActivitiesInput, options: describe_scaling_activities.Options) !describe_scaling_activities.DescribeScalingActivitiesOutput {
        return describe_scaling_activities.execute(self, allocator, input, options);
    }

    /// Describes the scaling process types for use with the
    /// [ResumeProcesses](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_ResumeProcesses.html)
    /// and
    /// [SuspendProcesses](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_SuspendProcesses.html) APIs.
    pub fn describeScalingProcessTypes(self: *Self, allocator: std.mem.Allocator, input: describe_scaling_process_types.DescribeScalingProcessTypesInput, options: describe_scaling_process_types.Options) !describe_scaling_process_types.DescribeScalingProcessTypesOutput {
        return describe_scaling_process_types.execute(self, allocator, input, options);
    }

    /// Gets information about the scheduled actions that haven't run or that have
    /// not reached
    /// their end time.
    ///
    /// To describe the scaling activities for scheduled actions that have already
    /// run, call
    /// the
    /// [DescribeScalingActivities](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeScalingActivities.html) API.
    pub fn describeScheduledActions(self: *Self, allocator: std.mem.Allocator, input: describe_scheduled_actions.DescribeScheduledActionsInput, options: describe_scheduled_actions.Options) !describe_scheduled_actions.DescribeScheduledActionsOutput {
        return describe_scheduled_actions.execute(self, allocator, input, options);
    }

    /// Describes the specified tags.
    ///
    /// You can use filters to limit the results. For example, you can query for the
    /// tags for
    /// a specific Auto Scaling group. You can specify multiple values for a filter.
    /// A tag must match at
    /// least one of the specified values for it to be included in the results.
    ///
    /// You can also specify multiple filters. The result includes information for a
    /// particular tag only if it matches all the filters. If there's no match, no
    /// special
    /// message is returned.
    ///
    /// For more information, see [Tag Auto Scaling groups and
    /// instances](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-tagging.html) in the *Amazon EC2 Auto Scaling User Guide*.
    pub fn describeTags(self: *Self, allocator: std.mem.Allocator, input: describe_tags.DescribeTagsInput, options: describe_tags.Options) !describe_tags.DescribeTagsOutput {
        return describe_tags.execute(self, allocator, input, options);
    }

    /// Describes the termination policies supported by Amazon EC2 Auto Scaling.
    ///
    /// For more information, see [Configure
    /// termination policies for Amazon EC2 Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-termination-policies.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    pub fn describeTerminationPolicyTypes(self: *Self, allocator: std.mem.Allocator, input: describe_termination_policy_types.DescribeTerminationPolicyTypesInput, options: describe_termination_policy_types.Options) !describe_termination_policy_types.DescribeTerminationPolicyTypesOutput {
        return describe_termination_policy_types.execute(self, allocator, input, options);
    }

    /// Gets information about the traffic sources for the specified Auto Scaling
    /// group.
    ///
    /// You can optionally provide a traffic source type. If you provide a traffic
    /// source
    /// type, then the results only include that traffic source type.
    ///
    /// If you do not provide a traffic source type, then the results include all
    /// the traffic
    /// sources for the specified Auto Scaling group.
    pub fn describeTrafficSources(self: *Self, allocator: std.mem.Allocator, input: describe_traffic_sources.DescribeTrafficSourcesInput, options: describe_traffic_sources.Options) !describe_traffic_sources.DescribeTrafficSourcesOutput {
        return describe_traffic_sources.execute(self, allocator, input, options);
    }

    /// Gets information about a warm pool and its instances.
    ///
    /// For more information, see [Warm pools for
    /// Amazon EC2 Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-warm-pools.html) in the *Amazon EC2 Auto Scaling User Guide*.
    pub fn describeWarmPool(self: *Self, allocator: std.mem.Allocator, input: describe_warm_pool.DescribeWarmPoolInput, options: describe_warm_pool.Options) !describe_warm_pool.DescribeWarmPoolOutput {
        return describe_warm_pool.execute(self, allocator, input, options);
    }

    /// Removes one or more instances from the specified Auto Scaling group.
    ///
    /// After the instances are detached, you can manage them independent of the
    /// Auto Scaling
    /// group.
    ///
    /// If you do not specify the option to decrement the desired capacity, Amazon
    /// EC2 Auto Scaling launches
    /// instances to replace the ones that are detached.
    ///
    /// If there is a Classic Load Balancer attached to the Auto Scaling group, the
    /// instances are
    /// deregistered from the load balancer. If there are target groups attached to
    /// the Auto Scaling
    /// group, the instances are deregistered from the target groups.
    ///
    /// For more information, see [Detach
    /// or attach
    /// instances](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-detach-attach-instances.html) in the *Amazon EC2 Auto Scaling User Guide*.
    pub fn detachInstances(self: *Self, allocator: std.mem.Allocator, input: detach_instances.DetachInstancesInput, options: detach_instances.Options) !detach_instances.DetachInstancesOutput {
        return detach_instances.execute(self, allocator, input, options);
    }

    /// This API operation is superseded by
    /// [DetachTrafficSources](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DetachTrafficSources.html), which
    /// can detach multiple traffic sources types. We recommend using
    /// `DetachTrafficSources` to simplify how you manage traffic sources.
    /// However, we continue to support `DetachLoadBalancerTargetGroups`. You can
    /// use both the original `DetachLoadBalancerTargetGroups` API operation and
    /// `DetachTrafficSources` on the same Auto Scaling group.
    ///
    /// Detaches one or more target groups from the specified Auto Scaling group.
    ///
    /// When you detach a target group, it enters the `Removing` state while
    /// deregistering the instances in the group. When all instances are
    /// deregistered, then you
    /// can no longer describe the target group using the
    /// [DescribeLoadBalancerTargetGroups](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeLoadBalancerTargetGroups.html)
    /// API call. The instances remain running.
    ///
    /// You can use this operation to detach target groups that were attached by
    /// using
    /// [AttachLoadBalancerTargetGroups](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_AttachLoadBalancerTargetGroups.html), but not for target groups that
    /// were attached by using
    /// [AttachTrafficSources](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_AttachTrafficSources.html).
    pub fn detachLoadBalancerTargetGroups(self: *Self, allocator: std.mem.Allocator, input: detach_load_balancer_target_groups.DetachLoadBalancerTargetGroupsInput, options: detach_load_balancer_target_groups.Options) !detach_load_balancer_target_groups.DetachLoadBalancerTargetGroupsOutput {
        return detach_load_balancer_target_groups.execute(self, allocator, input, options);
    }

    /// This API operation is superseded by
    /// [DetachTrafficSources](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DetachTrafficSources.html), which
    /// can detach multiple traffic sources types. We recommend using
    /// `DetachTrafficSources` to simplify how you manage traffic sources.
    /// However, we continue to support `DetachLoadBalancers`. You can use both
    /// the original `DetachLoadBalancers` API operation and
    /// `DetachTrafficSources` on the same Auto Scaling group.
    ///
    /// Detaches one or more Classic Load Balancers from the specified Auto Scaling
    /// group.
    ///
    /// This operation detaches only Classic Load Balancers. If you have Application
    /// Load Balancers, Network Load Balancers, or
    /// Gateway Load Balancers, use the
    /// [DetachLoadBalancerTargetGroups](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DetachLoadBalancerTargetGroups.html) API instead.
    ///
    /// When you detach a load balancer, it enters the `Removing` state while
    /// deregistering the instances in the group. When all instances are
    /// deregistered, then you
    /// can no longer describe the load balancer using the
    /// [DescribeLoadBalancers](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeLoadBalancers.html)
    /// API call. The instances remain running.
    pub fn detachLoadBalancers(self: *Self, allocator: std.mem.Allocator, input: detach_load_balancers.DetachLoadBalancersInput, options: detach_load_balancers.Options) !detach_load_balancers.DetachLoadBalancersOutput {
        return detach_load_balancers.execute(self, allocator, input, options);
    }

    /// Detaches one or more traffic sources from the specified Auto Scaling group.
    ///
    /// When you detach a traffic source, it enters the `Removing` state while
    /// deregistering the instances in the group. When all instances are
    /// deregistered, then you
    /// can no longer describe the traffic source using the
    /// [DescribeTrafficSources](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeTrafficSources.html)
    /// API call. The instances continue to run.
    pub fn detachTrafficSources(self: *Self, allocator: std.mem.Allocator, input: detach_traffic_sources.DetachTrafficSourcesInput, options: detach_traffic_sources.Options) !detach_traffic_sources.DetachTrafficSourcesOutput {
        return detach_traffic_sources.execute(self, allocator, input, options);
    }

    /// Disables group metrics collection for the specified Auto Scaling group.
    pub fn disableMetricsCollection(self: *Self, allocator: std.mem.Allocator, input: disable_metrics_collection.DisableMetricsCollectionInput, options: disable_metrics_collection.Options) !disable_metrics_collection.DisableMetricsCollectionOutput {
        return disable_metrics_collection.execute(self, allocator, input, options);
    }

    /// Enables group metrics collection for the specified Auto Scaling group.
    ///
    /// You can use these metrics to track changes in an Auto Scaling group and to
    /// set alarms on
    /// threshold values. You can view group metrics using the Amazon EC2 Auto
    /// Scaling console or the CloudWatch
    /// console. For more information, see [Monitor
    /// CloudWatch metrics for your Auto Scaling groups and
    /// instances](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-cloudwatch-monitoring.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    pub fn enableMetricsCollection(self: *Self, allocator: std.mem.Allocator, input: enable_metrics_collection.EnableMetricsCollectionInput, options: enable_metrics_collection.Options) !enable_metrics_collection.EnableMetricsCollectionOutput {
        return enable_metrics_collection.execute(self, allocator, input, options);
    }

    /// Moves the specified instances into the standby state.
    ///
    /// If you choose to decrement the desired capacity of the Auto Scaling group,
    /// the instances can
    /// enter standby as long as the desired capacity of the Auto Scaling group
    /// after the instances are
    /// placed into standby is equal to or greater than the minimum capacity of the
    /// group.
    ///
    /// If you choose not to decrement the desired capacity of the Auto Scaling
    /// group, the Auto Scaling group
    /// launches new instances to replace the instances on standby.
    ///
    /// For more information, see [Temporarily removing
    /// instances from your Auto Scaling
    /// group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-enter-exit-standby.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    pub fn enterStandby(self: *Self, allocator: std.mem.Allocator, input: enter_standby.EnterStandbyInput, options: enter_standby.Options) !enter_standby.EnterStandbyOutput {
        return enter_standby.execute(self, allocator, input, options);
    }

    /// Executes the specified policy. This can be useful for testing the design of
    /// your
    /// scaling policy.
    pub fn executePolicy(self: *Self, allocator: std.mem.Allocator, input: execute_policy.ExecutePolicyInput, options: execute_policy.Options) !execute_policy.ExecutePolicyOutput {
        return execute_policy.execute(self, allocator, input, options);
    }

    /// Moves the specified instances out of the standby state.
    ///
    /// After you put the instances back in service, the desired capacity is
    /// incremented.
    ///
    /// For more information, see [Temporarily removing
    /// instances from your Auto Scaling
    /// group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-enter-exit-standby.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    pub fn exitStandby(self: *Self, allocator: std.mem.Allocator, input: exit_standby.ExitStandbyInput, options: exit_standby.Options) !exit_standby.ExitStandbyOutput {
        return exit_standby.execute(self, allocator, input, options);
    }

    /// Retrieves the forecast data for a predictive scaling policy.
    ///
    /// Load forecasts are predictions of the hourly load values using historical
    /// load data
    /// from CloudWatch and an analysis of historical trends. Capacity forecasts are
    /// represented as
    /// predicted values for the minimum capacity that is needed on an hourly basis,
    /// based on
    /// the hourly load forecast.
    ///
    /// A minimum of 24 hours of data is required to create the initial forecasts.
    /// However,
    /// having a full 14 days of historical data results in more accurate forecasts.
    ///
    /// For more information, see [Predictive
    /// scaling for Amazon EC2 Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-predictive-scaling.html) in the *Amazon EC2 Auto Scaling User Guide*.
    pub fn getPredictiveScalingForecast(self: *Self, allocator: std.mem.Allocator, input: get_predictive_scaling_forecast.GetPredictiveScalingForecastInput, options: get_predictive_scaling_forecast.Options) !get_predictive_scaling_forecast.GetPredictiveScalingForecastOutput {
        return get_predictive_scaling_forecast.execute(self, allocator, input, options);
    }

    /// Launches a specified number of instances in an Auto Scaling group. Returns
    /// instance IDs and
    /// other details if launch is successful or error details if launch is
    /// unsuccessful.
    pub fn launchInstances(self: *Self, allocator: std.mem.Allocator, input: launch_instances.LaunchInstancesInput, options: launch_instances.Options) !launch_instances.LaunchInstancesOutput {
        return launch_instances.execute(self, allocator, input, options);
    }

    /// Creates or updates a lifecycle hook for the specified Auto Scaling group.
    ///
    /// Lifecycle hooks let you create solutions that are aware of events in the
    /// Auto Scaling instance
    /// lifecycle, and then perform a custom action on instances when the
    /// corresponding
    /// lifecycle event occurs.
    ///
    /// This step is a part of the procedure for adding a lifecycle hook to an Auto
    /// Scaling
    /// group:
    ///
    /// * (Optional) Create a launch template or launch configuration with a user
    ///   data
    /// script that runs while an instance is in a wait state due to a lifecycle
    /// hook.
    ///
    /// * (Optional) Create a Lambda function and a rule that allows Amazon
    ///   EventBridge to invoke
    /// your Lambda function when an instance is put into a wait state due to a
    /// lifecycle hook.
    ///
    /// * (Optional) Create a notification target and an IAM role. The target can be
    /// either an Amazon SQS queue or an Amazon SNS topic. The role allows Amazon
    /// EC2 Auto Scaling to publish
    /// lifecycle notifications to the target.
    ///
    /// * **Create the lifecycle hook. Specify whether the hook is
    /// used when the instances launch or terminate.**
    ///
    /// * If you need more time, record the lifecycle action heartbeat to keep the
    /// instance in a wait state using the
    /// [RecordLifecycleActionHeartbeat](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_RecordLifecycleActionHeartbeat.html) API call.
    ///
    /// * If you finish before the timeout period ends, send a callback by using the
    /// [CompleteLifecycleAction](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_CompleteLifecycleAction.html) API call.
    ///
    /// For more information, see [Amazon EC2 Auto Scaling lifecycle
    /// hooks](https://docs.aws.amazon.com/autoscaling/ec2/userguide/lifecycle-hooks.html) in the *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// If you exceed your maximum limit of lifecycle hooks, which by default is 50
    /// per Auto Scaling
    /// group, the call fails.
    ///
    /// You can view the lifecycle hooks for an Auto Scaling group using the
    /// [DescribeLifecycleHooks](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeLifecycleHooks.html) API call. If you are no longer using a lifecycle
    /// hook, you can delete it by calling the
    /// [DeleteLifecycleHook](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DeleteLifecycleHook.html) API.
    pub fn putLifecycleHook(self: *Self, allocator: std.mem.Allocator, input: put_lifecycle_hook.PutLifecycleHookInput, options: put_lifecycle_hook.Options) !put_lifecycle_hook.PutLifecycleHookOutput {
        return put_lifecycle_hook.execute(self, allocator, input, options);
    }

    /// Configures an Auto Scaling group to send notifications when specified events
    /// take place.
    /// Subscribers to the specified topic can have messages delivered to an
    /// endpoint such as a
    /// web server or an email address.
    ///
    /// This configuration overwrites any existing configuration.
    ///
    /// For more information, see [Amazon SNS
    /// notification options for Amazon EC2 Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-sns-notifications.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// If you exceed your maximum limit of SNS topics, which is 10 per Auto Scaling
    /// group, the call
    /// fails.
    pub fn putNotificationConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_notification_configuration.PutNotificationConfigurationInput, options: put_notification_configuration.Options) !put_notification_configuration.PutNotificationConfigurationOutput {
        return put_notification_configuration.execute(self, allocator, input, options);
    }

    /// Creates or updates a scaling policy for an Auto Scaling group. Scaling
    /// policies are used to
    /// scale an Auto Scaling group based on configurable metrics. If no policies
    /// are defined, the
    /// dynamic scaling and predictive scaling features are not used.
    ///
    /// For more information about using dynamic scaling, see [Target tracking
    /// scaling
    /// policies](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-scaling-target-tracking.html) and [Step and simple scaling
    /// policies](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-scaling-simple-step.html) in the *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// For more information about using predictive scaling, see [Predictive
    /// scaling for Amazon EC2 Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-predictive-scaling.html) in the *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// You can view the scaling policies for an Auto Scaling group using the
    /// [DescribePolicies](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribePolicies.html) API call. If you are no longer using a scaling policy,
    /// you can delete it by calling the
    /// [DeletePolicy](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DeletePolicy.html) API.
    pub fn putScalingPolicy(self: *Self, allocator: std.mem.Allocator, input: put_scaling_policy.PutScalingPolicyInput, options: put_scaling_policy.Options) !put_scaling_policy.PutScalingPolicyOutput {
        return put_scaling_policy.execute(self, allocator, input, options);
    }

    /// Creates or updates a scheduled scaling action for an Auto Scaling group.
    ///
    /// For more information, see [Scheduled
    /// scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-scheduled-scaling.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// You can view the scheduled actions for an Auto Scaling group using the
    /// [DescribeScheduledActions](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeScheduledActions.html)
    /// API call. If you are no longer using a scheduled action, you can delete it
    /// by calling the
    /// [DeleteScheduledAction](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DeleteScheduledAction.html) API.
    ///
    /// If you try to schedule your action in the past, Amazon EC2 Auto Scaling
    /// returns an error
    /// message.
    pub fn putScheduledUpdateGroupAction(self: *Self, allocator: std.mem.Allocator, input: put_scheduled_update_group_action.PutScheduledUpdateGroupActionInput, options: put_scheduled_update_group_action.Options) !put_scheduled_update_group_action.PutScheduledUpdateGroupActionOutput {
        return put_scheduled_update_group_action.execute(self, allocator, input, options);
    }

    /// Creates or updates a warm pool for the specified Auto Scaling group. A warm
    /// pool is a pool of
    /// pre-initialized EC2 instances that sits alongside the Auto Scaling group.
    /// Whenever your
    /// application needs to scale out, the Auto Scaling group can draw on the warm
    /// pool to meet its new
    /// desired capacity.
    ///
    /// This operation must be called from the Region in which the Auto Scaling
    /// group was
    /// created.
    ///
    /// You can view the instances in the warm pool using the
    /// [DescribeWarmPool](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeWarmPool.html) API call.
    /// If you are no longer using a warm pool, you can delete it by calling the
    /// [DeleteWarmPool](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DeleteWarmPool.html) API.
    ///
    /// For more information, see [Warm pools for
    /// Amazon EC2 Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-warm-pools.html) in the *Amazon EC2 Auto Scaling User Guide*.
    pub fn putWarmPool(self: *Self, allocator: std.mem.Allocator, input: put_warm_pool.PutWarmPoolInput, options: put_warm_pool.Options) !put_warm_pool.PutWarmPoolOutput {
        return put_warm_pool.execute(self, allocator, input, options);
    }

    /// Records a heartbeat for the lifecycle action associated with the specified
    /// token or
    /// instance. This extends the timeout by the length of time defined using the
    /// [PutLifecycleHook](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_PutLifecycleHook.html) API call.
    ///
    /// This step is a part of the procedure for adding a lifecycle hook to an Auto
    /// Scaling
    /// group:
    ///
    /// * (Optional) Create a launch template or launch configuration with a user
    ///   data
    /// script that runs while an instance is in a wait state due to a lifecycle
    /// hook.
    ///
    /// * (Optional) Create a Lambda function and a rule that allows Amazon
    ///   EventBridge to invoke
    /// your Lambda function when an instance is put into a wait state due to a
    /// lifecycle hook.
    ///
    /// * (Optional) Create a notification target and an IAM role. The target can be
    /// either an Amazon SQS queue or an Amazon SNS topic. The role allows Amazon
    /// EC2 Auto Scaling to publish
    /// lifecycle notifications to the target.
    ///
    /// * Create the lifecycle hook. Specify whether the hook is used when the
    ///   instances
    /// launch or terminate.
    ///
    /// * **If you need more time, record the lifecycle action
    /// heartbeat to keep the instance in a wait state.**
    ///
    /// * If you finish before the timeout period ends, send a callback by using the
    /// [CompleteLifecycleAction](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_CompleteLifecycleAction.html) API call.
    ///
    /// For more information, see [Amazon EC2 Auto Scaling lifecycle
    /// hooks](https://docs.aws.amazon.com/autoscaling/ec2/userguide/lifecycle-hooks.html) in the *Amazon EC2 Auto Scaling User Guide*.
    pub fn recordLifecycleActionHeartbeat(self: *Self, allocator: std.mem.Allocator, input: record_lifecycle_action_heartbeat.RecordLifecycleActionHeartbeatInput, options: record_lifecycle_action_heartbeat.Options) !record_lifecycle_action_heartbeat.RecordLifecycleActionHeartbeatOutput {
        return record_lifecycle_action_heartbeat.execute(self, allocator, input, options);
    }

    /// Resumes the specified suspended auto scaling processes, or all suspended
    /// process, for
    /// the specified Auto Scaling group.
    ///
    /// For more information, see [Suspend and resume
    /// Amazon EC2 Auto Scaling
    /// processes](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-suspend-resume-processes.html) in the *Amazon EC2 Auto Scaling User Guide*.
    pub fn resumeProcesses(self: *Self, allocator: std.mem.Allocator, input: resume_processes.ResumeProcessesInput, options: resume_processes.Options) !resume_processes.ResumeProcessesOutput {
        return resume_processes.execute(self, allocator, input, options);
    }

    /// Cancels an instance refresh that is in progress and rolls back any changes
    /// that it
    /// made. Amazon EC2 Auto Scaling replaces any instances that were replaced
    /// during the instance refresh.
    /// This restores your Auto Scaling group to the configuration that it was using
    /// before the start of
    /// the instance refresh.
    ///
    /// This operation is part of the [instance refresh
    /// feature](https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-instance-refresh.html) in Amazon EC2 Auto Scaling, which helps you update instances in your Auto Scaling group
    /// after you make configuration changes.
    ///
    /// A rollback is not supported in the following situations:
    ///
    /// * There is no desired configuration specified for the instance refresh.
    ///
    /// * The Auto Scaling group has a launch template that uses an Amazon Web
    ///   Services Systems Manager parameter instead
    /// of an AMI ID for the `ImageId` property.
    ///
    /// * The Auto Scaling group uses the launch template's `$Latest` or
    /// `$Default` version.
    ///
    /// When you receive a successful response from this operation, Amazon EC2 Auto
    /// Scaling immediately
    /// begins replacing instances. You can check the status of this operation
    /// through the
    /// [DescribeInstanceRefreshes](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeInstanceRefreshes.html) API operation.
    pub fn rollbackInstanceRefresh(self: *Self, allocator: std.mem.Allocator, input: rollback_instance_refresh.RollbackInstanceRefreshInput, options: rollback_instance_refresh.Options) !rollback_instance_refresh.RollbackInstanceRefreshOutput {
        return rollback_instance_refresh.execute(self, allocator, input, options);
    }

    /// Sets the size of the specified Auto Scaling group.
    ///
    /// If a scale-in activity occurs as a result of a new `DesiredCapacity` value
    /// that is lower than the current size of the group, the Auto Scaling group
    /// uses its termination
    /// policy to determine which instances to terminate.
    ///
    /// For more information, see [Manual
    /// scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-scaling-manually.html) in the *Amazon EC2 Auto Scaling User Guide*.
    pub fn setDesiredCapacity(self: *Self, allocator: std.mem.Allocator, input: set_desired_capacity.SetDesiredCapacityInput, options: set_desired_capacity.Options) !set_desired_capacity.SetDesiredCapacityOutput {
        return set_desired_capacity.execute(self, allocator, input, options);
    }

    /// Sets the health status of the specified instance.
    ///
    /// For more information, see [Set up a custom
    /// health check for your Auto Scaling
    /// group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/set-up-a-custom-health-check.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    pub fn setInstanceHealth(self: *Self, allocator: std.mem.Allocator, input: set_instance_health.SetInstanceHealthInput, options: set_instance_health.Options) !set_instance_health.SetInstanceHealthOutput {
        return set_instance_health.execute(self, allocator, input, options);
    }

    /// Updates the instance protection settings of the specified instances. This
    /// operation
    /// cannot be called on instances in a warm pool.
    ///
    /// For more information, see [Use
    /// instance scale-in
    /// protection](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-instance-protection.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// If you exceed your maximum limit of instance IDs, which is 50 per Auto
    /// Scaling group, the call
    /// fails.
    pub fn setInstanceProtection(self: *Self, allocator: std.mem.Allocator, input: set_instance_protection.SetInstanceProtectionInput, options: set_instance_protection.Options) !set_instance_protection.SetInstanceProtectionOutput {
        return set_instance_protection.execute(self, allocator, input, options);
    }

    /// Starts an instance refresh.
    ///
    /// This operation is part of the [instance refresh
    /// feature](https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-instance-refresh.html) in Amazon EC2 Auto Scaling, which helps you update instances in your Auto Scaling group.
    /// This feature is helpful, for example, when you have a new AMI or a new user
    /// data script.
    /// You just need to create a new launch template that specifies the new AMI or
    /// user data
    /// script. Then start an instance refresh to immediately begin the process of
    /// updating
    /// instances in the group.
    ///
    /// If successful, the request's response contains a unique ID that you can use
    /// to track
    /// the progress of the instance refresh. To query its status, call the
    /// [DescribeInstanceRefreshes](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeInstanceRefreshes.html) API.
    /// To describe the instance refreshes that
    /// have already run, call the
    /// [DescribeInstanceRefreshes](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeInstanceRefreshes.html) API. To cancel an
    /// instance refresh that is in progress, use the
    /// [CancelInstanceRefresh](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_CancelInstanceRefresh.html)
    /// API.
    ///
    /// An instance refresh might fail for several reasons, such as EC2 launch
    /// failures,
    /// misconfigured health checks, or not ignoring or allowing the termination of
    /// instances
    /// that are in `Standby` state or protected from scale in. You can monitor for
    /// failed EC2 launches using the scaling activities. To find the scaling
    /// activities, call
    /// the
    /// [DescribeScalingActivities](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeScalingActivities.html) API.
    ///
    /// If you enable auto rollback, your Auto Scaling group will be rolled back
    /// automatically when
    /// the instance refresh fails. You can enable this feature before starting an
    /// instance
    /// refresh by specifying the `AutoRollback` property in the instance refresh
    /// preferences. Otherwise, to roll back an instance refresh before it finishes,
    /// use the
    /// [RollbackInstanceRefresh](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_RollbackInstanceRefresh.html) API.
    pub fn startInstanceRefresh(self: *Self, allocator: std.mem.Allocator, input: start_instance_refresh.StartInstanceRefreshInput, options: start_instance_refresh.Options) !start_instance_refresh.StartInstanceRefreshOutput {
        return start_instance_refresh.execute(self, allocator, input, options);
    }

    /// Suspends the specified auto scaling processes, or all processes, for the
    /// specified
    /// Auto Scaling group.
    ///
    /// If you suspend either the `Launch` or `Terminate` process types,
    /// it can prevent other process types from functioning properly. For more
    /// information, see
    /// [Suspend and resume
    /// Amazon EC2 Auto Scaling
    /// processes](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-suspend-resume-processes.html) in the *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// To resume processes that have been suspended, call the
    /// [ResumeProcesses](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_ResumeProcesses.html) API.
    pub fn suspendProcesses(self: *Self, allocator: std.mem.Allocator, input: suspend_processes.SuspendProcessesInput, options: suspend_processes.Options) !suspend_processes.SuspendProcessesOutput {
        return suspend_processes.execute(self, allocator, input, options);
    }

    /// Terminates the specified instance and optionally adjusts the desired group
    /// size. This
    /// operation cannot be called on instances in a warm pool.
    ///
    /// This call simply makes a termination request. The instance is not terminated
    /// immediately. When an instance is terminated, the instance status changes to
    /// `terminated`. You can't connect to or start an instance after you've
    /// terminated it.
    ///
    /// If you do not specify the option to decrement the desired capacity, Amazon
    /// EC2 Auto Scaling launches
    /// instances to replace the ones that are terminated.
    ///
    /// By default, Amazon EC2 Auto Scaling balances instances across all
    /// Availability Zones. If you
    /// decrement the desired capacity, your Auto Scaling group can become
    /// unbalanced between
    /// Availability Zones. Amazon EC2 Auto Scaling tries to rebalance the group,
    /// and rebalancing might
    /// terminate instances in other zones. For more information, see [Manual
    /// scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-scaling-manually.html) in the *Amazon EC2 Auto Scaling User Guide*.
    pub fn terminateInstanceInAutoScalingGroup(self: *Self, allocator: std.mem.Allocator, input: terminate_instance_in_auto_scaling_group.TerminateInstanceInAutoScalingGroupInput, options: terminate_instance_in_auto_scaling_group.Options) !terminate_instance_in_auto_scaling_group.TerminateInstanceInAutoScalingGroupOutput {
        return terminate_instance_in_auto_scaling_group.execute(self, allocator, input, options);
    }

    /// **We strongly recommend that all Auto Scaling groups use launch templates to
    /// ensure full functionality for Amazon EC2 Auto Scaling and Amazon EC2.**
    ///
    /// Updates the configuration for the specified Auto Scaling group.
    ///
    /// To update an Auto Scaling group, specify the name of the group and the
    /// property that you want
    /// to change. Any properties that you don't specify are not changed by this
    /// update request.
    /// The new settings take effect on any scaling activities after this call
    /// returns.
    ///
    /// If you associate a new launch configuration or template with an Auto Scaling
    /// group, all new
    /// instances will get the updated configuration. Existing instances continue to
    /// run with
    /// the configuration that they were originally launched with. When you update a
    /// group to
    /// specify a mixed instances policy instead of a launch configuration or
    /// template, existing
    /// instances may be replaced to match the new purchasing options that you
    /// specified in the
    /// policy. For example, if the group currently has 100% On-Demand capacity and
    /// the policy
    /// specifies 50% Spot capacity, this means that half of your instances will be
    /// gradually
    /// terminated and relaunched as Spot Instances. When replacing instances,
    /// Amazon EC2 Auto Scaling launches
    /// new instances before terminating the old ones, so that updating your group
    /// does not
    /// compromise the performance or availability of your application.
    ///
    /// Note the following about changing `DesiredCapacity`, `MaxSize`,
    /// or `MinSize`:
    ///
    /// * If a scale-in activity occurs as a result of a new
    /// `DesiredCapacity` value that is lower than the current size of
    /// the group, the Auto Scaling group uses its termination policy to determine
    /// which
    /// instances to terminate.
    ///
    /// * If you specify a new value for `MinSize` without specifying a value
    /// for `DesiredCapacity`, and the new `MinSize` is larger
    /// than the current size of the group, this sets the group's
    /// `DesiredCapacity` to the new `MinSize` value.
    ///
    /// * If you specify a new value for `MaxSize` without specifying a value
    /// for `DesiredCapacity`, and the new `MaxSize` is smaller
    /// than the current size of the group, this sets the group's
    /// `DesiredCapacity` to the new `MaxSize` value.
    ///
    /// To see which properties have been set, call the
    /// [DescribeAutoScalingGroups](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeAutoScalingGroups.html) API.
    /// To view the scaling policies for an Auto Scaling
    /// group, call the
    /// [DescribePolicies](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribePolicies.html) API. If the group has scaling
    /// policies, you can update them by calling the
    /// [PutScalingPolicy](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_PutScalingPolicy.html) API.
    pub fn updateAutoScalingGroup(self: *Self, allocator: std.mem.Allocator, input: update_auto_scaling_group.UpdateAutoScalingGroupInput, options: update_auto_scaling_group.Options) !update_auto_scaling_group.UpdateAutoScalingGroupOutput {
        return update_auto_scaling_group.execute(self, allocator, input, options);
    }

    pub fn describeAutoScalingGroupsPaginator(self: *Self, params: describe_auto_scaling_groups.DescribeAutoScalingGroupsInput) paginator.DescribeAutoScalingGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeAutoScalingInstancesPaginator(self: *Self, params: describe_auto_scaling_instances.DescribeAutoScalingInstancesInput) paginator.DescribeAutoScalingInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInstanceRefreshesPaginator(self: *Self, params: describe_instance_refreshes.DescribeInstanceRefreshesInput) paginator.DescribeInstanceRefreshesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeLaunchConfigurationsPaginator(self: *Self, params: describe_launch_configurations.DescribeLaunchConfigurationsInput) paginator.DescribeLaunchConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeLoadBalancerTargetGroupsPaginator(self: *Self, params: describe_load_balancer_target_groups.DescribeLoadBalancerTargetGroupsInput) paginator.DescribeLoadBalancerTargetGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeLoadBalancersPaginator(self: *Self, params: describe_load_balancers.DescribeLoadBalancersInput) paginator.DescribeLoadBalancersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeNotificationConfigurationsPaginator(self: *Self, params: describe_notification_configurations.DescribeNotificationConfigurationsInput) paginator.DescribeNotificationConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describePoliciesPaginator(self: *Self, params: describe_policies.DescribePoliciesInput) paginator.DescribePoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeScalingActivitiesPaginator(self: *Self, params: describe_scaling_activities.DescribeScalingActivitiesInput) paginator.DescribeScalingActivitiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeScheduledActionsPaginator(self: *Self, params: describe_scheduled_actions.DescribeScheduledActionsInput) paginator.DescribeScheduledActionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTagsPaginator(self: *Self, params: describe_tags.DescribeTagsInput) paginator.DescribeTagsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTrafficSourcesPaginator(self: *Self, params: describe_traffic_sources.DescribeTrafficSourcesInput) paginator.DescribeTrafficSourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeWarmPoolPaginator(self: *Self, params: describe_warm_pool.DescribeWarmPoolInput) paginator.DescribeWarmPoolPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
