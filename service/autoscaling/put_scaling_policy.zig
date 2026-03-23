const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const PredictiveScalingConfiguration = @import("predictive_scaling_configuration.zig").PredictiveScalingConfiguration;
const StepAdjustment = @import("step_adjustment.zig").StepAdjustment;
const TargetTrackingConfiguration = @import("target_tracking_configuration.zig").TargetTrackingConfiguration;
const Alarm = @import("alarm.zig").Alarm;
const serde = @import("serde.zig");

pub const PutScalingPolicyInput = struct {
    /// Specifies how the scaling adjustment is interpreted (for example, an
    /// absolute number
    /// or a percentage). The valid values are `ChangeInCapacity`,
    /// `ExactCapacity`, and `PercentChangeInCapacity`.
    ///
    /// Required if the policy type is `StepScaling` or `SimpleScaling`.
    /// For more information, see [Scaling adjustment
    /// types](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-scaling-simple-step.html#as-scaling-adjustment) in the *Amazon EC2 Auto Scaling User Guide*.
    adjustment_type: ?[]const u8 = null,

    /// The name of the Auto Scaling group.
    auto_scaling_group_name: []const u8,

    /// A cooldown period, in seconds, that applies to a specific simple scaling
    /// policy. When
    /// a cooldown period is specified here, it overrides the default cooldown.
    ///
    /// Valid only if the policy type is `SimpleScaling`. For more information, see
    /// [Scaling
    /// cooldowns for Amazon EC2 Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-scaling-cooldowns.html) in the *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// Default: None
    cooldown: ?i32 = null,

    /// Indicates whether the scaling policy is enabled or disabled. The default is
    /// enabled.
    /// For more information, see [Disable a
    /// scaling policy for an Auto Scaling
    /// group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-enable-disable-scaling-policy.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    enabled: ?bool = null,

    /// *Not needed if the default instance warmup is defined for the
    /// group.*
    ///
    /// The estimated time, in seconds, until a newly launched instance can
    /// contribute to the
    /// CloudWatch metrics. This warm-up period applies to instances launched due to
    /// a specific target
    /// tracking or step scaling policy. When a warm-up period is specified here, it
    /// overrides
    /// the default instance warmup.
    ///
    /// Valid only if the policy type is `TargetTrackingScaling` or
    /// `StepScaling`.
    ///
    /// The default is to use the value for the default instance warmup defined for
    /// the
    /// group. If default instance warmup is null, then `EstimatedInstanceWarmup`
    /// falls back to the value of default cooldown.
    estimated_instance_warmup: ?i32 = null,

    /// The aggregation type for the CloudWatch metrics. The valid values are
    /// `Minimum`,
    /// `Maximum`, and `Average`. If the aggregation type is null, the
    /// value is treated as `Average`.
    ///
    /// Valid only if the policy type is `StepScaling`.
    metric_aggregation_type: ?[]const u8 = null,

    /// The minimum value to scale by when the adjustment type is
    /// `PercentChangeInCapacity`. For example, suppose that you create a step
    /// scaling policy to scale out an Auto Scaling group by 25 percent and you
    /// specify a
    /// `MinAdjustmentMagnitude` of 2. If the group has 4 instances and the
    /// scaling policy is performed, 25 percent of 4 is 1. However, because you
    /// specified a
    /// `MinAdjustmentMagnitude` of 2, Amazon EC2 Auto Scaling scales out the group
    /// by 2
    /// instances.
    ///
    /// Valid only if the policy type is `StepScaling` or
    /// `SimpleScaling`. For more information, see [Scaling adjustment
    /// types](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-scaling-simple-step.html#as-scaling-adjustment) in the *Amazon EC2 Auto Scaling User
    /// Guide*.
    ///
    /// Some Auto Scaling groups use instance weights. In this case, set the
    /// `MinAdjustmentMagnitude` to a value that is at least as large as your
    /// largest instance weight.
    min_adjustment_magnitude: ?i32 = null,

    /// Available for backward compatibility. Use `MinAdjustmentMagnitude`
    /// instead.
    min_adjustment_step: ?i32 = null,

    /// The name of the policy.
    policy_name: []const u8,

    /// One of the following policy types:
    ///
    /// * `TargetTrackingScaling`
    ///
    /// * `StepScaling`
    ///
    /// * `SimpleScaling` (default)
    ///
    /// * `PredictiveScaling`
    policy_type: ?[]const u8 = null,

    /// A predictive scaling policy. Provides support for predefined and custom
    /// metrics.
    ///
    /// Predefined metrics include CPU utilization, network in/out, and the
    /// Application Load
    /// Balancer request count.
    ///
    /// For more information, see
    /// [PredictiveScalingConfiguration](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_PredictiveScalingConfiguration.html) in the *Amazon EC2 Auto Scaling API
    /// Reference*.
    ///
    /// Required if the policy type is `PredictiveScaling`.
    predictive_scaling_configuration: ?PredictiveScalingConfiguration = null,

    /// The amount by which to scale, based on the specified adjustment type. A
    /// positive value
    /// adds to the current capacity while a negative number removes from the
    /// current capacity.
    /// For exact capacity, you must specify a non-negative value.
    ///
    /// Required if the policy type is `SimpleScaling`. (Not used with any other
    /// policy type.)
    scaling_adjustment: ?i32 = null,

    /// A set of adjustments that enable you to scale based on the size of the alarm
    /// breach.
    ///
    /// Required if the policy type is `StepScaling`. (Not used with any other
    /// policy type.)
    step_adjustments: ?[]const StepAdjustment = null,

    /// A target tracking scaling policy. Provides support for predefined or custom
    /// metrics.
    ///
    /// The following predefined metrics are available:
    ///
    /// * `ASGAverageCPUUtilization`
    ///
    /// * `ASGAverageNetworkIn`
    ///
    /// * `ASGAverageNetworkOut`
    ///
    /// * `ALBRequestCountPerTarget`
    ///
    /// If you specify `ALBRequestCountPerTarget` for the metric, you must specify
    /// the `ResourceLabel` property with the
    /// `PredefinedMetricSpecification`.
    ///
    /// For more information, see
    /// [TargetTrackingConfiguration](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_TargetTrackingConfiguration.html) in the *Amazon EC2 Auto Scaling API
    /// Reference*.
    ///
    /// Required if the policy type is `TargetTrackingScaling`.
    target_tracking_configuration: ?TargetTrackingConfiguration = null,
};

pub const PutScalingPolicyOutput = struct {
    /// The CloudWatch alarms created for the target tracking scaling policy.
    alarms: ?[]const Alarm = null,

    /// The Amazon Resource Name (ARN) of the policy.
    policy_arn: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutScalingPolicyInput, options: CallOptions) !PutScalingPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutScalingPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=PutScalingPolicy&Version=2011-01-01");
    if (input.adjustment_type) |v| {
        try body_buf.appendSlice(allocator, "&AdjustmentType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&AutoScalingGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.auto_scaling_group_name);
    if (input.cooldown) |v| {
        try body_buf.appendSlice(allocator, "&Cooldown=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.enabled) |v| {
        try body_buf.appendSlice(allocator, "&Enabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.estimated_instance_warmup) |v| {
        try body_buf.appendSlice(allocator, "&EstimatedInstanceWarmup=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.metric_aggregation_type) |v| {
        try body_buf.appendSlice(allocator, "&MetricAggregationType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.min_adjustment_magnitude) |v| {
        try body_buf.appendSlice(allocator, "&MinAdjustmentMagnitude=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.min_adjustment_step) |v| {
        try body_buf.appendSlice(allocator, "&MinAdjustmentStep=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&PolicyName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.policy_name);
    if (input.policy_type) |v| {
        try body_buf.appendSlice(allocator, "&PolicyType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.predictive_scaling_configuration) |v| {
        if (v.max_capacity_breach_behavior) |sv| {
            try body_buf.appendSlice(allocator, "&PredictiveScalingConfiguration.MaxCapacityBreachBehavior=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
        if (v.max_capacity_buffer) |sv| {
            try body_buf.appendSlice(allocator, "&PredictiveScalingConfiguration.MaxCapacityBuffer=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        for (v.metric_specifications, 0..) |item, idx| {
            const n = idx + 1;
            if (item.customized_capacity_metric_specification) |sv_1| {
                for (sv_1.metric_data_queries, 0..) |item_2, idx_2| {
                    const n_2 = idx_2 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_2.expression) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedCapacityMetricSpecification.MetricDataQueries.member.{d}.Expression=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedCapacityMetricSpecification.MetricDataQueries.member.{d}.Id=", .{n, n_2}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_2.id);
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_2.label) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedCapacityMetricSpecification.MetricDataQueries.member.{d}.Label=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                        }
                    }
                    if (item_2.metric_stat) |sv_3| {
                        if (sv_3.metric.dimensions) |lst_5| {
                            for (lst_5, 0..) |item_5, idx_5| {
                                const n_5 = idx_5 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedCapacityMetricSpecification.MetricDataQueries.member.{d}.MetricStat.Metric.Dimensions.member.{d}.Name=", .{n, n_2, n_5}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_5.name);
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedCapacityMetricSpecification.MetricDataQueries.member.{d}.MetricStat.Metric.Dimensions.member.{d}.Value=", .{n, n_2, n_5}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_5.value);
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedCapacityMetricSpecification.MetricDataQueries.member.{d}.MetricStat.Metric.MetricName=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, sv_3.metric.metric_name);
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedCapacityMetricSpecification.MetricDataQueries.member.{d}.MetricStat.Metric.Namespace=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, sv_3.metric.namespace);
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedCapacityMetricSpecification.MetricDataQueries.member.{d}.MetricStat.Stat=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, sv_3.stat);
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_3.unit) |fv_4| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedCapacityMetricSpecification.MetricDataQueries.member.{d}.MetricStat.Unit=", .{n, n_2}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_4);
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_2.return_data) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedCapacityMetricSpecification.MetricDataQueries.member.{d}.ReturnData=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_3) "true" else "false");
                        }
                    }
                }
            }
            if (item.customized_load_metric_specification) |sv_1| {
                for (sv_1.metric_data_queries, 0..) |item_2, idx_2| {
                    const n_2 = idx_2 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_2.expression) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedLoadMetricSpecification.MetricDataQueries.member.{d}.Expression=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedLoadMetricSpecification.MetricDataQueries.member.{d}.Id=", .{n, n_2}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_2.id);
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_2.label) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedLoadMetricSpecification.MetricDataQueries.member.{d}.Label=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                        }
                    }
                    if (item_2.metric_stat) |sv_3| {
                        if (sv_3.metric.dimensions) |lst_5| {
                            for (lst_5, 0..) |item_5, idx_5| {
                                const n_5 = idx_5 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedLoadMetricSpecification.MetricDataQueries.member.{d}.MetricStat.Metric.Dimensions.member.{d}.Name=", .{n, n_2, n_5}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_5.name);
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedLoadMetricSpecification.MetricDataQueries.member.{d}.MetricStat.Metric.Dimensions.member.{d}.Value=", .{n, n_2, n_5}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_5.value);
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedLoadMetricSpecification.MetricDataQueries.member.{d}.MetricStat.Metric.MetricName=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, sv_3.metric.metric_name);
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedLoadMetricSpecification.MetricDataQueries.member.{d}.MetricStat.Metric.Namespace=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, sv_3.metric.namespace);
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedLoadMetricSpecification.MetricDataQueries.member.{d}.MetricStat.Stat=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, sv_3.stat);
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_3.unit) |fv_4| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedLoadMetricSpecification.MetricDataQueries.member.{d}.MetricStat.Unit=", .{n, n_2}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_4);
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_2.return_data) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedLoadMetricSpecification.MetricDataQueries.member.{d}.ReturnData=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_3) "true" else "false");
                        }
                    }
                }
            }
            if (item.customized_scaling_metric_specification) |sv_1| {
                for (sv_1.metric_data_queries, 0..) |item_2, idx_2| {
                    const n_2 = idx_2 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_2.expression) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedScalingMetricSpecification.MetricDataQueries.member.{d}.Expression=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedScalingMetricSpecification.MetricDataQueries.member.{d}.Id=", .{n, n_2}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_2.id);
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_2.label) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedScalingMetricSpecification.MetricDataQueries.member.{d}.Label=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                        }
                    }
                    if (item_2.metric_stat) |sv_3| {
                        if (sv_3.metric.dimensions) |lst_5| {
                            for (lst_5, 0..) |item_5, idx_5| {
                                const n_5 = idx_5 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedScalingMetricSpecification.MetricDataQueries.member.{d}.MetricStat.Metric.Dimensions.member.{d}.Name=", .{n, n_2, n_5}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_5.name);
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedScalingMetricSpecification.MetricDataQueries.member.{d}.MetricStat.Metric.Dimensions.member.{d}.Value=", .{n, n_2, n_5}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_5.value);
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedScalingMetricSpecification.MetricDataQueries.member.{d}.MetricStat.Metric.MetricName=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, sv_3.metric.metric_name);
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedScalingMetricSpecification.MetricDataQueries.member.{d}.MetricStat.Metric.Namespace=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, sv_3.metric.namespace);
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedScalingMetricSpecification.MetricDataQueries.member.{d}.MetricStat.Stat=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, sv_3.stat);
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_3.unit) |fv_4| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedScalingMetricSpecification.MetricDataQueries.member.{d}.MetricStat.Unit=", .{n, n_2}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_4);
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_2.return_data) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.CustomizedScalingMetricSpecification.MetricDataQueries.member.{d}.ReturnData=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_3) "true" else "false");
                        }
                    }
                }
            }
            if (item.predefined_load_metric_specification) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.PredefinedLoadMetricSpecification.PredefinedMetricType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.predefined_metric_type.wireName());
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.resource_label) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.PredefinedLoadMetricSpecification.ResourceLabel=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
            }
            if (item.predefined_metric_pair_specification) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.PredefinedMetricPairSpecification.PredefinedMetricType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.predefined_metric_type.wireName());
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.resource_label) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.PredefinedMetricPairSpecification.ResourceLabel=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
            }
            if (item.predefined_scaling_metric_specification) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.PredefinedScalingMetricSpecification.PredefinedMetricType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.predefined_metric_type.wireName());
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.resource_label) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.PredefinedScalingMetricSpecification.ResourceLabel=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PredictiveScalingConfiguration.MetricSpecifications.member.{d}.TargetValue=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{item.target_value}) catch "");
            }
        }
        if (v.mode) |sv| {
            try body_buf.appendSlice(allocator, "&PredictiveScalingConfiguration.Mode=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
        if (v.scheduling_buffer_time) |sv| {
            try body_buf.appendSlice(allocator, "&PredictiveScalingConfiguration.SchedulingBufferTime=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
    }
    if (input.scaling_adjustment) |v| {
        try body_buf.appendSlice(allocator, "&ScalingAdjustment=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.step_adjustments) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.metric_interval_lower_bound) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&StepAdjustments.member.{d}.MetricIntervalLowerBound=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.metric_interval_upper_bound) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&StepAdjustments.member.{d}.MetricIntervalUpperBound=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&StepAdjustments.member.{d}.ScalingAdjustment=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{item.scaling_adjustment}) catch "");
            }
        }
    }
    if (input.target_tracking_configuration) |v| {
        if (v.customized_metric_specification) |sv| {
            if (sv.dimensions) |list_d1| {
                for (list_d1, 0..) |item, idx| {
                    const n = idx + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetTrackingConfiguration.CustomizedMetricSpecification.Dimensions.member.{d}.Name=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item.name);
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetTrackingConfiguration.CustomizedMetricSpecification.Dimensions.member.{d}.Value=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item.value);
                    }
                }
            }
            if (sv.metric_name) |sv2| {
                try body_buf.appendSlice(allocator, "&TargetTrackingConfiguration.CustomizedMetricSpecification.MetricName=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
            if (sv.metrics) |list_d1| {
                for (list_d1, 0..) |item, idx| {
                    const n = idx + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item.expression) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetTrackingConfiguration.CustomizedMetricSpecification.Metrics.member.{d}.Expression=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetTrackingConfiguration.CustomizedMetricSpecification.Metrics.member.{d}.Id=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item.id);
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item.label) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetTrackingConfiguration.CustomizedMetricSpecification.Metrics.member.{d}.Label=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    if (item.metric_stat) |sv_2| {
                        if (sv_2.metric.dimensions) |lst_4| {
                            for (lst_4, 0..) |item_4, idx_4| {
                                const n_4 = idx_4 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetTrackingConfiguration.CustomizedMetricSpecification.Metrics.member.{d}.MetricStat.Metric.Dimensions.member.{d}.Name=", .{n, n_4}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_4.name);
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetTrackingConfiguration.CustomizedMetricSpecification.Metrics.member.{d}.MetricStat.Metric.Dimensions.member.{d}.Value=", .{n, n_4}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_4.value);
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetTrackingConfiguration.CustomizedMetricSpecification.Metrics.member.{d}.MetricStat.Metric.MetricName=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, sv_2.metric.metric_name);
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetTrackingConfiguration.CustomizedMetricSpecification.Metrics.member.{d}.MetricStat.Metric.Namespace=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, sv_2.metric.namespace);
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.period) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetTrackingConfiguration.CustomizedMetricSpecification.Metrics.member.{d}.MetricStat.Period=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetTrackingConfiguration.CustomizedMetricSpecification.Metrics.member.{d}.MetricStat.Stat=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, sv_2.stat);
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.unit) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetTrackingConfiguration.CustomizedMetricSpecification.Metrics.member.{d}.MetricStat.Unit=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item.period) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetTrackingConfiguration.CustomizedMetricSpecification.Metrics.member.{d}.Period=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item.return_data) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetTrackingConfiguration.CustomizedMetricSpecification.Metrics.member.{d}.ReturnData=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_2) "true" else "false");
                        }
                    }
                }
            }
            if (sv.namespace) |sv2| {
                try body_buf.appendSlice(allocator, "&TargetTrackingConfiguration.CustomizedMetricSpecification.Namespace=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
            if (sv.period) |sv2| {
                try body_buf.appendSlice(allocator, "&TargetTrackingConfiguration.CustomizedMetricSpecification.Period=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
            }
            if (sv.statistic) |sv2| {
                try body_buf.appendSlice(allocator, "&TargetTrackingConfiguration.CustomizedMetricSpecification.Statistic=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2.wireName());
            }
            if (sv.unit) |sv2| {
                try body_buf.appendSlice(allocator, "&TargetTrackingConfiguration.CustomizedMetricSpecification.Unit=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
        }
        if (v.disable_scale_in) |sv| {
            try body_buf.appendSlice(allocator, "&TargetTrackingConfiguration.DisableScaleIn=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
        if (v.predefined_metric_specification) |sv| {
            try body_buf.appendSlice(allocator, "&TargetTrackingConfiguration.PredefinedMetricSpecification.PredefinedMetricType=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.predefined_metric_type.wireName());
            if (sv.resource_label) |sv2| {
                try body_buf.appendSlice(allocator, "&TargetTrackingConfiguration.PredefinedMetricSpecification.ResourceLabel=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
        }
        try body_buf.appendSlice(allocator, "&TargetTrackingConfiguration.TargetValue=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v.target_value}) catch "");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutScalingPolicyOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PutScalingPolicyResult")) break;
            },
            else => {},
        }
    }

    var result: PutScalingPolicyOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Alarms")) {
                    result.alarms = try serde.deserializeAlarms(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "PolicyARN")) {
                    result.policy_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

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
