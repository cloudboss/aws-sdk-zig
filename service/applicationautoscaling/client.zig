const aws = @import("aws");
const std = @import("std");

const delete_scaling_policy = @import("delete_scaling_policy.zig");
const delete_scheduled_action = @import("delete_scheduled_action.zig");
const deregister_scalable_target = @import("deregister_scalable_target.zig");
const describe_scalable_targets = @import("describe_scalable_targets.zig");
const describe_scaling_activities = @import("describe_scaling_activities.zig");
const describe_scaling_policies = @import("describe_scaling_policies.zig");
const describe_scheduled_actions = @import("describe_scheduled_actions.zig");
const get_predictive_scaling_forecast = @import("get_predictive_scaling_forecast.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_scaling_policy = @import("put_scaling_policy.zig");
const put_scheduled_action = @import("put_scheduled_action.zig");
const register_scalable_target = @import("register_scalable_target.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Application Auto Scaling";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Deletes the specified scaling policy for an Application Auto Scaling
    /// scalable target.
    ///
    /// Deleting a step scaling policy deletes the underlying alarm action, but does
    /// not delete
    /// the CloudWatch alarm associated with the scaling policy, even if it no
    /// longer has an associated
    /// action.
    ///
    /// For more information, see [Delete a step scaling
    /// policy](https://docs.aws.amazon.com/autoscaling/application/userguide/create-step-scaling-policy-cli.html#delete-step-scaling-policy) and [Delete a target tracking scaling policy](https://docs.aws.amazon.com/autoscaling/application/userguide/create-target-tracking-policy-cli.html#delete-target-tracking-policy) in the
    /// *Application Auto Scaling User Guide*.
    pub fn deleteScalingPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_scaling_policy.DeleteScalingPolicyInput, options: delete_scaling_policy.Options) !delete_scaling_policy.DeleteScalingPolicyOutput {
        return delete_scaling_policy.execute(self, allocator, input, options);
    }

    /// Deletes the specified scheduled action for an Application Auto Scaling
    /// scalable target.
    ///
    /// For more information, see [Delete a scheduled
    /// action](https://docs.aws.amazon.com/autoscaling/application/userguide/scheduled-scaling-additional-cli-commands.html#delete-scheduled-action) in the *Application Auto Scaling User Guide*.
    pub fn deleteScheduledAction(self: *Self, allocator: std.mem.Allocator, input: delete_scheduled_action.DeleteScheduledActionInput, options: delete_scheduled_action.Options) !delete_scheduled_action.DeleteScheduledActionOutput {
        return delete_scheduled_action.execute(self, allocator, input, options);
    }

    /// Deregisters an Application Auto Scaling scalable target when you have
    /// finished using it. To see which
    /// resources have been registered, use
    /// [DescribeScalableTargets](https://docs.aws.amazon.com/autoscaling/application/APIReference/API_DescribeScalableTargets.html).
    ///
    /// Deregistering a scalable target deletes the scaling policies and the
    /// scheduled
    /// actions that are associated with it.
    pub fn deregisterScalableTarget(self: *Self, allocator: std.mem.Allocator, input: deregister_scalable_target.DeregisterScalableTargetInput, options: deregister_scalable_target.Options) !deregister_scalable_target.DeregisterScalableTargetOutput {
        return deregister_scalable_target.execute(self, allocator, input, options);
    }

    /// Gets information about the scalable targets in the specified namespace.
    ///
    /// You can filter the results using `ResourceIds` and
    /// `ScalableDimension`.
    pub fn describeScalableTargets(self: *Self, allocator: std.mem.Allocator, input: describe_scalable_targets.DescribeScalableTargetsInput, options: describe_scalable_targets.Options) !describe_scalable_targets.DescribeScalableTargetsOutput {
        return describe_scalable_targets.execute(self, allocator, input, options);
    }

    /// Provides descriptive information about the scaling activities in the
    /// specified namespace
    /// from the previous six weeks.
    ///
    /// You can filter the results using `ResourceId` and
    /// `ScalableDimension`.
    ///
    /// For information about viewing scaling activities using the Amazon Web
    /// Services CLI, see [Scaling activities for Application Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/application/userguide/application-auto-scaling-scaling-activities.html).
    pub fn describeScalingActivities(self: *Self, allocator: std.mem.Allocator, input: describe_scaling_activities.DescribeScalingActivitiesInput, options: describe_scaling_activities.Options) !describe_scaling_activities.DescribeScalingActivitiesOutput {
        return describe_scaling_activities.execute(self, allocator, input, options);
    }

    /// Describes the Application Auto Scaling scaling policies for the specified
    /// service namespace.
    ///
    /// You can filter the results using `ResourceId`,
    /// `ScalableDimension`, and `PolicyNames`.
    ///
    /// For more information, see [Target tracking scaling
    /// policies](https://docs.aws.amazon.com/autoscaling/application/userguide/application-auto-scaling-target-tracking.html) and [Step scaling policies](https://docs.aws.amazon.com/autoscaling/application/userguide/application-auto-scaling-step-scaling-policies.html) in the *Application Auto Scaling User Guide*.
    pub fn describeScalingPolicies(self: *Self, allocator: std.mem.Allocator, input: describe_scaling_policies.DescribeScalingPoliciesInput, options: describe_scaling_policies.Options) !describe_scaling_policies.DescribeScalingPoliciesOutput {
        return describe_scaling_policies.execute(self, allocator, input, options);
    }

    /// Describes the Application Auto Scaling scheduled actions for the specified
    /// service namespace.
    ///
    /// You can filter the results using the `ResourceId`,
    /// `ScalableDimension`, and `ScheduledActionNames` parameters.
    ///
    /// For more information, see [Scheduled
    /// scaling](https://docs.aws.amazon.com/autoscaling/application/userguide/application-auto-scaling-scheduled-scaling.html) in the *Application Auto Scaling User Guide*.
    pub fn describeScheduledActions(self: *Self, allocator: std.mem.Allocator, input: describe_scheduled_actions.DescribeScheduledActionsInput, options: describe_scheduled_actions.Options) !describe_scheduled_actions.DescribeScheduledActionsOutput {
        return describe_scheduled_actions.execute(self, allocator, input, options);
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
    pub fn getPredictiveScalingForecast(self: *Self, allocator: std.mem.Allocator, input: get_predictive_scaling_forecast.GetPredictiveScalingForecastInput, options: get_predictive_scaling_forecast.Options) !get_predictive_scaling_forecast.GetPredictiveScalingForecastOutput {
        return get_predictive_scaling_forecast.execute(self, allocator, input, options);
    }

    /// Returns all the tags on the specified Application Auto Scaling scalable
    /// target.
    ///
    /// For general information about tags, including the format and syntax, see
    /// [Tagging your Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the *Amazon Web Services General Reference*.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates or updates a scaling policy for an Application Auto Scaling scalable
    /// target.
    ///
    /// Each scalable target is identified by a service namespace, resource ID, and
    /// scalable
    /// dimension. A scaling policy applies to the scalable target identified by
    /// those three
    /// attributes. You cannot create a scaling policy until you have registered the
    /// resource as a
    /// scalable target.
    ///
    /// Multiple scaling policies can be in force at the same time for the same
    /// scalable target.
    /// You can have one or more target tracking scaling policies, one or more step
    /// scaling
    /// policies, or both. However, there is a chance that multiple policies could
    /// conflict,
    /// instructing the scalable target to scale out or in at the same time.
    /// Application Auto Scaling gives
    /// precedence to the policy that provides the largest capacity for both scale
    /// out and scale
    /// in. For example, if one policy increases capacity by 3, another policy
    /// increases capacity
    /// by 200 percent, and the current capacity is 10, Application Auto Scaling
    /// uses the policy with the highest
    /// calculated capacity (200% of 10 = 20) and scales out to 30.
    ///
    /// We recommend caution, however, when using target tracking scaling policies
    /// with step
    /// scaling policies because conflicts between these policies can cause
    /// undesirable behavior.
    /// For example, if the step scaling policy initiates a scale-in activity before
    /// the target
    /// tracking policy is ready to scale in, the scale-in activity will not be
    /// blocked. After the
    /// scale-in activity completes, the target tracking policy could instruct the
    /// scalable target
    /// to scale out again.
    ///
    /// For more information, see [Target tracking scaling
    /// policies](https://docs.aws.amazon.com/autoscaling/application/userguide/application-auto-scaling-target-tracking.html), [Step scaling policies](https://docs.aws.amazon.com/autoscaling/application/userguide/application-auto-scaling-step-scaling-policies.html), and [Predictive scaling policies](https://docs.aws.amazon.com/autoscaling/application/userguide/aas-create-predictive-scaling-policy.html)
    /// in the *Application Auto Scaling User Guide*.
    ///
    /// If a scalable target is deregistered, the scalable target is no longer
    /// available to
    /// use scaling policies. Any scaling policies that were specified for the
    /// scalable target
    /// are deleted.
    pub fn putScalingPolicy(self: *Self, allocator: std.mem.Allocator, input: put_scaling_policy.PutScalingPolicyInput, options: put_scaling_policy.Options) !put_scaling_policy.PutScalingPolicyOutput {
        return put_scaling_policy.execute(self, allocator, input, options);
    }

    /// Creates or updates a scheduled action for an Application Auto Scaling
    /// scalable target.
    ///
    /// Each scalable target is identified by a service namespace, resource ID, and
    /// scalable
    /// dimension. A scheduled action applies to the scalable target identified by
    /// those three
    /// attributes. You cannot create a scheduled action until you have registered
    /// the resource as
    /// a scalable target.
    ///
    /// When you specify start and end times with a recurring schedule using a cron
    /// expression
    /// or rates, they form the boundaries for when the recurring action starts and
    /// stops.
    ///
    /// To update a scheduled action, specify the parameters that you want to
    /// change. If you
    /// don't specify start and end times, the old values are deleted.
    ///
    /// For more information, see [Scheduled
    /// scaling](https://docs.aws.amazon.com/autoscaling/application/userguide/application-auto-scaling-scheduled-scaling.html) in the *Application Auto Scaling User Guide*.
    ///
    /// If a scalable target is deregistered, the scalable target is no longer
    /// available to
    /// run scheduled actions. Any scheduled actions that were specified for the
    /// scalable target
    /// are deleted.
    pub fn putScheduledAction(self: *Self, allocator: std.mem.Allocator, input: put_scheduled_action.PutScheduledActionInput, options: put_scheduled_action.Options) !put_scheduled_action.PutScheduledActionOutput {
        return put_scheduled_action.execute(self, allocator, input, options);
    }

    /// Registers or updates a scalable target, which is the resource that you want
    /// to
    /// scale.
    ///
    /// Scalable targets are uniquely identified by the combination of resource ID,
    /// scalable
    /// dimension, and namespace, which represents some capacity dimension of the
    /// underlying
    /// service.
    ///
    /// When you register a new scalable target, you must specify values for the
    /// minimum and
    /// maximum capacity. If the specified resource is not active in the target
    /// service, this
    /// operation does not change the resource's current capacity. Otherwise, it
    /// changes the
    /// resource's current capacity to a value that is inside of this range.
    ///
    /// If you add a scaling policy, current capacity is adjustable within the
    /// specified range
    /// when scaling starts. Application Auto Scaling scaling policies will not
    /// scale capacity to values that are
    /// outside of the minimum and maximum range.
    ///
    /// After you register a scalable target, you do not need to register it again
    /// to use other
    /// Application Auto Scaling operations. To see which resources have been
    /// registered, use
    /// [DescribeScalableTargets](https://docs.aws.amazon.com/autoscaling/application/APIReference/API_DescribeScalableTargets.html). You can also view the scaling policies for a service
    /// namespace by using
    /// [DescribeScalableTargets](https://docs.aws.amazon.com/autoscaling/application/APIReference/API_DescribeScalableTargets.html). If you no longer need a scalable target, you can
    /// deregister it by using
    /// [DeregisterScalableTarget](https://docs.aws.amazon.com/autoscaling/application/APIReference/API_DeregisterScalableTarget.html).
    ///
    /// To update a scalable target, specify the parameters that you want to change.
    /// Include the
    /// parameters that identify the scalable target: resource ID, scalable
    /// dimension, and
    /// namespace. Any parameters that you don't specify are not changed by this
    /// update request.
    ///
    /// If you call the `RegisterScalableTarget` API operation to create a
    /// scalable target, there might be a brief delay until the operation achieves
    /// [eventual
    /// consistency](https://en.wikipedia.org/wiki/Eventual_consistency). You might
    /// become aware of this brief delay if you get unexpected
    /// errors when performing sequential operations. The typical strategy is to
    /// retry the
    /// request, and some Amazon Web Services SDKs include automatic backoff and
    /// retry logic.
    ///
    /// If you call the `RegisterScalableTarget` API operation to update an
    /// existing scalable target, Application Auto Scaling retrieves the current
    /// capacity of the resource. If
    /// it's below the minimum capacity or above the maximum capacity, Application
    /// Auto Scaling adjusts the
    /// capacity of the scalable target to place it within these bounds, even if you
    /// don't
    /// include the `MinCapacity` or `MaxCapacity` request
    /// parameters.
    pub fn registerScalableTarget(self: *Self, allocator: std.mem.Allocator, input: register_scalable_target.RegisterScalableTargetInput, options: register_scalable_target.Options) !register_scalable_target.RegisterScalableTargetOutput {
        return register_scalable_target.execute(self, allocator, input, options);
    }

    /// Adds or edits tags on an Application Auto Scaling scalable target.
    ///
    /// Each tag consists of a tag key and a tag value, which are both
    /// case-sensitive strings.
    /// To add a tag, specify a new tag key and a tag value. To edit a tag, specify
    /// an existing tag
    /// key and a new tag value.
    ///
    /// You can use this operation to tag an Application Auto Scaling scalable
    /// target, but you cannot tag a
    /// scaling policy or scheduled action.
    ///
    /// You can also add tags to an Application Auto Scaling scalable target while
    /// creating it
    /// (`RegisterScalableTarget`).
    ///
    /// For general information about tags, including the format and syntax, see
    /// [Tagging your Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the *Amazon Web Services General Reference*.
    ///
    /// Use tags to control access to a scalable target. For more information, see
    /// [Tagging support
    /// for Application Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/application/userguide/resource-tagging-support.html) in the *Application Auto Scaling User Guide*.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Deletes tags from an Application Auto Scaling scalable target. To delete a
    /// tag, specify the tag key and
    /// the Application Auto Scaling scalable target.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn describeScalableTargetsPaginator(self: *Self, params: describe_scalable_targets.DescribeScalableTargetsInput) paginator.DescribeScalableTargetsPaginator {
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

    pub fn describeScalingPoliciesPaginator(self: *Self, params: describe_scaling_policies.DescribeScalingPoliciesInput) paginator.DescribeScalingPoliciesPaginator {
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
};
