const aws = @import("aws");
const std = @import("std");

const batch_create_rum_metric_definitions = @import("batch_create_rum_metric_definitions.zig");
const batch_delete_rum_metric_definitions = @import("batch_delete_rum_metric_definitions.zig");
const batch_get_rum_metric_definitions = @import("batch_get_rum_metric_definitions.zig");
const create_app_monitor = @import("create_app_monitor.zig");
const delete_app_monitor = @import("delete_app_monitor.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const delete_rum_metrics_destination = @import("delete_rum_metrics_destination.zig");
const get_app_monitor = @import("get_app_monitor.zig");
const get_app_monitor_data = @import("get_app_monitor_data.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const list_app_monitors = @import("list_app_monitors.zig");
const list_rum_metrics_destinations = @import("list_rum_metrics_destinations.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const put_rum_events = @import("put_rum_events.zig");
const put_rum_metrics_destination = @import("put_rum_metrics_destination.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_app_monitor = @import("update_app_monitor.zig");
const update_rum_metric_definition = @import("update_rum_metric_definition.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "RUM";

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

    /// Specifies the extended metrics and custom metrics that you want a CloudWatch
    /// RUM app monitor to send to a destination. Valid destinations include
    /// CloudWatch and Evidently.
    ///
    /// By default, RUM app monitors send some metrics to CloudWatch. These default
    /// metrics are listed in [CloudWatch metrics that you can collect with
    /// CloudWatch
    /// RUM](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-RUM-metrics.html).
    ///
    /// In addition to these default metrics, you can choose to send extended
    /// metrics, custom metrics, or both.
    ///
    /// * Extended metrics let you send metrics with additional dimensions that
    ///   aren't included in the default metrics. You can also send extended metrics
    ///   to both Evidently and CloudWatch. The valid dimension names for the
    ///   additional dimensions for extended metrics are `BrowserName`,
    ///   `CountryCode`, `DeviceType`, `FileType`, `OSName`, and `PageId`. For more
    ///   information, see [ Extended metrics that you can send to CloudWatch and
    ///   CloudWatch
    ///   Evidently](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-RUM-vended-metrics.html).
    /// * Custom metrics are metrics that you define. You can send custom metrics to
    ///   CloudWatch. CloudWatch Evidently, or both. With custom metrics, you can
    ///   use any metric name and namespace. To derive the metrics, you can use any
    ///   custom events, built-in events, custom attributes, or default attributes.
    ///
    /// You can't send custom metrics to the `AWS/RUM` namespace. You must send
    /// custom metrics to a custom namespace that you define. The namespace that you
    /// use can't start with `AWS/`. CloudWatch RUM prepends `RUM/CustomMetrics/` to
    /// the custom namespace that you define, so the final namespace for your
    /// metrics in CloudWatch is `RUM/CustomMetrics/*your-custom-namespace* `.
    ///
    /// The maximum number of metric definitions that you can specify in one
    /// `BatchCreateRumMetricDefinitions` operation is 200.
    ///
    /// The maximum number of metric definitions that one destination can contain is
    /// 2000.
    ///
    /// Extended metrics sent to CloudWatch and RUM custom metrics are charged as
    /// CloudWatch custom metrics. Each combination of additional dimension name and
    /// dimension value counts as a custom metric. For more information, see [Amazon
    /// CloudWatch Pricing](https://aws.amazon.com/cloudwatch/pricing/).
    ///
    /// You must have already created a destination for the metrics before you send
    /// them. For more information, see
    /// [PutRumMetricsDestination](https://docs.aws.amazon.com/cloudwatchrum/latest/APIReference/API_PutRumMetricsDestination.html).
    ///
    /// If some metric definitions specified in a `BatchCreateRumMetricDefinitions`
    /// operations are not valid, those metric definitions fail and return errors,
    /// but all valid metric definitions in the same operation still succeed.
    pub fn batchCreateRumMetricDefinitions(self: *Self, allocator: std.mem.Allocator, input: batch_create_rum_metric_definitions.BatchCreateRumMetricDefinitionsInput, options: batch_create_rum_metric_definitions.Options) !batch_create_rum_metric_definitions.BatchCreateRumMetricDefinitionsOutput {
        return batch_create_rum_metric_definitions.execute(self, allocator, input, options);
    }

    /// Removes the specified metrics from being sent to an extended metrics
    /// destination.
    ///
    /// If some metric definition IDs specified in a
    /// `BatchDeleteRumMetricDefinitions` operations are not valid, those metric
    /// definitions fail and return errors, but all valid metric definition IDs in
    /// the same operation are still deleted.
    ///
    /// The maximum number of metric definitions that you can specify in one
    /// `BatchDeleteRumMetricDefinitions` operation is 200.
    pub fn batchDeleteRumMetricDefinitions(self: *Self, allocator: std.mem.Allocator, input: batch_delete_rum_metric_definitions.BatchDeleteRumMetricDefinitionsInput, options: batch_delete_rum_metric_definitions.Options) !batch_delete_rum_metric_definitions.BatchDeleteRumMetricDefinitionsOutput {
        return batch_delete_rum_metric_definitions.execute(self, allocator, input, options);
    }

    /// Retrieves the list of metrics and dimensions that a RUM app monitor is
    /// sending to a single destination.
    pub fn batchGetRumMetricDefinitions(self: *Self, allocator: std.mem.Allocator, input: batch_get_rum_metric_definitions.BatchGetRumMetricDefinitionsInput, options: batch_get_rum_metric_definitions.Options) !batch_get_rum_metric_definitions.BatchGetRumMetricDefinitionsOutput {
        return batch_get_rum_metric_definitions.execute(self, allocator, input, options);
    }

    /// Creates a Amazon CloudWatch RUM app monitor, which collects telemetry data
    /// from your application and sends that data to RUM. The data includes
    /// performance and reliability information such as page load time, client-side
    /// errors, and user behavior.
    ///
    /// You use this operation only to create a new app monitor. To update an
    /// existing app monitor, use
    /// [UpdateAppMonitor](https://docs.aws.amazon.com/cloudwatchrum/latest/APIReference/API_UpdateAppMonitor.html) instead.
    ///
    /// After you create an app monitor, sign in to the CloudWatch RUM console to
    /// get the JavaScript code snippet to add to your web application. For more
    /// information, see [How do I find a code snippet that I've already
    /// generated?](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-RUM-find-code-snippet.html)
    pub fn createAppMonitor(self: *Self, allocator: std.mem.Allocator, input: create_app_monitor.CreateAppMonitorInput, options: create_app_monitor.Options) !create_app_monitor.CreateAppMonitorOutput {
        return create_app_monitor.execute(self, allocator, input, options);
    }

    /// Deletes an existing app monitor. This immediately stops the collection of
    /// data.
    pub fn deleteAppMonitor(self: *Self, allocator: std.mem.Allocator, input: delete_app_monitor.DeleteAppMonitorInput, options: delete_app_monitor.Options) !delete_app_monitor.DeleteAppMonitorOutput {
        return delete_app_monitor.execute(self, allocator, input, options);
    }

    /// Removes the association of a resource-based policy from an app monitor.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: delete_resource_policy.Options) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Deletes a destination for CloudWatch RUM extended metrics, so that the
    /// specified app monitor stops sending extended metrics to that destination.
    pub fn deleteRumMetricsDestination(self: *Self, allocator: std.mem.Allocator, input: delete_rum_metrics_destination.DeleteRumMetricsDestinationInput, options: delete_rum_metrics_destination.Options) !delete_rum_metrics_destination.DeleteRumMetricsDestinationOutput {
        return delete_rum_metrics_destination.execute(self, allocator, input, options);
    }

    /// Retrieves the complete configuration information for one app monitor.
    pub fn getAppMonitor(self: *Self, allocator: std.mem.Allocator, input: get_app_monitor.GetAppMonitorInput, options: get_app_monitor.Options) !get_app_monitor.GetAppMonitorOutput {
        return get_app_monitor.execute(self, allocator, input, options);
    }

    /// Retrieves the raw performance events that RUM has collected from your web
    /// application, so that you can do your own processing or analysis of this
    /// data.
    pub fn getAppMonitorData(self: *Self, allocator: std.mem.Allocator, input: get_app_monitor_data.GetAppMonitorDataInput, options: get_app_monitor_data.Options) !get_app_monitor_data.GetAppMonitorDataOutput {
        return get_app_monitor_data.execute(self, allocator, input, options);
    }

    /// Use this operation to retrieve information about a resource-based policy
    /// that is attached to an app monitor.
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: get_resource_policy.Options) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// Returns a list of the Amazon CloudWatch RUM app monitors in the account.
    pub fn listAppMonitors(self: *Self, allocator: std.mem.Allocator, input: list_app_monitors.ListAppMonitorsInput, options: list_app_monitors.Options) !list_app_monitors.ListAppMonitorsOutput {
        return list_app_monitors.execute(self, allocator, input, options);
    }

    /// Returns a list of destinations that you have created to receive RUM extended
    /// metrics, for the specified app monitor.
    ///
    /// For more information about extended metrics, see
    /// [AddRumMetrics](https://docs.aws.amazon.com/cloudwatchrum/latest/APIReference/API_AddRumMetrcs.html).
    pub fn listRumMetricsDestinations(self: *Self, allocator: std.mem.Allocator, input: list_rum_metrics_destinations.ListRumMetricsDestinationsInput, options: list_rum_metrics_destinations.Options) !list_rum_metrics_destinations.ListRumMetricsDestinationsOutput {
        return list_rum_metrics_destinations.execute(self, allocator, input, options);
    }

    /// Displays the tags associated with a CloudWatch RUM resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Use this operation to assign a resource-based policy to a CloudWatch RUM app
    /// monitor to control access to it. Each app monitor can have one
    /// resource-based policy. The maximum size of the policy is 4 KB. To learn more
    /// about using resource policies with RUM, see [Using resource-based policies
    /// with CloudWatch
    /// RUM](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-RUM-resource-policies.html).
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: put_resource_policy.Options) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Sends telemetry events about your application performance and user behavior
    /// to CloudWatch RUM. The code snippet that RUM generates for you to add to
    /// your application includes `PutRumEvents` operations to send this data to
    /// RUM.
    ///
    /// Each `PutRumEvents` operation can send a batch of events from one user
    /// session.
    pub fn putRumEvents(self: *Self, allocator: std.mem.Allocator, input: put_rum_events.PutRumEventsInput, options: put_rum_events.Options) !put_rum_events.PutRumEventsOutput {
        return put_rum_events.execute(self, allocator, input, options);
    }

    /// Creates or updates a destination to receive extended metrics from CloudWatch
    /// RUM. You can send extended metrics to CloudWatch or to a CloudWatch
    /// Evidently experiment.
    ///
    /// For more information about extended metrics, see
    /// [BatchCreateRumMetricDefinitions](https://docs.aws.amazon.com/cloudwatchrum/latest/APIReference/API_BatchCreateRumMetricDefinitions.html).
    pub fn putRumMetricsDestination(self: *Self, allocator: std.mem.Allocator, input: put_rum_metrics_destination.PutRumMetricsDestinationInput, options: put_rum_metrics_destination.Options) !put_rum_metrics_destination.PutRumMetricsDestinationOutput {
        return put_rum_metrics_destination.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags (key-value pairs) to the specified CloudWatch RUM
    /// resource. Currently, the only resources that can be tagged app monitors.
    ///
    /// Tags can help you organize and categorize your resources. You can also use
    /// them to scope user permissions by granting a user permission to access or
    /// change only resources with certain tag values.
    ///
    /// Tags don't have any semantic meaning to Amazon Web Services and are
    /// interpreted strictly as strings of characters.
    ///
    /// You can use the `TagResource` action with a resource that already has tags.
    /// If you specify a new tag key for the resource, this tag is appended to the
    /// list of tags associated with the alarm. If you specify a tag key that is
    /// already associated with the resource, the new tag value that you specify
    /// replaces the previous value for that tag.
    ///
    /// You can associate as many as 50 tags with a resource.
    ///
    /// For more information, see [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html).
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an existing app monitor. When you use this
    /// operation, only the parts of the app monitor configuration that you specify
    /// in this operation are changed. For any parameters that you omit, the
    /// existing values are kept.
    ///
    /// You can't use this operation to change the tags of an existing app monitor.
    /// To change the tags of an existing app monitor, use
    /// [TagResource](https://docs.aws.amazon.com/cloudwatchrum/latest/APIReference/API_TagResource.html).
    ///
    /// To create a new app monitor, use
    /// [CreateAppMonitor](https://docs.aws.amazon.com/cloudwatchrum/latest/APIReference/API_CreateAppMonitor.html).
    ///
    /// After you update an app monitor, sign in to the CloudWatch RUM console to
    /// get the updated JavaScript code snippet to add to your web application. For
    /// more information, see [How do I find a code snippet that I've already
    /// generated?](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-RUM-find-code-snippet.html)
    pub fn updateAppMonitor(self: *Self, allocator: std.mem.Allocator, input: update_app_monitor.UpdateAppMonitorInput, options: update_app_monitor.Options) !update_app_monitor.UpdateAppMonitorOutput {
        return update_app_monitor.execute(self, allocator, input, options);
    }

    /// Modifies one existing metric definition for CloudWatch RUM extended metrics.
    /// For more information about extended metrics, see
    /// [BatchCreateRumMetricsDefinitions](https://docs.aws.amazon.com/cloudwatchrum/latest/APIReference/API_BatchCreateRumMetricsDefinitions.html).
    pub fn updateRumMetricDefinition(self: *Self, allocator: std.mem.Allocator, input: update_rum_metric_definition.UpdateRumMetricDefinitionInput, options: update_rum_metric_definition.Options) !update_rum_metric_definition.UpdateRumMetricDefinitionOutput {
        return update_rum_metric_definition.execute(self, allocator, input, options);
    }

    pub fn batchGetRumMetricDefinitionsPaginator(self: *Self, params: batch_get_rum_metric_definitions.BatchGetRumMetricDefinitionsInput) paginator.BatchGetRumMetricDefinitionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getAppMonitorDataPaginator(self: *Self, params: get_app_monitor_data.GetAppMonitorDataInput) paginator.GetAppMonitorDataPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAppMonitorsPaginator(self: *Self, params: list_app_monitors.ListAppMonitorsInput) paginator.ListAppMonitorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRumMetricsDestinationsPaginator(self: *Self, params: list_rum_metrics_destinations.ListRumMetricsDestinationsInput) paginator.ListRumMetricsDestinationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
