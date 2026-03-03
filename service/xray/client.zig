const aws = @import("aws");
const std = @import("std");

const batch_get_traces = @import("batch_get_traces.zig");
const cancel_trace_retrieval = @import("cancel_trace_retrieval.zig");
const create_group = @import("create_group.zig");
const create_sampling_rule = @import("create_sampling_rule.zig");
const delete_group = @import("delete_group.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const delete_sampling_rule = @import("delete_sampling_rule.zig");
const get_encryption_config = @import("get_encryption_config.zig");
const get_group = @import("get_group.zig");
const get_groups = @import("get_groups.zig");
const get_indexing_rules = @import("get_indexing_rules.zig");
const get_insight = @import("get_insight.zig");
const get_insight_events = @import("get_insight_events.zig");
const get_insight_impact_graph = @import("get_insight_impact_graph.zig");
const get_insight_summaries = @import("get_insight_summaries.zig");
const get_retrieved_traces_graph = @import("get_retrieved_traces_graph.zig");
const get_sampling_rules = @import("get_sampling_rules.zig");
const get_sampling_statistic_summaries = @import("get_sampling_statistic_summaries.zig");
const get_sampling_targets = @import("get_sampling_targets.zig");
const get_service_graph = @import("get_service_graph.zig");
const get_time_series_service_statistics = @import("get_time_series_service_statistics.zig");
const get_trace_graph = @import("get_trace_graph.zig");
const get_trace_segment_destination = @import("get_trace_segment_destination.zig");
const get_trace_summaries = @import("get_trace_summaries.zig");
const list_resource_policies = @import("list_resource_policies.zig");
const list_retrieved_traces = @import("list_retrieved_traces.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_encryption_config = @import("put_encryption_config.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const put_telemetry_records = @import("put_telemetry_records.zig");
const put_trace_segments = @import("put_trace_segments.zig");
const start_trace_retrieval = @import("start_trace_retrieval.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_group = @import("update_group.zig");
const update_indexing_rule = @import("update_indexing_rule.zig");
const update_sampling_rule = @import("update_sampling_rule.zig");
const update_trace_segment_destination = @import("update_trace_segment_destination.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "XRay";

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

    /// You cannot find traces through this API if Transaction Search is enabled
    /// since trace is not indexed in X-Ray.
    ///
    /// Retrieves a list of traces specified by ID. Each trace is a collection of
    /// segment
    /// documents that originates from a single request. Use `GetTraceSummaries` to
    /// get a
    /// list of trace IDs.
    pub fn batchGetTraces(self: *Self, allocator: std.mem.Allocator, input: batch_get_traces.BatchGetTracesInput, options: CallOptions) !batch_get_traces.BatchGetTracesOutput {
        return batch_get_traces.execute(self, allocator, input, options);
    }

    /// Cancels an ongoing trace retrieval job initiated by `StartTraceRetrieval`
    /// using the provided `RetrievalToken`. A successful cancellation will return
    /// an HTTP 200 response.
    pub fn cancelTraceRetrieval(self: *Self, allocator: std.mem.Allocator, input: cancel_trace_retrieval.CancelTraceRetrievalInput, options: CallOptions) !cancel_trace_retrieval.CancelTraceRetrievalOutput {
        return cancel_trace_retrieval.execute(self, allocator, input, options);
    }

    /// Creates a group resource with a name and a filter expression.
    pub fn createGroup(self: *Self, allocator: std.mem.Allocator, input: create_group.CreateGroupInput, options: CallOptions) !create_group.CreateGroupOutput {
        return create_group.execute(self, allocator, input, options);
    }

    /// Creates a rule to control sampling behavior for instrumented applications.
    /// Services
    /// retrieve rules with
    /// [GetSamplingRules](https://docs.aws.amazon.com/xray/latest/api/API_GetSamplingRules.html), and evaluate each rule in ascending
    /// order of *priority* for each request. If a rule matches, the service
    /// records a trace, borrowing it from the reservoir size. After 10 seconds, the
    /// service
    /// reports back to X-Ray with
    /// [GetSamplingTargets](https://docs.aws.amazon.com/xray/latest/api/API_GetSamplingTargets.html) to get updated versions of
    /// each in-use rule. The updated rule contains a trace quota that the service
    /// can use instead
    /// of borrowing from the reservoir.
    pub fn createSamplingRule(self: *Self, allocator: std.mem.Allocator, input: create_sampling_rule.CreateSamplingRuleInput, options: CallOptions) !create_sampling_rule.CreateSamplingRuleOutput {
        return create_sampling_rule.execute(self, allocator, input, options);
    }

    /// Deletes a group resource.
    pub fn deleteGroup(self: *Self, allocator: std.mem.Allocator, input: delete_group.DeleteGroupInput, options: CallOptions) !delete_group.DeleteGroupOutput {
        return delete_group.execute(self, allocator, input, options);
    }

    /// Deletes a resource policy from the target Amazon Web Services account.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: CallOptions) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Deletes a sampling rule.
    pub fn deleteSamplingRule(self: *Self, allocator: std.mem.Allocator, input: delete_sampling_rule.DeleteSamplingRuleInput, options: CallOptions) !delete_sampling_rule.DeleteSamplingRuleOutput {
        return delete_sampling_rule.execute(self, allocator, input, options);
    }

    /// Retrieves the current encryption configuration for X-Ray data.
    pub fn getEncryptionConfig(self: *Self, allocator: std.mem.Allocator, input: get_encryption_config.GetEncryptionConfigInput, options: CallOptions) !get_encryption_config.GetEncryptionConfigOutput {
        return get_encryption_config.execute(self, allocator, input, options);
    }

    /// Retrieves group resource details.
    pub fn getGroup(self: *Self, allocator: std.mem.Allocator, input: get_group.GetGroupInput, options: CallOptions) !get_group.GetGroupOutput {
        return get_group.execute(self, allocator, input, options);
    }

    /// Retrieves all active group details.
    pub fn getGroups(self: *Self, allocator: std.mem.Allocator, input: get_groups.GetGroupsInput, options: CallOptions) !get_groups.GetGroupsOutput {
        return get_groups.execute(self, allocator, input, options);
    }

    /// Retrieves all indexing rules.
    ///
    /// Indexing rules are used to determine the server-side sampling rate for spans
    /// ingested through the CloudWatchLogs destination and indexed by X-Ray. For
    /// more information, see [Transaction
    /// Search](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Transaction-Search.html).
    pub fn getIndexingRules(self: *Self, allocator: std.mem.Allocator, input: get_indexing_rules.GetIndexingRulesInput, options: CallOptions) !get_indexing_rules.GetIndexingRulesOutput {
        return get_indexing_rules.execute(self, allocator, input, options);
    }

    /// Retrieves the summary information of an insight. This includes impact to
    /// clients and
    /// root cause services, the top anomalous services, the category, the state of
    /// the insight,
    /// and the start and end time of the insight.
    pub fn getInsight(self: *Self, allocator: std.mem.Allocator, input: get_insight.GetInsightInput, options: CallOptions) !get_insight.GetInsightOutput {
        return get_insight.execute(self, allocator, input, options);
    }

    /// X-Ray reevaluates insights periodically until they're resolved, and records
    /// each intermediate state as an
    /// event. You can review an insight's events in the Impact Timeline on the
    /// Inspect page in the X-Ray
    /// console.
    pub fn getInsightEvents(self: *Self, allocator: std.mem.Allocator, input: get_insight_events.GetInsightEventsInput, options: CallOptions) !get_insight_events.GetInsightEventsOutput {
        return get_insight_events.execute(self, allocator, input, options);
    }

    /// Retrieves a service graph structure filtered by the specified insight. The
    /// service graph is limited to only
    /// structural information. For a complete service graph, use this API with the
    /// GetServiceGraph API.
    pub fn getInsightImpactGraph(self: *Self, allocator: std.mem.Allocator, input: get_insight_impact_graph.GetInsightImpactGraphInput, options: CallOptions) !get_insight_impact_graph.GetInsightImpactGraphOutput {
        return get_insight_impact_graph.execute(self, allocator, input, options);
    }

    /// Retrieves the summaries of all insights in the specified group matching the
    /// provided filter values.
    pub fn getInsightSummaries(self: *Self, allocator: std.mem.Allocator, input: get_insight_summaries.GetInsightSummariesInput, options: CallOptions) !get_insight_summaries.GetInsightSummariesOutput {
        return get_insight_summaries.execute(self, allocator, input, options);
    }

    /// Retrieves a service graph for traces based on the specified `RetrievalToken`
    /// from the CloudWatch log group generated by Transaction Search. This API does
    /// not initiate a retrieval job. You must first execute `StartTraceRetrieval`
    /// to obtain the required `RetrievalToken`.
    ///
    /// The trace graph describes services that process incoming requests and any
    /// downstream services they call, which may include Amazon Web Services
    /// resources, external APIs, or databases.
    ///
    /// The response is empty until the `RetrievalStatus` is *COMPLETE*. Retry the
    /// request after the status changes from *RUNNING* or *SCHEDULED* to *COMPLETE*
    /// to access the full service graph.
    ///
    /// When CloudWatch log is the destination, this API can support cross-account
    /// observability and service graph retrieval across linked accounts.
    ///
    /// For retrieving graphs from X-Ray directly as opposed to the
    /// Transaction-Search Log group, see
    /// [GetTraceGraph](https://docs.aws.amazon.com/xray/latest/api/API_GetTraceGraph.html).
    pub fn getRetrievedTracesGraph(self: *Self, allocator: std.mem.Allocator, input: get_retrieved_traces_graph.GetRetrievedTracesGraphInput, options: CallOptions) !get_retrieved_traces_graph.GetRetrievedTracesGraphOutput {
        return get_retrieved_traces_graph.execute(self, allocator, input, options);
    }

    /// Retrieves all sampling rules.
    pub fn getSamplingRules(self: *Self, allocator: std.mem.Allocator, input: get_sampling_rules.GetSamplingRulesInput, options: CallOptions) !get_sampling_rules.GetSamplingRulesOutput {
        return get_sampling_rules.execute(self, allocator, input, options);
    }

    /// Retrieves information about recent sampling results for all sampling rules.
    pub fn getSamplingStatisticSummaries(self: *Self, allocator: std.mem.Allocator, input: get_sampling_statistic_summaries.GetSamplingStatisticSummariesInput, options: CallOptions) !get_sampling_statistic_summaries.GetSamplingStatisticSummariesOutput {
        return get_sampling_statistic_summaries.execute(self, allocator, input, options);
    }

    /// Requests a sampling quota for rules that the service is using to sample
    /// requests.
    pub fn getSamplingTargets(self: *Self, allocator: std.mem.Allocator, input: get_sampling_targets.GetSamplingTargetsInput, options: CallOptions) !get_sampling_targets.GetSamplingTargetsOutput {
        return get_sampling_targets.execute(self, allocator, input, options);
    }

    /// Retrieves a document that describes services that process incoming requests,
    /// and
    /// downstream services that they call as a result. Root services process
    /// incoming requests and
    /// make calls to downstream services. Root services are applications that use
    /// the [Amazon Web Services X-Ray
    /// SDK](https://docs.aws.amazon.com/xray/index.html).
    /// Downstream services can be other applications, Amazon Web Services
    /// resources, HTTP web APIs, or SQL
    /// databases.
    pub fn getServiceGraph(self: *Self, allocator: std.mem.Allocator, input: get_service_graph.GetServiceGraphInput, options: CallOptions) !get_service_graph.GetServiceGraphOutput {
        return get_service_graph.execute(self, allocator, input, options);
    }

    /// Get an aggregation of service statistics defined by a specific time
    /// range.
    pub fn getTimeSeriesServiceStatistics(self: *Self, allocator: std.mem.Allocator, input: get_time_series_service_statistics.GetTimeSeriesServiceStatisticsInput, options: CallOptions) !get_time_series_service_statistics.GetTimeSeriesServiceStatisticsOutput {
        return get_time_series_service_statistics.execute(self, allocator, input, options);
    }

    /// Retrieves a service graph for one or more specific trace IDs.
    pub fn getTraceGraph(self: *Self, allocator: std.mem.Allocator, input: get_trace_graph.GetTraceGraphInput, options: CallOptions) !get_trace_graph.GetTraceGraphOutput {
        return get_trace_graph.execute(self, allocator, input, options);
    }

    /// Retrieves the current destination of data sent to `PutTraceSegments` and
    /// *OpenTelemetry protocol (OTLP)* endpoint. The Transaction Search feature
    /// requires a CloudWatchLogs destination. For more information, see
    /// [Transaction
    /// Search](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Transaction-Search.html) and [OpenTelemetry](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-OpenTelemetry-Sections.html).
    pub fn getTraceSegmentDestination(self: *Self, allocator: std.mem.Allocator, input: get_trace_segment_destination.GetTraceSegmentDestinationInput, options: CallOptions) !get_trace_segment_destination.GetTraceSegmentDestinationOutput {
        return get_trace_segment_destination.execute(self, allocator, input, options);
    }

    /// Retrieves IDs and annotations for traces available for a specified time
    /// frame using an
    /// optional filter. To get the full traces, pass the trace IDs to
    /// `BatchGetTraces`.
    ///
    /// A filter expression can target traced requests that hit specific service
    /// nodes or
    /// edges, have errors, or come from a known user. For example, the following
    /// filter expression
    /// targets traces that pass through `api.example.com`:
    ///
    /// `service("api.example.com")`
    ///
    /// This filter expression finds traces that have an annotation named `account`
    /// with the value `12345`:
    ///
    /// `annotation.account = "12345"`
    ///
    /// For a full list of indexed fields and keywords that you can use in filter
    /// expressions,
    /// see [Use filter
    /// expressions](https://docs.aws.amazon.com/xray/latest/devguide/aws-xray-interface-console.html#xray-console-filters) in the *Amazon Web Services X-Ray Developer Guide*.
    pub fn getTraceSummaries(self: *Self, allocator: std.mem.Allocator, input: get_trace_summaries.GetTraceSummariesInput, options: CallOptions) !get_trace_summaries.GetTraceSummariesOutput {
        return get_trace_summaries.execute(self, allocator, input, options);
    }

    /// Returns the list of resource policies in the target Amazon Web Services
    /// account.
    pub fn listResourcePolicies(self: *Self, allocator: std.mem.Allocator, input: list_resource_policies.ListResourcePoliciesInput, options: CallOptions) !list_resource_policies.ListResourcePoliciesOutput {
        return list_resource_policies.execute(self, allocator, input, options);
    }

    /// Retrieves a list of traces for a given `RetrievalToken` from the CloudWatch
    /// log group generated by Transaction Search. For information on what each
    /// trace returns, see
    /// [BatchGetTraces](https://docs.aws.amazon.com/xray/latest/api/API_BatchGetTraces.html).
    ///
    /// This API does not initiate a retrieval process. To start a trace retrieval,
    /// use `StartTraceRetrieval`, which generates the required `RetrievalToken`.
    ///
    /// When the `RetrievalStatus` is not *COMPLETE*, the API will return an empty
    /// response. Retry the request once the retrieval has completed to access the
    /// full list of traces.
    ///
    /// For cross-account observability, this API can retrieve traces from linked
    /// accounts when CloudWatch log is set as the destination across relevant
    /// accounts. For more details, see [CloudWatch cross-account
    /// observability](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Unified-Cross-Account.html).
    ///
    /// For retrieving data from X-Ray directly as opposed to the Transaction Search
    /// generated log group, see
    /// [BatchGetTraces](https://docs.aws.amazon.com/xray/latest/api/API_BatchGetTraces.html).
    pub fn listRetrievedTraces(self: *Self, allocator: std.mem.Allocator, input: list_retrieved_traces.ListRetrievedTracesInput, options: CallOptions) !list_retrieved_traces.ListRetrievedTracesOutput {
        return list_retrieved_traces.execute(self, allocator, input, options);
    }

    /// Returns a list of tags that are applied to the specified Amazon Web Services
    /// X-Ray group or sampling rule.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Updates the encryption configuration for X-Ray data.
    pub fn putEncryptionConfig(self: *Self, allocator: std.mem.Allocator, input: put_encryption_config.PutEncryptionConfigInput, options: CallOptions) !put_encryption_config.PutEncryptionConfigOutput {
        return put_encryption_config.execute(self, allocator, input, options);
    }

    /// Sets the resource policy to grant one or more Amazon Web Services services
    /// and accounts permissions to
    /// access X-Ray. Each resource policy will be associated with a specific Amazon
    /// Web Services account.
    /// Each Amazon Web Services account can have a maximum of 5 resource policies,
    /// and each policy name must be
    /// unique within that account. The maximum size of each resource policy is 5KB.
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: CallOptions) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Used by the Amazon Web Services X-Ray daemon to upload telemetry.
    pub fn putTelemetryRecords(self: *Self, allocator: std.mem.Allocator, input: put_telemetry_records.PutTelemetryRecordsInput, options: CallOptions) !put_telemetry_records.PutTelemetryRecordsOutput {
        return put_telemetry_records.execute(self, allocator, input, options);
    }

    /// Uploads segment documents to Amazon Web Services X-Ray.
    /// A segment document can be a completed segment, an in-progress segment, or an
    /// array of
    /// subsegments.
    ///
    /// Segments must include the following fields. For the full segment document
    /// schema, see
    /// [Amazon Web Services X-Ray
    /// Segment
    /// Documents](https://docs.aws.amazon.com/xray/latest/devguide/aws-xray-interface-api.html#xray-api-segmentdocuments.html) in the *Amazon Web Services X-Ray Developer Guide*.
    ///
    /// **Required segment document fields**
    ///
    /// * `name` - The name of the service that handled the request.
    ///
    /// * `id` - A 64-bit identifier for the segment, unique among segments in the
    ///   same trace, in 16
    /// hexadecimal digits.
    ///
    /// * `trace_id` - A unique identifier that connects all segments and
    ///   subsegments originating from
    /// a single client request.
    ///
    /// * `start_time` - Time the segment or subsegment was created, in floating
    ///   point seconds in
    /// epoch time, accurate to milliseconds. For example, `1480615200.010` or
    /// `1.480615200010E9`.
    ///
    /// * `end_time` - Time the segment or subsegment was closed. For example,
    /// `1480615200.090` or `1.480615200090E9`. Specify either an `end_time` or
    /// `in_progress`.
    ///
    /// * `in_progress` - Set to `true` instead of specifying an `end_time` to
    /// record that a segment has been started, but is not complete. Send an
    /// in-progress segment when your application
    /// receives a request that will take a long time to serve, to trace that the
    /// request was received. When the
    /// response is sent, send the complete segment to overwrite the in-progress
    /// segment.
    ///
    /// A `trace_id` consists of three numbers separated by hyphens. For example,
    /// 1-58406520-a006649127e371903a2de979. For trace IDs created by an X-Ray SDK,
    /// or by Amazon Web Services services
    /// integrated with X-Ray, a trace ID includes:
    ///
    /// **Trace ID Format**
    ///
    /// * The version number, for instance, `1`.
    ///
    /// * The time of the original request, in Unix epoch time, in 8 hexadecimal
    ///   digits. For
    /// example, 10:00AM December 2nd, 2016 PST in epoch time is `1480615200`
    /// seconds,
    /// or `58406520` in hexadecimal.
    ///
    /// * A 96-bit identifier for the trace, globally unique, in 24 hexadecimal
    /// digits.
    ///
    /// Trace IDs created via OpenTelemetry have a different format based on the
    /// [W3C Trace Context specification](https://www.w3.org/TR/trace-context/).
    /// A W3C trace ID must be formatted in the X-Ray trace ID format when sending
    /// to X-Ray. For example, a W3C
    /// trace ID `4efaaf4d1e8720b39541901950019ee5` should be formatted as
    /// `1-4efaaf4d-1e8720b39541901950019ee5` when sending to X-Ray. While X-Ray
    /// trace IDs include
    /// the original request timestamp in Unix epoch time, this is not required or
    /// validated.
    pub fn putTraceSegments(self: *Self, allocator: std.mem.Allocator, input: put_trace_segments.PutTraceSegmentsInput, options: CallOptions) !put_trace_segments.PutTraceSegmentsOutput {
        return put_trace_segments.execute(self, allocator, input, options);
    }

    /// Initiates a trace retrieval process using the specified time range and for
    /// the given trace IDs in the Transaction Search generated CloudWatch log
    /// group. For more information, see [Transaction
    /// Search](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Transaction-Search.html).
    ///
    /// API returns a `RetrievalToken`, which can be used with `ListRetrievedTraces`
    /// or `GetRetrievedTracesGraph` to fetch results. Retrievals will time out
    /// after 60 minutes. To execute long time ranges, consider segmenting into
    /// multiple retrievals.
    ///
    /// If you are using [CloudWatch cross-account
    /// observability](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Unified-Cross-Account.html), you can use this operation in a monitoring account to retrieve data from a linked source account, as long as both accounts have transaction search enabled.
    ///
    /// For retrieving data from X-Ray directly as opposed to the Transaction-Search
    /// Log group, see
    /// [BatchGetTraces](https://docs.aws.amazon.com/xray/latest/api/API_BatchGetTraces.html).
    pub fn startTraceRetrieval(self: *Self, allocator: std.mem.Allocator, input: start_trace_retrieval.StartTraceRetrievalInput, options: CallOptions) !start_trace_retrieval.StartTraceRetrievalOutput {
        return start_trace_retrieval.execute(self, allocator, input, options);
    }

    /// Applies tags to an existing Amazon Web Services X-Ray group or sampling
    /// rule.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from an Amazon Web Services X-Ray group or sampling rule. You
    /// cannot edit or delete system
    /// tags (those with an `aws:` prefix).
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a group resource.
    pub fn updateGroup(self: *Self, allocator: std.mem.Allocator, input: update_group.UpdateGroupInput, options: CallOptions) !update_group.UpdateGroupOutput {
        return update_group.execute(self, allocator, input, options);
    }

    /// Modifies an indexing rule’s configuration.
    ///
    /// Indexing rules are used for determining the sampling rate for spans indexed
    /// from CloudWatch Logs. For more information, see [Transaction
    /// Search](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Transaction-Search.html).
    pub fn updateIndexingRule(self: *Self, allocator: std.mem.Allocator, input: update_indexing_rule.UpdateIndexingRuleInput, options: CallOptions) !update_indexing_rule.UpdateIndexingRuleOutput {
        return update_indexing_rule.execute(self, allocator, input, options);
    }

    /// Modifies a sampling rule's configuration.
    pub fn updateSamplingRule(self: *Self, allocator: std.mem.Allocator, input: update_sampling_rule.UpdateSamplingRuleInput, options: CallOptions) !update_sampling_rule.UpdateSamplingRuleOutput {
        return update_sampling_rule.execute(self, allocator, input, options);
    }

    /// Modifies the destination of data sent to `PutTraceSegments`. The Transaction
    /// Search feature requires the CloudWatchLogs destination. For more
    /// information, see [Transaction
    /// Search](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Transaction-Search.html).
    pub fn updateTraceSegmentDestination(self: *Self, allocator: std.mem.Allocator, input: update_trace_segment_destination.UpdateTraceSegmentDestinationInput, options: CallOptions) !update_trace_segment_destination.UpdateTraceSegmentDestinationOutput {
        return update_trace_segment_destination.execute(self, allocator, input, options);
    }

    pub fn batchGetTracesPaginator(self: *Self, params: batch_get_traces.BatchGetTracesInput) paginator.BatchGetTracesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getGroupsPaginator(self: *Self, params: get_groups.GetGroupsInput) paginator.GetGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getInsightEventsPaginator(self: *Self, params: get_insight_events.GetInsightEventsInput) paginator.GetInsightEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getInsightSummariesPaginator(self: *Self, params: get_insight_summaries.GetInsightSummariesInput) paginator.GetInsightSummariesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getSamplingRulesPaginator(self: *Self, params: get_sampling_rules.GetSamplingRulesInput) paginator.GetSamplingRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getSamplingStatisticSummariesPaginator(self: *Self, params: get_sampling_statistic_summaries.GetSamplingStatisticSummariesInput) paginator.GetSamplingStatisticSummariesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getServiceGraphPaginator(self: *Self, params: get_service_graph.GetServiceGraphInput) paginator.GetServiceGraphPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getTimeSeriesServiceStatisticsPaginator(self: *Self, params: get_time_series_service_statistics.GetTimeSeriesServiceStatisticsInput) paginator.GetTimeSeriesServiceStatisticsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getTraceGraphPaginator(self: *Self, params: get_trace_graph.GetTraceGraphInput) paginator.GetTraceGraphPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getTraceSummariesPaginator(self: *Self, params: get_trace_summaries.GetTraceSummariesInput) paginator.GetTraceSummariesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourcePoliciesPaginator(self: *Self, params: list_resource_policies.ListResourcePoliciesInput) paginator.ListResourcePoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTagsForResourcePaginator(self: *Self, params: list_tags_for_resource.ListTagsForResourceInput) paginator.ListTagsForResourcePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
