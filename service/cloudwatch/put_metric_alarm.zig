const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;
const Dimension = @import("dimension.zig").Dimension;
const MetricDataQuery = @import("metric_data_query.zig").MetricDataQuery;
const Statistic = @import("statistic.zig").Statistic;
const Tag = @import("tag.zig").Tag;
const StandardUnit = @import("standard_unit.zig").StandardUnit;
const serde = @import("serde.zig");

pub const PutMetricAlarmInput = struct {
    /// Indicates whether actions should be executed during any changes to the alarm
    /// state.
    /// The default is `TRUE`.
    actions_enabled: ?bool = null,

    /// The actions to execute when this alarm transitions to the `ALARM` state
    /// from any other state. Each action is specified as an Amazon Resource Name
    /// (ARN). Valid
    /// values:
    ///
    /// **EC2 actions:**
    ///
    /// * `arn:aws:automate:*region*:ec2:stop`
    ///
    /// * `arn:aws:automate:*region*:ec2:terminate`
    ///
    /// * `arn:aws:automate:*region*:ec2:reboot`
    ///
    /// * `arn:aws:automate:*region*:ec2:recover`
    ///
    /// *
    ///   `arn:aws:swf:*region*:*account-id*:action/actions/AWS_EC2.InstanceId.Stop/1.0`
    ///
    /// *
    ///   `arn:aws:swf:*region*:*account-id*:action/actions/AWS_EC2.InstanceId.Terminate/1.0`
    ///
    /// *
    ///   `arn:aws:swf:*region*:*account-id*:action/actions/AWS_EC2.InstanceId.Reboot/1.0`
    ///
    /// *
    ///   `arn:aws:swf:*region*:*account-id*:action/actions/AWS_EC2.InstanceId.Recover/1.0`
    ///
    /// **Autoscaling action:**
    ///
    /// *
    ///   `arn:aws:autoscaling:*region*:*account-id*:scalingPolicy:*policy-id*:autoScalingGroupName/*group-friendly-name*:policyName/*policy-friendly-name*
    /// `
    ///
    /// **Lambda actions:**
    ///
    /// * Invoke the latest version of a Lambda function:
    /// `arn:aws:lambda:*region*:*account-id*:function:*function-name*
    /// `
    ///
    /// * Invoke a specific version of a Lambda function:
    /// `arn:aws:lambda:*region*:*account-id*:function:*function-name*:*version-number*
    /// `
    ///
    /// * Invoke a function by using an alias Lambda function:
    /// `arn:aws:lambda:*region*:*account-id*:function:*function-name*:*alias-name*
    /// `
    ///
    /// **SNS notification action:**
    ///
    /// * `arn:aws:sns:*region*:*account-id*:*sns-topic-name*
    /// `
    ///
    /// **SSM integration actions:**
    ///
    /// *
    ///   `arn:aws:ssm:*region*:*account-id*:opsitem:*severity*#CATEGORY=*category-name*
    /// `
    ///
    /// * `arn:aws:ssm-incidents::*account-id*:responseplan/*response-plan-name*
    /// `
    ///
    /// **Start a Amazon Q Developer operational investigation**
    ///
    /// `arn:aws:aiops:*region*:*account-id*:investigation-group:*investigation-group-id*
    /// `
    alarm_actions: ?[]const []const u8 = null,

    /// The description for the alarm.
    alarm_description: ?[]const u8 = null,

    /// The name for the alarm. This name must be unique within the Region.
    ///
    /// The name must contain only UTF-8 characters, and can't contain ASCII control
    /// characters
    alarm_name: []const u8,

    /// The arithmetic operation to use when comparing the specified statistic and
    /// threshold. The specified statistic value is used as the first operand.
    ///
    /// The values `LessThanLowerOrGreaterThanUpperThreshold`,
    /// `LessThanLowerThreshold`, and `GreaterThanUpperThreshold` are
    /// used only for alarms based on anomaly detection models.
    comparison_operator: ComparisonOperator,

    /// The number of data points that must be breaching to trigger the alarm. This
    /// is used
    /// only if you are setting an "M out of N" alarm. In that case, this value is
    /// the M. For
    /// more information, see [Evaluating an
    /// Alarm](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html#alarm-evaluation) in the *Amazon CloudWatch User
    /// Guide*.
    datapoints_to_alarm: ?i32 = null,

    /// The dimensions for the metric specified in `MetricName`.
    dimensions: ?[]const Dimension = null,

    /// Used only for alarms based on percentiles. If you specify `ignore`, the
    /// alarm state does not change during periods with too few data points to be
    /// statistically
    /// significant. If you specify `evaluate` or omit this parameter, the alarm is
    /// always evaluated and possibly changes state no matter how many data points
    /// are
    /// available. For more information, see [Percentile-Based CloudWatch Alarms and
    /// Low Data
    /// Samples](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html#percentiles-with-low-samples).
    ///
    /// Valid Values: `evaluate | ignore`
    evaluate_low_sample_count_percentile: ?[]const u8 = null,

    /// The number of periods over which data is compared to the specified
    /// threshold. If
    /// you are setting an alarm that requires that a number of consecutive data
    /// points be
    /// breaching to trigger the alarm, this value specifies that number. If you are
    /// setting an
    /// "M out of N" alarm, this value is the N.
    evaluation_periods: i32,

    /// The extended statistic for the metric specified in `MetricName`. When
    /// you call `PutMetricAlarm` and specify a `MetricName`, you must
    /// specify either `Statistic` or `ExtendedStatistic` but not
    /// both.
    ///
    /// If you specify `ExtendedStatistic`, the following are valid values:
    ///
    /// * `p90`
    ///
    /// * `tm90`
    ///
    /// * `tc90`
    ///
    /// * `ts90`
    ///
    /// * `wm90`
    ///
    /// * `IQM`
    ///
    /// * `PR(*n*:*m*)` where n and m
    /// are values of the metric
    ///
    /// * `TC(*X*%:*X*%)` where X is
    /// between 10 and 90 inclusive.
    ///
    /// * `TM(*X*%:*X*%)` where X is
    /// between 10 and 90 inclusive.
    ///
    /// * `TS(*X*%:*X*%)` where X is
    /// between 10 and 90 inclusive.
    ///
    /// * `WM(*X*%:*X*%)` where X is
    /// between 10 and 90 inclusive.
    ///
    /// For more information about these extended statistics, see [CloudWatch
    /// statistics
    /// definitions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Statistics-definitions.html).
    extended_statistic: ?[]const u8 = null,

    /// The actions to execute when this alarm transitions to the
    /// `INSUFFICIENT_DATA` state from any other state. Each action is specified
    /// as an Amazon Resource Name (ARN). Valid values:
    ///
    /// **EC2 actions:**
    ///
    /// * `arn:aws:automate:*region*:ec2:stop`
    ///
    /// * `arn:aws:automate:*region*:ec2:terminate`
    ///
    /// * `arn:aws:automate:*region*:ec2:reboot`
    ///
    /// * `arn:aws:automate:*region*:ec2:recover`
    ///
    /// *
    ///   `arn:aws:swf:*region*:*account-id*:action/actions/AWS_EC2.InstanceId.Stop/1.0`
    ///
    /// *
    ///   `arn:aws:swf:*region*:*account-id*:action/actions/AWS_EC2.InstanceId.Terminate/1.0`
    ///
    /// *
    ///   `arn:aws:swf:*region*:*account-id*:action/actions/AWS_EC2.InstanceId.Reboot/1.0`
    ///
    /// *
    ///   `arn:aws:swf:*region*:*account-id*:action/actions/AWS_EC2.InstanceId.Recover/1.0`
    ///
    /// **Autoscaling action:**
    ///
    /// *
    ///   `arn:aws:autoscaling:*region*:*account-id*:scalingPolicy:*policy-id*:autoScalingGroupName/*group-friendly-name*:policyName/*policy-friendly-name*
    /// `
    ///
    /// **Lambda actions:**
    ///
    /// * Invoke the latest version of a Lambda function:
    /// `arn:aws:lambda:*region*:*account-id*:function:*function-name*
    /// `
    ///
    /// * Invoke a specific version of a Lambda function:
    /// `arn:aws:lambda:*region*:*account-id*:function:*function-name*:*version-number*
    /// `
    ///
    /// * Invoke a function by using an alias Lambda function:
    /// `arn:aws:lambda:*region*:*account-id*:function:*function-name*:*alias-name*
    /// `
    ///
    /// **SNS notification action:**
    ///
    /// * `arn:aws:sns:*region*:*account-id*:*sns-topic-name*
    /// `
    ///
    /// **SSM integration actions:**
    ///
    /// *
    ///   `arn:aws:ssm:*region*:*account-id*:opsitem:*severity*#CATEGORY=*category-name*
    /// `
    ///
    /// * `arn:aws:ssm-incidents::*account-id*:responseplan/*response-plan-name*
    /// `
    insufficient_data_actions: ?[]const []const u8 = null,

    /// The name for the metric associated with the alarm. For each
    /// `PutMetricAlarm` operation, you must specify either
    /// `MetricName` or a `Metrics` array.
    ///
    /// If you are creating an alarm based on a math expression, you cannot specify
    /// this
    /// parameter, or any of the `Namespace`, `Dimensions`,
    /// `Period`, `Unit`, `Statistic`, or
    /// `ExtendedStatistic` parameters. Instead, you specify all this information
    /// in the `Metrics` array.
    metric_name: ?[]const u8 = null,

    /// An array of `MetricDataQuery` structures that enable you to create an alarm
    /// based on the result of a metric math expression. For each `PutMetricAlarm`
    /// operation, you must specify either `MetricName` or a `Metrics`
    /// array.
    ///
    /// Each item in the `Metrics` array either retrieves a metric or performs a
    /// math expression.
    ///
    /// One item in the `Metrics` array is the expression that the alarm watches.
    /// You designate this expression by setting `ReturnData` to true for this
    /// object
    /// in the array. For more information, see
    /// [MetricDataQuery](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_MetricDataQuery.html).
    ///
    /// If you use the `Metrics` parameter, you cannot include the
    /// `Namespace`, `MetricName`, `Dimensions`,
    /// `Period`, `Unit`, `Statistic`, or
    /// `ExtendedStatistic` parameters of `PutMetricAlarm` in the same
    /// operation. Instead, you retrieve the metrics you are using in your math
    /// expression as
    /// part of the `Metrics` array.
    metrics: ?[]const MetricDataQuery = null,

    /// The namespace for the metric associated specified in
    /// `MetricName`.
    namespace: ?[]const u8 = null,

    /// The actions to execute when this alarm transitions to an `OK` state from
    /// any other state. Each action is specified as an Amazon Resource Name (ARN).
    /// Valid
    /// values:
    ///
    /// **EC2 actions:**
    ///
    /// * `arn:aws:automate:*region*:ec2:stop`
    ///
    /// * `arn:aws:automate:*region*:ec2:terminate`
    ///
    /// * `arn:aws:automate:*region*:ec2:reboot`
    ///
    /// * `arn:aws:automate:*region*:ec2:recover`
    ///
    /// *
    ///   `arn:aws:swf:*region*:*account-id*:action/actions/AWS_EC2.InstanceId.Stop/1.0`
    ///
    /// *
    ///   `arn:aws:swf:*region*:*account-id*:action/actions/AWS_EC2.InstanceId.Terminate/1.0`
    ///
    /// *
    ///   `arn:aws:swf:*region*:*account-id*:action/actions/AWS_EC2.InstanceId.Reboot/1.0`
    ///
    /// *
    ///   `arn:aws:swf:*region*:*account-id*:action/actions/AWS_EC2.InstanceId.Recover/1.0`
    ///
    /// **Autoscaling action:**
    ///
    /// *
    ///   `arn:aws:autoscaling:*region*:*account-id*:scalingPolicy:*policy-id*:autoScalingGroupName/*group-friendly-name*:policyName/*policy-friendly-name*
    /// `
    ///
    /// **Lambda actions:**
    ///
    /// * Invoke the latest version of a Lambda function:
    /// `arn:aws:lambda:*region*:*account-id*:function:*function-name*
    /// `
    ///
    /// * Invoke a specific version of a Lambda function:
    /// `arn:aws:lambda:*region*:*account-id*:function:*function-name*:*version-number*
    /// `
    ///
    /// * Invoke a function by using an alias Lambda function:
    /// `arn:aws:lambda:*region*:*account-id*:function:*function-name*:*alias-name*
    /// `
    ///
    /// **SNS notification action:**
    ///
    /// * `arn:aws:sns:*region*:*account-id*:*sns-topic-name*
    /// `
    ///
    /// **SSM integration actions:**
    ///
    /// *
    ///   `arn:aws:ssm:*region*:*account-id*:opsitem:*severity*#CATEGORY=*category-name*
    /// `
    ///
    /// * `arn:aws:ssm-incidents::*account-id*:responseplan/*response-plan-name*
    /// `
    ok_actions: ?[]const []const u8 = null,

    /// The length, in seconds, used each time the metric specified in
    /// `MetricName` is evaluated. Valid values are 10, 20, 30, and any multiple of
    /// 60.
    ///
    /// `Period` is required for alarms based on static thresholds. If you are
    /// creating an alarm based on a metric math expression, you specify the period
    /// for each
    /// metric within the objects in the `Metrics` array.
    ///
    /// Be sure to specify 10, 20, or 30 only for metrics that are stored by a
    /// `PutMetricData` call with a `StorageResolution` of 1. If you
    /// specify a period of 10, 20, or 30 for a metric that does not have sub-minute
    /// resolution, the
    /// alarm still attempts to gather data at the period rate that you specify. In
    /// this case,
    /// it does not receive data for the attempts that do not correspond to a
    /// one-minute data
    /// resolution, and the alarm might often lapse into INSUFFICENT_DATA status.
    /// Specifying 10, 20,
    /// or 30 also sets this alarm as a high-resolution alarm, which has a higher
    /// charge than
    /// other alarms. For more information about pricing, see [Amazon CloudWatch
    /// Pricing](https://aws.amazon.com/cloudwatch/pricing/).
    ///
    /// An alarm's total current evaluation period can be no longer than seven days,
    /// so
    /// `Period` multiplied by `EvaluationPeriods` can't be more than
    /// 604,800 seconds. For alarms with a period of less than one hour (3,600
    /// seconds), the total evaluation period can't be longer than one day (86,400
    /// seconds).
    period: ?i32 = null,

    /// The statistic for the metric specified in `MetricName`, other than
    /// percentile. For percentile statistics, use `ExtendedStatistic`. When you
    /// call
    /// `PutMetricAlarm` and specify a `MetricName`, you must specify
    /// either `Statistic` or `ExtendedStatistic,` but not both.
    statistic: ?Statistic = null,

    /// A list of key-value pairs to associate with the alarm. You can associate as
    /// many as
    /// 50 tags with an alarm. To be able to associate tags with the alarm when you
    /// create the
    /// alarm, you must have the `cloudwatch:TagResource` permission.
    ///
    /// Tags can help you organize and categorize your resources. You can also use
    /// them to
    /// scope user permissions by granting a user permission to access or change
    /// only resources
    /// with certain tag values.
    ///
    /// If you are using this operation to update an existing alarm, any tags you
    /// specify in
    /// this parameter are ignored. To change the tags of an existing alarm, use
    /// [TagResource](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_TagResource.html) or [UntagResource](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_UntagResource.html).
    ///
    /// To use this field to set tags for an alarm when you create it, you must be
    /// signed on
    /// with both the `cloudwatch:PutMetricAlarm` and
    /// `cloudwatch:TagResource` permissions.
    tags: ?[]const Tag = null,

    /// The value against which the specified statistic is compared.
    ///
    /// This parameter is required for alarms based on static thresholds, but should
    /// not be
    /// used for alarms based on anomaly detection models.
    threshold: ?f64 = null,

    /// If this is an alarm based on an anomaly detection model, make this value
    /// match the ID
    /// of the `ANOMALY_DETECTION_BAND` function.
    ///
    /// For an example of how to use this parameter, see the **Anomaly
    /// Detection Model Alarm** example on this page.
    ///
    /// If your alarm uses this parameter, it cannot have Auto Scaling actions.
    threshold_metric_id: ?[]const u8 = null,

    /// Sets how this alarm is to handle missing data points. If
    /// `TreatMissingData` is omitted, the default behavior of
    /// `missing` is used. For more information, see [Configuring How CloudWatch
    /// Alarms Treats Missing
    /// Data](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html#alarms-and-missing-data).
    ///
    /// Valid Values: `breaching | notBreaching | ignore | missing`
    ///
    /// Alarms that evaluate metrics in the `AWS/DynamoDB` namespace always
    /// `ignore` missing data even if you choose a different option for
    /// `TreatMissingData`. When an `AWS/DynamoDB` metric has
    /// missing data, alarms that evaluate that metric remain in their current
    /// state.
    treat_missing_data: ?[]const u8 = null,

    /// The unit of measure for the statistic. For example, the units for the Amazon
    /// EC2
    /// NetworkIn metric are Bytes because NetworkIn tracks the number of bytes that
    /// an instance
    /// receives on all network interfaces. You can also specify a unit when you
    /// create a custom
    /// metric. Units help provide conceptual meaning to your data. Metric data
    /// points that
    /// specify a unit of measure, such as Percent, are aggregated separately. If
    /// you are
    /// creating an alarm based on a metric math expression, you can specify the
    /// unit for each
    /// metric (if needed) within the objects in the `Metrics` array.
    ///
    /// If you don't specify `Unit`, CloudWatch retrieves all unit types that
    /// have been published for the metric and attempts to evaluate the alarm.
    /// Usually, metrics
    /// are published with only one unit, so the alarm works as intended.
    ///
    /// However, if the metric is published with multiple types of units and you
    /// don't
    /// specify a unit, the alarm's behavior is not defined and it behaves
    /// unpredictably.
    ///
    /// We recommend omitting `Unit` so that you don't inadvertently specify an
    /// incorrect unit that is not published for this metric. Doing so causes the
    /// alarm to be
    /// stuck in the `INSUFFICIENT DATA` state.
    unit: ?StandardUnit = null,

    pub const json_field_names = .{
        .actions_enabled = "ActionsEnabled",
        .alarm_actions = "AlarmActions",
        .alarm_description = "AlarmDescription",
        .alarm_name = "AlarmName",
        .comparison_operator = "ComparisonOperator",
        .datapoints_to_alarm = "DatapointsToAlarm",
        .dimensions = "Dimensions",
        .evaluate_low_sample_count_percentile = "EvaluateLowSampleCountPercentile",
        .evaluation_periods = "EvaluationPeriods",
        .extended_statistic = "ExtendedStatistic",
        .insufficient_data_actions = "InsufficientDataActions",
        .metric_name = "MetricName",
        .metrics = "Metrics",
        .namespace = "Namespace",
        .ok_actions = "OKActions",
        .period = "Period",
        .statistic = "Statistic",
        .tags = "Tags",
        .threshold = "Threshold",
        .threshold_metric_id = "ThresholdMetricId",
        .treat_missing_data = "TreatMissingData",
        .unit = "Unit",
    };
};

const PutMetricAlarmOutput = struct {};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutMetricAlarmInput, options: Options) !PutMetricAlarmOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudwatch");

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutMetricAlarmInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudwatch", "CloudWatch", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=PutMetricAlarm&Version=2010-08-01");
    if (input.actions_enabled) |v| {
        try body_buf.appendSlice(allocator, "&ActionsEnabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.alarm_actions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AlarmActions.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.alarm_description) |v| {
        try body_buf.appendSlice(allocator, "&AlarmDescription=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&AlarmName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.alarm_name);
    try body_buf.appendSlice(allocator, "&ComparisonOperator=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(input.comparison_operator));
    if (input.datapoints_to_alarm) |v| {
        try body_buf.appendSlice(allocator, "&DatapointsToAlarm=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.dimensions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Dimensions.member.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.name);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Dimensions.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.value);
            }
        }
    }
    if (input.evaluate_low_sample_count_percentile) |v| {
        try body_buf.appendSlice(allocator, "&EvaluateLowSampleCountPercentile=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&EvaluationPeriods=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.evaluation_periods}) catch "");
    if (input.extended_statistic) |v| {
        try body_buf.appendSlice(allocator, "&ExtendedStatistic=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.insufficient_data_actions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InsufficientDataActions.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.metric_name) |v| {
        try body_buf.appendSlice(allocator, "&MetricName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.metrics) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Metrics.member.{d}.AccountId=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.account_id) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Metrics.member.{d}.Expression=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.expression) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Metrics.member.{d}.Id=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.id);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Metrics.member.{d}.Label=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.label) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.metric_stat) |sv_1| {
                if (sv_1.metric.dimensions) |lst_3| {
                    for (lst_3, 0..) |item_3, idx_3| {
                        const n_3 = idx_3 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Metrics.member.{d}.MetricStat.Metric.Dimensions.member.{d}.Name=", .{n, n_3}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.name);
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Metrics.member.{d}.MetricStat.Metric.Dimensions.member.{d}.Value=", .{n, n_3}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.value);
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Metrics.member.{d}.MetricStat.Metric.MetricName=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.metric.metric_name) |fv_3| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Metrics.member.{d}.MetricStat.Metric.Namespace=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.metric.namespace) |fv_3| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Metrics.member.{d}.MetricStat.Period=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv_1.period}) catch "");
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Metrics.member.{d}.MetricStat.Stat=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.stat);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Metrics.member.{d}.MetricStat.Unit=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.unit) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(fv_2));
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Metrics.member.{d}.Period=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.period) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Metrics.member.{d}.ReturnData=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.return_data) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
                }
            }
        }
    }
    if (input.namespace) |v| {
        try body_buf.appendSlice(allocator, "&Namespace=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.ok_actions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OKActions.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.period) |v| {
        try body_buf.appendSlice(allocator, "&Period=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.statistic) |v| {
        try body_buf.appendSlice(allocator, "&Statistic=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
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
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.value);
            }
        }
    }
    if (input.threshold) |v| {
        try body_buf.appendSlice(allocator, "&Threshold=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.threshold_metric_id) |v| {
        try body_buf.appendSlice(allocator, "&ThresholdMetricId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.treat_missing_data) |v| {
        try body_buf.appendSlice(allocator, "&TreatMissingData=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.unit) |v| {
        try body_buf.appendSlice(allocator, "&Unit=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutMetricAlarmOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: PutMetricAlarmOutput = .{};

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

    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DashboardInvalidInputError")) {
        return .{ .arena = arena, .kind = .{ .dashboard_invalid_input_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DashboardNotFoundError")) {
        return .{ .arena = arena, .kind = .{ .dashboard_not_found_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceFault")) {
        return .{ .arena = arena, .kind = .{ .internal_service_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFormatFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_format_fault = .{
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
    if (std.mem.eql(u8, error_code, "InvalidParameterCombinationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_combination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "MissingRequiredParameterException")) {
        return .{ .arena = arena, .kind = .{ .missing_required_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
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
