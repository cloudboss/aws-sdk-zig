const aws = @import("aws");
const std = @import("std");

const delete_alarms = @import("delete_alarms.zig");
const delete_anomaly_detector = @import("delete_anomaly_detector.zig");
const delete_dashboards = @import("delete_dashboards.zig");
const delete_insight_rules = @import("delete_insight_rules.zig");
const delete_metric_stream = @import("delete_metric_stream.zig");
const describe_alarm_contributors = @import("describe_alarm_contributors.zig");
const describe_alarm_history = @import("describe_alarm_history.zig");
const describe_alarms = @import("describe_alarms.zig");
const describe_alarms_for_metric = @import("describe_alarms_for_metric.zig");
const describe_anomaly_detectors = @import("describe_anomaly_detectors.zig");
const describe_insight_rules = @import("describe_insight_rules.zig");
const disable_alarm_actions = @import("disable_alarm_actions.zig");
const disable_insight_rules = @import("disable_insight_rules.zig");
const enable_alarm_actions = @import("enable_alarm_actions.zig");
const enable_insight_rules = @import("enable_insight_rules.zig");
const get_dashboard = @import("get_dashboard.zig");
const get_insight_rule_report = @import("get_insight_rule_report.zig");
const get_metric_data = @import("get_metric_data.zig");
const get_metric_statistics = @import("get_metric_statistics.zig");
const get_metric_stream = @import("get_metric_stream.zig");
const get_metric_widget_image = @import("get_metric_widget_image.zig");
const list_dashboards = @import("list_dashboards.zig");
const list_managed_insight_rules = @import("list_managed_insight_rules.zig");
const list_metric_streams = @import("list_metric_streams.zig");
const list_metrics = @import("list_metrics.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_anomaly_detector = @import("put_anomaly_detector.zig");
const put_composite_alarm = @import("put_composite_alarm.zig");
const put_dashboard = @import("put_dashboard.zig");
const put_insight_rule = @import("put_insight_rule.zig");
const put_managed_insight_rules = @import("put_managed_insight_rules.zig");
const put_metric_alarm = @import("put_metric_alarm.zig");
const put_metric_data = @import("put_metric_data.zig");
const put_metric_stream = @import("put_metric_stream.zig");
const set_alarm_state = @import("set_alarm_state.zig");
const start_metric_streams = @import("start_metric_streams.zig");
const stop_metric_streams = @import("stop_metric_streams.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "CloudWatch";

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

    /// Deletes the specified alarms. You can delete up to 100 alarms in one
    /// operation.
    /// However, this total can include no more than one composite alarm. For
    /// example, you could
    /// delete 99 metric alarms and one composite alarms with one operation, but you
    /// can't
    /// delete two composite alarms with one operation.
    ///
    /// If you specify any incorrect alarm names, the alarms you specify with
    /// correct names are still deleted. Other syntax errors might result
    /// in no alarms being deleted. To confirm that alarms were deleted
    /// successfully, you can use the
    /// [DescribeAlarms](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_DescribeAlarms.html) operation after using `DeleteAlarms`.
    ///
    /// It is possible to create a loop or cycle of composite alarms, where
    /// composite
    /// alarm A depends on composite alarm B, and composite alarm B also depends on
    /// composite alarm A. In this scenario, you can't delete any composite alarm
    /// that is
    /// part of the cycle because there is always still a composite alarm that
    /// depends on
    /// that alarm that you want to delete.
    ///
    /// To get out of such a situation, you must break the cycle by changing the
    /// rule of
    /// one of the composite alarms in the cycle to remove a dependency that creates
    /// the
    /// cycle. The simplest change to make to break a cycle is to change the
    /// `AlarmRule` of one of the alarms to `false`.
    ///
    /// Additionally, the evaluation of composite alarms stops if CloudWatch
    /// detects a cycle in the evaluation path.
    pub fn deleteAlarms(self: *Self, allocator: std.mem.Allocator, input: delete_alarms.DeleteAlarmsInput, options: delete_alarms.Options) !delete_alarms.DeleteAlarmsOutput {
        return delete_alarms.execute(self, allocator, input, options);
    }

    /// Deletes the specified anomaly detection model from your account. For more
    /// information
    /// about how to delete an anomaly detection model, see [Deleting an anomaly
    /// detection
    /// model](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Create_Anomaly_Detection_Alarm.html#Delete_Anomaly_Detection_Model) in the *CloudWatch User
    /// Guide*.
    pub fn deleteAnomalyDetector(self: *Self, allocator: std.mem.Allocator, input: delete_anomaly_detector.DeleteAnomalyDetectorInput, options: delete_anomaly_detector.Options) !delete_anomaly_detector.DeleteAnomalyDetectorOutput {
        return delete_anomaly_detector.execute(self, allocator, input, options);
    }

    /// Deletes all dashboards that you specify. You can specify up to 100
    /// dashboards to
    /// delete. If there is an error during this call, no dashboards are deleted.
    pub fn deleteDashboards(self: *Self, allocator: std.mem.Allocator, input: delete_dashboards.DeleteDashboardsInput, options: delete_dashboards.Options) !delete_dashboards.DeleteDashboardsOutput {
        return delete_dashboards.execute(self, allocator, input, options);
    }

    /// Permanently deletes the specified Contributor Insights rules.
    ///
    /// If you create a rule, delete it, and then re-create it with the same name,
    /// historical
    /// data from the first time the rule was created might not be available.
    pub fn deleteInsightRules(self: *Self, allocator: std.mem.Allocator, input: delete_insight_rules.DeleteInsightRulesInput, options: delete_insight_rules.Options) !delete_insight_rules.DeleteInsightRulesOutput {
        return delete_insight_rules.execute(self, allocator, input, options);
    }

    /// Permanently deletes the metric stream that you specify.
    pub fn deleteMetricStream(self: *Self, allocator: std.mem.Allocator, input: delete_metric_stream.DeleteMetricStreamInput, options: delete_metric_stream.Options) !delete_metric_stream.DeleteMetricStreamOutput {
        return delete_metric_stream.execute(self, allocator, input, options);
    }

    /// Returns the information of the current alarm contributors that are in
    /// `ALARM` state. This operation returns details about the individual time
    /// series that contribute to the alarm's state.
    pub fn describeAlarmContributors(self: *Self, allocator: std.mem.Allocator, input: describe_alarm_contributors.DescribeAlarmContributorsInput, options: describe_alarm_contributors.Options) !describe_alarm_contributors.DescribeAlarmContributorsOutput {
        return describe_alarm_contributors.execute(self, allocator, input, options);
    }

    /// Retrieves the history for the specified alarm. You can filter the results by
    /// date
    /// range or item type. If an alarm name is not specified, the histories for
    /// either all
    /// metric alarms or all composite alarms are returned.
    ///
    /// CloudWatch retains the history of an alarm even if you delete the alarm.
    ///
    /// To use this operation and return information about a composite alarm, you
    /// must be
    /// signed on with the `cloudwatch:DescribeAlarmHistory` permission that is
    /// scoped to `*`. You can't return information about composite alarms if your
    /// `cloudwatch:DescribeAlarmHistory` permission has a narrower scope.
    pub fn describeAlarmHistory(self: *Self, allocator: std.mem.Allocator, input: describe_alarm_history.DescribeAlarmHistoryInput, options: describe_alarm_history.Options) !describe_alarm_history.DescribeAlarmHistoryOutput {
        return describe_alarm_history.execute(self, allocator, input, options);
    }

    /// Retrieves the specified alarms. You can filter the results by specifying a
    /// prefix
    /// for the alarm name, the alarm state, or a prefix for any action.
    ///
    /// To use this operation and return information about composite alarms, you
    /// must be
    /// signed on with the `cloudwatch:DescribeAlarms` permission that is scoped to
    /// `*`. You can't return information about composite alarms if your
    /// `cloudwatch:DescribeAlarms` permission has a narrower scope.
    pub fn describeAlarms(self: *Self, allocator: std.mem.Allocator, input: describe_alarms.DescribeAlarmsInput, options: describe_alarms.Options) !describe_alarms.DescribeAlarmsOutput {
        return describe_alarms.execute(self, allocator, input, options);
    }

    /// Retrieves the alarms for the specified metric. To filter the results,
    /// specify a
    /// statistic, period, or unit.
    ///
    /// This operation retrieves only standard alarms that are based on the
    /// specified
    /// metric. It does not return alarms based on math expressions that use the
    /// specified
    /// metric, or composite alarms that use the specified metric.
    pub fn describeAlarmsForMetric(self: *Self, allocator: std.mem.Allocator, input: describe_alarms_for_metric.DescribeAlarmsForMetricInput, options: describe_alarms_for_metric.Options) !describe_alarms_for_metric.DescribeAlarmsForMetricOutput {
        return describe_alarms_for_metric.execute(self, allocator, input, options);
    }

    /// Lists the anomaly detection models that you have created in your account.
    /// For single
    /// metric anomaly detectors, you can list all of the models in your account or
    /// filter the
    /// results to only the models that are related to a certain namespace, metric
    /// name, or
    /// metric dimension. For metric math anomaly detectors, you can list them by
    /// adding
    /// `METRIC_MATH` to the `AnomalyDetectorTypes` array. This will
    /// return all metric math anomaly detectors in your account.
    pub fn describeAnomalyDetectors(self: *Self, allocator: std.mem.Allocator, input: describe_anomaly_detectors.DescribeAnomalyDetectorsInput, options: describe_anomaly_detectors.Options) !describe_anomaly_detectors.DescribeAnomalyDetectorsOutput {
        return describe_anomaly_detectors.execute(self, allocator, input, options);
    }

    /// Returns a list of all the Contributor Insights rules in your account.
    ///
    /// For more information about Contributor Insights, see [Using Contributor
    /// Insights to Analyze High-Cardinality
    /// Data](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/ContributorInsights.html).
    pub fn describeInsightRules(self: *Self, allocator: std.mem.Allocator, input: describe_insight_rules.DescribeInsightRulesInput, options: describe_insight_rules.Options) !describe_insight_rules.DescribeInsightRulesOutput {
        return describe_insight_rules.execute(self, allocator, input, options);
    }

    /// Disables the actions for the specified alarms. When an alarm's actions are
    /// disabled, the alarm actions do not execute when the alarm state changes.
    pub fn disableAlarmActions(self: *Self, allocator: std.mem.Allocator, input: disable_alarm_actions.DisableAlarmActionsInput, options: disable_alarm_actions.Options) !disable_alarm_actions.DisableAlarmActionsOutput {
        return disable_alarm_actions.execute(self, allocator, input, options);
    }

    /// Disables the specified Contributor Insights rules. When rules are disabled,
    /// they do
    /// not analyze log groups and do not incur costs.
    pub fn disableInsightRules(self: *Self, allocator: std.mem.Allocator, input: disable_insight_rules.DisableInsightRulesInput, options: disable_insight_rules.Options) !disable_insight_rules.DisableInsightRulesOutput {
        return disable_insight_rules.execute(self, allocator, input, options);
    }

    /// Enables the actions for the specified alarms.
    pub fn enableAlarmActions(self: *Self, allocator: std.mem.Allocator, input: enable_alarm_actions.EnableAlarmActionsInput, options: enable_alarm_actions.Options) !enable_alarm_actions.EnableAlarmActionsOutput {
        return enable_alarm_actions.execute(self, allocator, input, options);
    }

    /// Enables the specified Contributor Insights rules. When rules are enabled,
    /// they
    /// immediately begin analyzing log data.
    pub fn enableInsightRules(self: *Self, allocator: std.mem.Allocator, input: enable_insight_rules.EnableInsightRulesInput, options: enable_insight_rules.Options) !enable_insight_rules.EnableInsightRulesOutput {
        return enable_insight_rules.execute(self, allocator, input, options);
    }

    /// Displays the details of the dashboard that you specify.
    ///
    /// To copy an existing dashboard, use `GetDashboard`, and then use the data
    /// returned within `DashboardBody` as the template for the new dashboard when
    /// you call `PutDashboard` to create the copy.
    pub fn getDashboard(self: *Self, allocator: std.mem.Allocator, input: get_dashboard.GetDashboardInput, options: get_dashboard.Options) !get_dashboard.GetDashboardOutput {
        return get_dashboard.execute(self, allocator, input, options);
    }

    /// This operation returns the time series data collected by a Contributor
    /// Insights rule.
    /// The data includes the identity and number of contributors to the log group.
    ///
    /// You can also optionally return one or more statistics about each data point
    /// in the
    /// time series. These statistics can include the following:
    ///
    /// * `UniqueContributors` -- the number of unique contributors for each
    /// data point.
    ///
    /// * `MaxContributorValue` -- the value of the top contributor for each
    /// data point. The identity of the contributor might change for each data point
    /// in
    /// the graph.
    ///
    /// If this rule aggregates by COUNT, the top contributor for each data point is
    /// the contributor with the most occurrences in that period. If the rule
    /// aggregates
    /// by SUM, the top contributor is the contributor with the highest sum in the
    /// log
    /// field specified by the rule's `Value`, during that period.
    ///
    /// * `SampleCount` -- the number of data points matched by the
    /// rule.
    ///
    /// * `Sum` -- the sum of the values from all contributors during the
    /// time period represented by that data point.
    ///
    /// * `Minimum` -- the minimum value from a single observation during the
    /// time period represented by that data point.
    ///
    /// * `Maximum` -- the maximum value from a single observation during the
    /// time period represented by that data point.
    ///
    /// * `Average` -- the average value from all contributors during the
    /// time period represented by that data point.
    pub fn getInsightRuleReport(self: *Self, allocator: std.mem.Allocator, input: get_insight_rule_report.GetInsightRuleReportInput, options: get_insight_rule_report.Options) !get_insight_rule_report.GetInsightRuleReportOutput {
        return get_insight_rule_report.execute(self, allocator, input, options);
    }

    /// You can use the `GetMetricData` API to retrieve CloudWatch metric
    /// values. The operation can also include a CloudWatch Metrics Insights query,
    /// and
    /// one or more metric math functions.
    ///
    /// A `GetMetricData` operation that does not include a query can retrieve
    /// as many as 500 different metrics in a single request, with a total of as
    /// many as 100,800
    /// data points. You can also optionally perform metric math expressions on the
    /// values of
    /// the returned statistics, to create new time series that represent new
    /// insights into your
    /// data. For example, using Lambda metrics, you could divide the Errors metric
    /// by the
    /// Invocations metric to get an error rate time series. For more information
    /// about metric
    /// math expressions, see [Metric Math Syntax and
    /// Functions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html#metric-math-syntax) in the *Amazon CloudWatch User
    /// Guide*.
    ///
    /// If you include a Metrics Insights query, each `GetMetricData` operation can
    /// include only one query. But the same `GetMetricData` operation can also
    /// retrieve other metrics. Metrics Insights queries can query only the most
    /// recent three
    /// hours of metric data. For more information about Metrics Insights, see
    /// [Query your metrics with CloudWatch Metrics
    /// Insights](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/query_with_cloudwatch-metrics-insights.html).
    ///
    /// Calls to the `GetMetricData` API have a different pricing structure than
    /// calls to `GetMetricStatistics`. For more information about pricing, see
    /// [Amazon CloudWatch
    /// Pricing](https://aws.amazon.com/cloudwatch/pricing/).
    ///
    /// Amazon CloudWatch retains metric data as follows:
    ///
    /// * Data points with a period of less than 60 seconds are available for 3
    /// hours. These data points are high-resolution metrics and are available only
    /// for
    /// custom metrics that have been defined with a `StorageResolution` of
    /// 1.
    ///
    /// * Data points with a period of 60 seconds (1-minute) are available for 15
    /// days.
    ///
    /// * Data points with a period of 300 seconds (5-minute) are available for 63
    /// days.
    ///
    /// * Data points with a period of 3600 seconds (1 hour) are available for 455
    /// days (15 months).
    ///
    /// Data points that are initially published with a shorter period are
    /// aggregated
    /// together for long-term storage. For example, if you collect data using a
    /// period of 1
    /// minute, the data remains available for 15 days with 1-minute resolution.
    /// After 15 days,
    /// this data is still available, but is aggregated and retrievable only with a
    /// resolution
    /// of 5 minutes. After 63 days, the data is further aggregated and is available
    /// with a
    /// resolution of 1 hour.
    ///
    /// If you omit `Unit` in your request, all data that was collected with any
    /// unit is returned, along with the corresponding units that were specified
    /// when the data
    /// was reported to CloudWatch. If you specify a unit, the operation returns
    /// only data that
    /// was collected with that unit specified. If you specify a unit that does not
    /// match the
    /// data collected, the results of the operation are null. CloudWatch does not
    /// perform unit
    /// conversions.
    ///
    /// **Using Metrics Insights queries with metric
    /// math**
    ///
    /// You can't mix a Metric Insights query and metric math syntax in the same
    /// expression,
    /// but you can reference results from a Metrics Insights query within other
    /// Metric math
    /// expressions. A Metrics Insights query without a **GROUP
    /// BY** clause returns a single time-series (TS), and can be used as input for
    /// a metric math expression that expects a single time series. A Metrics
    /// Insights query
    /// with a **GROUP BY** clause returns an array of time-series
    /// (TS[]), and can be used as input for a metric math expression that expects
    /// an array of
    /// time series.
    pub fn getMetricData(self: *Self, allocator: std.mem.Allocator, input: get_metric_data.GetMetricDataInput, options: get_metric_data.Options) !get_metric_data.GetMetricDataOutput {
        return get_metric_data.execute(self, allocator, input, options);
    }

    /// Gets statistics for the specified metric.
    ///
    /// The maximum number of data points returned from a single call is 1,440. If
    /// you
    /// request more than 1,440 data points, CloudWatch returns an error. To reduce
    /// the number
    /// of data points, you can narrow the specified time range and make multiple
    /// requests
    /// across adjacent time ranges, or you can increase the specified period. Data
    /// points are
    /// not returned in chronological order.
    ///
    /// CloudWatch aggregates data points based on the length of the period that you
    /// specify. For example, if you request statistics with a one-hour period,
    /// CloudWatch
    /// aggregates all data points with time stamps that fall within each one-hour
    /// period.
    /// Therefore, the number of values aggregated by CloudWatch is larger than the
    /// number of
    /// data points returned.
    ///
    /// CloudWatch needs raw data points to calculate percentile statistics. If you
    /// publish
    /// data using a statistic set instead, you can only retrieve percentile
    /// statistics for this
    /// data if one of the following conditions is true:
    ///
    /// * The SampleCount value of the statistic set is 1.
    ///
    /// * The Min and the Max values of the statistic set are equal.
    ///
    /// Percentile statistics are not available for metrics when any of the metric
    /// values
    /// are negative numbers.
    ///
    /// Amazon CloudWatch retains metric data as follows:
    ///
    /// * Data points with a period of less than 60 seconds are available for 3
    /// hours. These data points are high-resolution metrics and are available only
    /// for
    /// custom metrics that have been defined with a `StorageResolution` of
    /// 1.
    ///
    /// * Data points with a period of 60 seconds (1-minute) are available for 15
    /// days.
    ///
    /// * Data points with a period of 300 seconds (5-minute) are available for 63
    /// days.
    ///
    /// * Data points with a period of 3600 seconds (1 hour) are available for 455
    /// days (15 months).
    ///
    /// Data points that are initially published with a shorter period are
    /// aggregated
    /// together for long-term storage. For example, if you collect data using a
    /// period of 1
    /// minute, the data remains available for 15 days with 1-minute resolution.
    /// After 15 days,
    /// this data is still available, but is aggregated and retrievable only with a
    /// resolution
    /// of 5 minutes. After 63 days, the data is further aggregated and is available
    /// with a
    /// resolution of 1 hour.
    ///
    /// CloudWatch started retaining 5-minute and 1-hour metric data as of July 9,
    /// 2016.
    ///
    /// For information about metrics and dimensions supported by Amazon Web
    /// Services
    /// services, see the [Amazon CloudWatch
    /// Metrics and Dimensions
    /// Reference](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CW_Support_For_AWS.html) in the *Amazon CloudWatch User
    /// Guide*.
    pub fn getMetricStatistics(self: *Self, allocator: std.mem.Allocator, input: get_metric_statistics.GetMetricStatisticsInput, options: get_metric_statistics.Options) !get_metric_statistics.GetMetricStatisticsOutput {
        return get_metric_statistics.execute(self, allocator, input, options);
    }

    /// Returns information about the metric stream that you specify.
    pub fn getMetricStream(self: *Self, allocator: std.mem.Allocator, input: get_metric_stream.GetMetricStreamInput, options: get_metric_stream.Options) !get_metric_stream.GetMetricStreamOutput {
        return get_metric_stream.execute(self, allocator, input, options);
    }

    /// You can use the `GetMetricWidgetImage` API to retrieve a snapshot graph
    /// of one or more Amazon CloudWatch metrics as a bitmap image. You can then
    /// embed this
    /// image into your services and products, such as wiki pages, reports, and
    /// documents. You
    /// could also retrieve images regularly, such as every minute, and create your
    /// own custom
    /// live dashboard.
    ///
    /// The graph you retrieve can include all CloudWatch metric graph features,
    /// including
    /// metric math and horizontal and vertical annotations.
    ///
    /// There is a limit of 20 transactions per second for this API. Each
    /// `GetMetricWidgetImage` action has the following limits:
    ///
    /// * As many as 100 metrics in the graph.
    ///
    /// * Up to 100 KB uncompressed payload.
    pub fn getMetricWidgetImage(self: *Self, allocator: std.mem.Allocator, input: get_metric_widget_image.GetMetricWidgetImageInput, options: get_metric_widget_image.Options) !get_metric_widget_image.GetMetricWidgetImageOutput {
        return get_metric_widget_image.execute(self, allocator, input, options);
    }

    /// Returns a list of the dashboards for your account. If you include
    /// `DashboardNamePrefix`, only those dashboards with names starting with the
    /// prefix are listed. Otherwise, all dashboards in your account are listed.
    ///
    /// `ListDashboards` returns up to 1000 results on one page. If there are
    /// more than 1000 dashboards, you can call `ListDashboards` again and include
    /// the value you received for `NextToken` in the first call, to receive the
    /// next
    /// 1000 results.
    pub fn listDashboards(self: *Self, allocator: std.mem.Allocator, input: list_dashboards.ListDashboardsInput, options: list_dashboards.Options) !list_dashboards.ListDashboardsOutput {
        return list_dashboards.execute(self, allocator, input, options);
    }

    /// Returns a list that contains the number of managed Contributor Insights
    /// rules in your
    /// account.
    pub fn listManagedInsightRules(self: *Self, allocator: std.mem.Allocator, input: list_managed_insight_rules.ListManagedInsightRulesInput, options: list_managed_insight_rules.Options) !list_managed_insight_rules.ListManagedInsightRulesOutput {
        return list_managed_insight_rules.execute(self, allocator, input, options);
    }

    /// Returns a list of metric streams in this account.
    pub fn listMetricStreams(self: *Self, allocator: std.mem.Allocator, input: list_metric_streams.ListMetricStreamsInput, options: list_metric_streams.Options) !list_metric_streams.ListMetricStreamsOutput {
        return list_metric_streams.execute(self, allocator, input, options);
    }

    /// List the specified metrics. You can use the returned metrics with
    /// [GetMetricData](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_GetMetricData.html) or [GetMetricStatistics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_GetMetricStatistics.html) to get statistical data.
    ///
    /// Up to 500 results are returned for any one call. To retrieve additional
    /// results,
    /// use the returned token with subsequent calls.
    ///
    /// After you create a metric, allow up to 15 minutes for the metric to appear.
    /// To see
    /// metric statistics sooner, use
    /// [GetMetricData](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_GetMetricData.html) or [GetMetricStatistics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_GetMetricStatistics.html).
    ///
    /// If you are using CloudWatch cross-account observability, you can use this
    /// operation in a monitoring account and view metrics from the linked source
    /// accounts. For
    /// more information, see [CloudWatch cross-account
    /// observability](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Unified-Cross-Account.html).
    ///
    /// `ListMetrics` doesn't return information about metrics if those metrics
    /// haven't reported data in the past two weeks. To retrieve those metrics, use
    /// [GetMetricData](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_GetMetricData.html) or [GetMetricStatistics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_GetMetricStatistics.html).
    pub fn listMetrics(self: *Self, allocator: std.mem.Allocator, input: list_metrics.ListMetricsInput, options: list_metrics.Options) !list_metrics.ListMetricsOutput {
        return list_metrics.execute(self, allocator, input, options);
    }

    /// Displays the tags associated with a CloudWatch resource. Currently, alarms
    /// and
    /// Contributor Insights rules support tagging.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates an anomaly detection model for a CloudWatch metric. You can use the
    /// model to
    /// display a band of expected normal values when the metric is graphed.
    ///
    /// If you have enabled unified cross-account observability, and this account is
    /// a
    /// monitoring account, the metric can be in the same account or a source
    /// account. You can
    /// specify the account ID in the object you specify in the
    /// `SingleMetricAnomalyDetector` parameter.
    ///
    /// For more information, see [CloudWatch Anomaly
    /// Detection](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Anomaly_Detection.html).
    pub fn putAnomalyDetector(self: *Self, allocator: std.mem.Allocator, input: put_anomaly_detector.PutAnomalyDetectorInput, options: put_anomaly_detector.Options) !put_anomaly_detector.PutAnomalyDetectorOutput {
        return put_anomaly_detector.execute(self, allocator, input, options);
    }

    /// Creates or updates a *composite alarm*. When you create a composite
    /// alarm, you specify a rule expression for the alarm that takes into account
    /// the alarm
    /// states of other alarms that you have created. The composite alarm goes into
    /// ALARM state
    /// only if all conditions of the rule are met.
    ///
    /// The alarms specified in a composite alarm's rule expression can include
    /// metric alarms
    /// and other composite alarms. The rule expression of a composite alarm can
    /// include as many
    /// as 100 underlying alarms. Any single alarm can be included in the rule
    /// expressions of as
    /// many as 150 composite alarms.
    ///
    /// Using composite alarms can reduce alarm noise. You can create multiple
    /// metric alarms,
    /// and also create a composite alarm and set up alerts only for the composite
    /// alarm. For
    /// example, you could create a composite alarm that goes into ALARM state only
    /// when more
    /// than one of the underlying metric alarms are in ALARM state.
    ///
    /// Composite alarms can take the following actions:
    ///
    /// * Notify Amazon SNS topics.
    ///
    /// * Invoke Lambda functions.
    ///
    /// * Create OpsItems in Systems Manager Ops Center.
    ///
    /// * Create incidents in Systems Manager Incident Manager.
    ///
    /// It is possible to create a loop or cycle of composite alarms, where
    /// composite
    /// alarm A depends on composite alarm B, and composite alarm B also depends on
    /// composite alarm A. In this scenario, you can't delete any composite alarm
    /// that is
    /// part of the cycle because there is always still a composite alarm that
    /// depends on
    /// that alarm that you want to delete.
    ///
    /// To get out of such a situation, you must break the cycle by changing the
    /// rule of
    /// one of the composite alarms in the cycle to remove a dependency that creates
    /// the
    /// cycle. The simplest change to make to break a cycle is to change the
    /// `AlarmRule` of one of the alarms to `false`.
    ///
    /// Additionally, the evaluation of composite alarms stops if CloudWatch detects
    /// a
    /// cycle in the evaluation path.
    ///
    /// When this operation creates an alarm, the alarm state is immediately set to
    /// `INSUFFICIENT_DATA`. The alarm is then evaluated and its state is set
    /// appropriately. Any actions associated with the new state are then executed.
    /// For a
    /// composite alarm, this initial time after creation is the only time that the
    /// alarm can be
    /// in `INSUFFICIENT_DATA` state.
    ///
    /// When you update an existing alarm, its state is left unchanged, but the
    /// update
    /// completely overwrites the previous configuration of the alarm.
    ///
    /// To use this operation, you must be signed on with the
    /// `cloudwatch:PutCompositeAlarm` permission that is scoped to
    /// `*`. You can't create a composite alarms if your
    /// `cloudwatch:PutCompositeAlarm` permission has a narrower scope.
    ///
    /// If you are an IAM user, you must have
    /// `iam:CreateServiceLinkedRole` to create a composite alarm that has
    /// Systems Manager OpsItem actions.
    pub fn putCompositeAlarm(self: *Self, allocator: std.mem.Allocator, input: put_composite_alarm.PutCompositeAlarmInput, options: put_composite_alarm.Options) !put_composite_alarm.PutCompositeAlarmOutput {
        return put_composite_alarm.execute(self, allocator, input, options);
    }

    /// Creates a dashboard if it does not already exist, or updates an existing
    /// dashboard.
    /// If you update a dashboard, the entire contents are replaced with what you
    /// specify
    /// here.
    ///
    /// All dashboards in your account are global, not region-specific.
    ///
    /// A simple way to create a dashboard using `PutDashboard` is to copy an
    /// existing dashboard. To copy an existing dashboard using the console, you can
    /// load the
    /// dashboard and then use the View/edit source command in the Actions menu to
    /// display the
    /// JSON block for that dashboard. Another way to copy a dashboard is to use
    /// `GetDashboard`, and then use the data returned within
    /// `DashboardBody` as the template for the new dashboard when you call
    /// `PutDashboard`.
    ///
    /// When you create a dashboard with `PutDashboard`, a good practice is to
    /// add a text widget at the top of the dashboard with a message that the
    /// dashboard was
    /// created by script and should not be changed in the console. This message
    /// could also
    /// point console users to the location of the `DashboardBody` script or the
    /// CloudFormation template used to create the dashboard.
    pub fn putDashboard(self: *Self, allocator: std.mem.Allocator, input: put_dashboard.PutDashboardInput, options: put_dashboard.Options) !put_dashboard.PutDashboardOutput {
        return put_dashboard.execute(self, allocator, input, options);
    }

    /// Creates a Contributor Insights rule. Rules evaluate log events in a
    /// CloudWatch Logs
    /// log group, enabling you to find contributor data for the log events in that
    /// log group.
    /// For more information, see [Using Contributor
    /// Insights to Analyze High-Cardinality
    /// Data](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/ContributorInsights.html).
    ///
    /// If you create a rule, delete it, and then re-create it with the same name,
    /// historical
    /// data from the first time the rule was created might not be available.
    pub fn putInsightRule(self: *Self, allocator: std.mem.Allocator, input: put_insight_rule.PutInsightRuleInput, options: put_insight_rule.Options) !put_insight_rule.PutInsightRuleOutput {
        return put_insight_rule.execute(self, allocator, input, options);
    }

    /// Creates a managed Contributor Insights rule for a specified Amazon Web
    /// Services
    /// resource. When you enable a managed rule, you create a Contributor Insights
    /// rule that
    /// collects data from Amazon Web Services services. You cannot edit these rules
    /// with
    /// `PutInsightRule`. The rules can be enabled, disabled, and deleted using
    /// `EnableInsightRules`, `DisableInsightRules`, and
    /// `DeleteInsightRules`. If a previously created managed rule is currently
    /// disabled, a subsequent call to this API will re-enable it. Use
    /// `ListManagedInsightRules` to describe all available rules.
    pub fn putManagedInsightRules(self: *Self, allocator: std.mem.Allocator, input: put_managed_insight_rules.PutManagedInsightRulesInput, options: put_managed_insight_rules.Options) !put_managed_insight_rules.PutManagedInsightRulesOutput {
        return put_managed_insight_rules.execute(self, allocator, input, options);
    }

    /// Creates or updates an alarm and associates it with the specified metric,
    /// metric
    /// math expression, anomaly detection model, or Metrics Insights query. For
    /// more
    /// information about using a Metrics Insights query for an alarm, see [Create
    /// alarms on Metrics Insights
    /// queries](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Create_Metrics_Insights_Alarm.html).
    ///
    /// Alarms based on anomaly detection models cannot have Auto Scaling actions.
    ///
    /// When this operation creates an alarm, the alarm state is immediately set to
    /// `INSUFFICIENT_DATA`. The alarm is then evaluated and its state is set
    /// appropriately. Any actions associated with the new state are then executed.
    ///
    /// When you update an existing alarm, its state is left unchanged, but the
    /// update
    /// completely overwrites the previous configuration of the alarm.
    ///
    /// If you are an IAM user, you must have Amazon EC2 permissions for
    /// some alarm operations:
    ///
    /// * The `iam:CreateServiceLinkedRole` permission for all alarms with
    /// EC2 actions
    ///
    /// * The `iam:CreateServiceLinkedRole` permissions to create an alarm
    /// with Systems Manager OpsItem or response plan actions.
    ///
    /// The first time you create an alarm in the Amazon Web Services Management
    /// Console, the CLI, or by using the PutMetricAlarm API, CloudWatch creates the
    /// necessary
    /// service-linked role for you. The service-linked roles are called
    /// `AWSServiceRoleForCloudWatchEvents` and
    /// `AWSServiceRoleForCloudWatchAlarms_ActionSSM`. For more information, see
    /// [Amazon Web Services service-linked
    /// role](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_terms-and-concepts.html#iam-term-service-linked-role).
    ///
    /// Each `PutMetricAlarm` action has a maximum uncompressed payload of 120
    /// KB.
    ///
    /// **Cross-account alarms**
    ///
    /// You can set an alarm on metrics in the current account, or in another
    /// account. To
    /// create a cross-account alarm that watches a metric in a different account,
    /// you must have
    /// completed the following pre-requisites:
    ///
    /// * The account where the metrics are located (the *sharing
    /// account*) must already have a sharing role named
    /// **CloudWatch-CrossAccountSharingRole**. If it does not
    /// already have this role, you must create it using the instructions in **Set
    /// up a sharing account** in [ Cross-account cross-Region CloudWatch
    /// console](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Cross-Account-Cross-Region.html#enable-cross-account-cross-Region). The policy
    /// for that role must grant access to the ID of the account where you are
    /// creating
    /// the alarm.
    ///
    /// * The account where you are creating the alarm (the *monitoring
    /// account*) must already have a service-linked role named
    /// **AWSServiceRoleForCloudWatchCrossAccount** to allow
    /// CloudWatch to assume the sharing role in the sharing account. If it
    /// does not, you must create it following the directions in **Set up a
    /// monitoring account** in [ Cross-account cross-Region CloudWatch
    /// console](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Cross-Account-Cross-Region.html#enable-cross-account-cross-Region).
    pub fn putMetricAlarm(self: *Self, allocator: std.mem.Allocator, input: put_metric_alarm.PutMetricAlarmInput, options: put_metric_alarm.Options) !put_metric_alarm.PutMetricAlarmOutput {
        return put_metric_alarm.execute(self, allocator, input, options);
    }

    /// Publishes metric data to Amazon CloudWatch. CloudWatch associates the data
    /// with the
    /// specified metric. If the specified metric does not exist, CloudWatch creates
    /// the metric.
    /// When CloudWatch creates a metric, it can take up to fifteen minutes for the
    /// metric to
    /// appear in calls to
    /// [ListMetrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_ListMetrics.html).
    ///
    /// You can publish metrics with associated entity data (so that related
    /// telemetry can be
    /// found and viewed together), or publish metric data by itself. To send entity
    /// data with
    /// your metrics, use the `EntityMetricData` parameter. To send metrics without
    /// entity data, use the `MetricData` parameter. The
    /// `EntityMetricData` structure includes `MetricData` structures
    /// for the metric data.
    ///
    /// You can publish either individual values in the `Value` field, or arrays of
    /// values and the number of times each value occurred during the period by
    /// using the
    /// `Values` and `Counts` fields in the `MetricData`
    /// structure. Using the `Values` and `Counts` method enables you to
    /// publish up to 150 values per metric with one `PutMetricData` request, and
    /// supports retrieving percentile statistics on this data.
    ///
    /// Each `PutMetricData` request is limited to 1 MB in size for HTTP POST
    /// requests. You can send a payload compressed by gzip. Each request is also
    /// limited to no
    /// more than 1000 different metrics (across both the `MetricData` and
    /// `EntityMetricData` properties).
    ///
    /// Although the `Value` parameter accepts numbers of type `Double`,
    /// CloudWatch rejects values that are either too small or too large. Values
    /// must be in the
    /// range of -2^360 to 2^360. In addition, special values (for example, NaN,
    /// +Infinity,
    /// -Infinity) are not supported.
    ///
    /// You can use up to 30 dimensions per metric to further clarify what data the
    /// metric
    /// collects. Each dimension consists of a Name and Value pair. For more
    /// information about
    /// specifying dimensions, see [Publishing
    /// Metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/publishingMetrics.html) in the *Amazon CloudWatch User Guide*.
    ///
    /// You specify the time stamp to be associated with each data point. You can
    /// specify time
    /// stamps that are as much as two weeks before the current date, and as much as
    /// 2 hours
    /// after the current day and time.
    ///
    /// Data points with time stamps from 24 hours ago or longer can take at least
    /// 48 hours to
    /// become available for
    /// [GetMetricData](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_GetMetricData.html) or [GetMetricStatistics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_GetMetricStatistics.html) from the time they are submitted. Data points with time
    /// stamps between 3 and 24 hours ago can take as much as 2 hours to become
    /// available for
    /// [GetMetricData](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_GetMetricData.html) or [GetMetricStatistics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_GetMetricStatistics.html).
    ///
    /// CloudWatch needs raw data points to calculate percentile statistics. If you
    /// publish
    /// data using a statistic set instead, you can only retrieve percentile
    /// statistics for this
    /// data if one of the following conditions is true:
    ///
    /// * The `SampleCount` value of the statistic set is 1 and
    /// `Min`, `Max`, and `Sum` are all
    /// equal.
    ///
    /// * The `Min` and `Max` are equal, and `Sum`
    /// is equal to `Min` multiplied by `SampleCount`.
    pub fn putMetricData(self: *Self, allocator: std.mem.Allocator, input: put_metric_data.PutMetricDataInput, options: put_metric_data.Options) !put_metric_data.PutMetricDataOutput {
        return put_metric_data.execute(self, allocator, input, options);
    }

    /// Creates or updates a metric stream. Metric streams can automatically stream
    /// CloudWatch
    /// metrics to Amazon Web Services destinations, including Amazon S3, and to
    /// many third-party
    /// solutions.
    ///
    /// For more information, see [ Using
    /// Metric
    /// Streams](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Metric-Streams.html).
    ///
    /// To create a metric stream, you must be signed in to an account that has the
    /// `iam:PassRole` permission and either the
    /// `CloudWatchFullAccess` policy or the
    /// `cloudwatch:PutMetricStream` permission.
    ///
    /// When you create or update a metric stream, you choose one of the following:
    ///
    /// * Stream metrics from all metric namespaces in the account.
    ///
    /// * Stream metrics from all metric namespaces in the account, except for the
    /// namespaces that you list in `ExcludeFilters`.
    ///
    /// * Stream metrics from only the metric namespaces that you list in
    /// `IncludeFilters`.
    ///
    /// By default, a metric stream always sends the `MAX`, `MIN`,
    /// `SUM`, and `SAMPLECOUNT` statistics for each metric that is
    /// streamed. You can use the `StatisticsConfigurations` parameter to have the
    /// metric stream send additional statistics in the stream. Streaming additional
    /// statistics
    /// incurs additional costs. For more information, see [Amazon CloudWatch
    /// Pricing](https://aws.amazon.com/cloudwatch/pricing/).
    ///
    /// When you use `PutMetricStream` to create a new metric stream, the stream is
    /// created in the `running` state. If you use it to update an existing stream,
    /// the state of the stream is not changed.
    ///
    /// If you are using CloudWatch cross-account observability and you create a
    /// metric
    /// stream in a monitoring account, you can choose whether to include metrics
    /// from source
    /// accounts in the stream. For more information, see [CloudWatch cross-account
    /// observability](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Unified-Cross-Account.html).
    pub fn putMetricStream(self: *Self, allocator: std.mem.Allocator, input: put_metric_stream.PutMetricStreamInput, options: put_metric_stream.Options) !put_metric_stream.PutMetricStreamOutput {
        return put_metric_stream.execute(self, allocator, input, options);
    }

    /// Temporarily sets the state of an alarm for testing purposes. When the
    /// updated state
    /// differs from the previous value, the action configured for the appropriate
    /// state is
    /// invoked. For example, if your alarm is configured to send an Amazon SNS
    /// message when an
    /// alarm is triggered, temporarily changing the alarm state to `ALARM` sends an
    /// SNS message.
    ///
    /// Metric alarms returns to their actual state quickly, often within seconds.
    /// Because
    /// the metric alarm state change happens quickly, it is typically only visible
    /// in the
    /// alarm's **History** tab in the Amazon CloudWatch console or
    /// through
    /// [DescribeAlarmHistory](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_DescribeAlarmHistory.html).
    ///
    /// If you use `SetAlarmState` on a composite alarm, the composite alarm is
    /// not guaranteed to return to its actual state. It returns to its actual state
    /// only once
    /// any of its children alarms change state. It is also reevaluated if you
    /// update its
    /// configuration.
    ///
    /// If an alarm triggers EC2 Auto Scaling policies or application Auto Scaling
    /// policies, you must include information in the `StateReasonData` parameter to
    /// enable the policy to take the correct action.
    pub fn setAlarmState(self: *Self, allocator: std.mem.Allocator, input: set_alarm_state.SetAlarmStateInput, options: set_alarm_state.Options) !set_alarm_state.SetAlarmStateOutput {
        return set_alarm_state.execute(self, allocator, input, options);
    }

    /// Starts the streaming of metrics for one or more of your metric streams.
    pub fn startMetricStreams(self: *Self, allocator: std.mem.Allocator, input: start_metric_streams.StartMetricStreamsInput, options: start_metric_streams.Options) !start_metric_streams.StartMetricStreamsOutput {
        return start_metric_streams.execute(self, allocator, input, options);
    }

    /// Stops the streaming of metrics for one or more of your metric streams.
    pub fn stopMetricStreams(self: *Self, allocator: std.mem.Allocator, input: stop_metric_streams.StopMetricStreamsInput, options: stop_metric_streams.Options) !stop_metric_streams.StopMetricStreamsOutput {
        return stop_metric_streams.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags (key-value pairs) to the specified CloudWatch
    /// resource.
    /// Currently, the only CloudWatch resources that can be tagged are alarms and
    /// Contributor
    /// Insights rules.
    ///
    /// Tags can help you organize and categorize your resources. You can also use
    /// them to
    /// scope user permissions by granting a user permission to access or change
    /// only resources
    /// with certain tag values.
    ///
    /// Tags don't have any semantic meaning to Amazon Web Services and are
    /// interpreted
    /// strictly as strings of characters.
    ///
    /// You can use the `TagResource` action with an alarm that already has tags.
    /// If you specify a new tag key for the alarm, this tag is appended to the list
    /// of tags
    /// associated with the alarm. If you specify a tag key that is already
    /// associated with the
    /// alarm, the new tag value that you specify replaces the previous value for
    /// that
    /// tag.
    ///
    /// You can associate as many as 50 tags with a CloudWatch resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn describeAlarmHistoryPaginator(self: *Self, params: describe_alarm_history.DescribeAlarmHistoryInput) paginator.DescribeAlarmHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeAlarmsPaginator(self: *Self, params: describe_alarms.DescribeAlarmsInput) paginator.DescribeAlarmsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeAnomalyDetectorsPaginator(self: *Self, params: describe_anomaly_detectors.DescribeAnomalyDetectorsInput) paginator.DescribeAnomalyDetectorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInsightRulesPaginator(self: *Self, params: describe_insight_rules.DescribeInsightRulesInput) paginator.DescribeInsightRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getMetricDataPaginator(self: *Self, params: get_metric_data.GetMetricDataInput) paginator.GetMetricDataPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDashboardsPaginator(self: *Self, params: list_dashboards.ListDashboardsInput) paginator.ListDashboardsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listManagedInsightRulesPaginator(self: *Self, params: list_managed_insight_rules.ListManagedInsightRulesInput) paginator.ListManagedInsightRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMetricStreamsPaginator(self: *Self, params: list_metric_streams.ListMetricStreamsInput) paginator.ListMetricStreamsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMetricsPaginator(self: *Self, params: list_metrics.ListMetricsInput) paginator.ListMetricsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
