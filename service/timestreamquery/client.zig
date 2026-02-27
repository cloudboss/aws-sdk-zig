const aws = @import("aws");
const std = @import("std");

const cancel_query = @import("cancel_query.zig");
const create_scheduled_query = @import("create_scheduled_query.zig");
const delete_scheduled_query = @import("delete_scheduled_query.zig");
const describe_account_settings = @import("describe_account_settings.zig");
const describe_endpoints = @import("describe_endpoints.zig");
const describe_scheduled_query = @import("describe_scheduled_query.zig");
const execute_scheduled_query = @import("execute_scheduled_query.zig");
const list_scheduled_queries = @import("list_scheduled_queries.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const prepare_query = @import("prepare_query.zig");
const query_ = @import("query.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_account_settings = @import("update_account_settings.zig");
const update_scheduled_query = @import("update_scheduled_query.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Timestream Query";

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

    /// Cancels a query that has been issued. Cancellation is provided only if the
    /// query has
    /// not completed running before the cancellation request was issued. Because
    /// cancellation
    /// is an idempotent operation, subsequent cancellation requests will return a
    /// `CancellationMessage`, indicating that the query has already been
    /// canceled. See [code
    /// sample](https://docs.aws.amazon.com/timestream/latest/developerguide/code-samples.cancel-query.html) for details.
    pub fn cancelQuery(self: *Self, allocator: std.mem.Allocator, input: cancel_query.CancelQueryInput, options: cancel_query.Options) !cancel_query.CancelQueryOutput {
        return cancel_query.execute(self, allocator, input, options);
    }

    /// Create a scheduled query that will be run on your behalf at the configured
    /// schedule.
    /// Timestream assumes the execution role provided as part of the
    /// `ScheduledQueryExecutionRoleArn` parameter to run the query. You can use
    /// the `NotificationConfiguration` parameter to configure notification for your
    /// scheduled query operations.
    pub fn createScheduledQuery(self: *Self, allocator: std.mem.Allocator, input: create_scheduled_query.CreateScheduledQueryInput, options: create_scheduled_query.Options) !create_scheduled_query.CreateScheduledQueryOutput {
        return create_scheduled_query.execute(self, allocator, input, options);
    }

    /// Deletes a given scheduled query. This is an irreversible operation.
    pub fn deleteScheduledQuery(self: *Self, allocator: std.mem.Allocator, input: delete_scheduled_query.DeleteScheduledQueryInput, options: delete_scheduled_query.Options) !delete_scheduled_query.DeleteScheduledQueryOutput {
        return delete_scheduled_query.execute(self, allocator, input, options);
    }

    /// Describes the settings for your account that include the query pricing model
    /// and the configured maximum TCUs the service can use for your query workload.
    ///
    /// You're charged only for the duration of compute units used for your
    /// workloads.
    pub fn describeAccountSettings(self: *Self, allocator: std.mem.Allocator, input: describe_account_settings.DescribeAccountSettingsInput, options: describe_account_settings.Options) !describe_account_settings.DescribeAccountSettingsOutput {
        return describe_account_settings.execute(self, allocator, input, options);
    }

    /// DescribeEndpoints returns a list of available endpoints to make Timestream
    /// API calls against. This API is available through both Write and Query.
    ///
    /// Because the Timestream SDKs are designed to transparently work with the
    /// service’s architecture, including the management and mapping of the service
    /// endpoints,
    /// *it is not recommended that you use this API unless*:
    ///
    /// * You are using [VPC endpoints (Amazon Web Services PrivateLink) with
    ///   Timestream
    /// ](https://docs.aws.amazon.com/timestream/latest/developerguide/VPCEndpoints)
    ///
    /// * Your application uses a programming language that does not yet have SDK
    /// support
    ///
    /// * You require better control over the client-side implementation
    ///
    /// For detailed information on how and when to use and implement
    /// DescribeEndpoints, see
    /// [The Endpoint Discovery
    /// Pattern](https://docs.aws.amazon.com/timestream/latest/developerguide/Using.API.html#Using-API.endpoint-discovery).
    pub fn describeEndpoints(self: *Self, allocator: std.mem.Allocator, input: describe_endpoints.DescribeEndpointsInput, options: describe_endpoints.Options) !describe_endpoints.DescribeEndpointsOutput {
        return describe_endpoints.execute(self, allocator, input, options);
    }

    /// Provides detailed information about a scheduled query.
    pub fn describeScheduledQuery(self: *Self, allocator: std.mem.Allocator, input: describe_scheduled_query.DescribeScheduledQueryInput, options: describe_scheduled_query.Options) !describe_scheduled_query.DescribeScheduledQueryOutput {
        return describe_scheduled_query.execute(self, allocator, input, options);
    }

    /// You can use this API to run a scheduled query manually.
    ///
    /// If you enabled `QueryInsights`, this API also returns insights and metrics
    /// related to the query that you executed as part of an Amazon SNS
    /// notification. `QueryInsights` helps with performance tuning of your query.
    /// For more information about `QueryInsights`, see [Using query insights to
    /// optimize queries in Amazon
    /// Timestream](https://docs.aws.amazon.com/timestream/latest/developerguide/using-query-insights.html).
    pub fn executeScheduledQuery(self: *Self, allocator: std.mem.Allocator, input: execute_scheduled_query.ExecuteScheduledQueryInput, options: execute_scheduled_query.Options) !execute_scheduled_query.ExecuteScheduledQueryOutput {
        return execute_scheduled_query.execute(self, allocator, input, options);
    }

    /// Gets a list of all scheduled queries in the caller's Amazon account and
    /// Region.
    /// `ListScheduledQueries` is eventually consistent.
    pub fn listScheduledQueries(self: *Self, allocator: std.mem.Allocator, input: list_scheduled_queries.ListScheduledQueriesInput, options: list_scheduled_queries.Options) !list_scheduled_queries.ListScheduledQueriesOutput {
        return list_scheduled_queries.execute(self, allocator, input, options);
    }

    /// List all tags on a Timestream query resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// A synchronous operation that allows you to submit a query with parameters to
    /// be stored
    /// by Timestream for later running. Timestream only supports using this
    /// operation with
    /// `ValidateOnly` set to `true`.
    pub fn prepareQuery(self: *Self, allocator: std.mem.Allocator, input: prepare_query.PrepareQueryInput, options: prepare_query.Options) !prepare_query.PrepareQueryOutput {
        return prepare_query.execute(self, allocator, input, options);
    }

    /// `Query` is a synchronous operation that enables you to run a query against
    /// your Amazon Timestream data.
    ///
    /// If you enabled `QueryInsights`, this API also returns insights and metrics
    /// related to the query that you executed. `QueryInsights` helps with
    /// performance tuning of your query. For more information about
    /// `QueryInsights`, see [Using query insights to optimize queries in Amazon
    /// Timestream](https://docs.aws.amazon.com/timestream/latest/developerguide/using-query-insights.html).
    ///
    /// The maximum number of `Query` API requests you're allowed to make with
    /// `QueryInsights` enabled is 1 query per second (QPS). If you exceed this
    /// query rate, it might result in throttling.
    ///
    /// `Query` will time out after 60 seconds.
    /// You must update the default timeout in the SDK to support a timeout of 60
    /// seconds. See
    /// the [code
    /// sample](https://docs.aws.amazon.com/timestream/latest/developerguide/code-samples.run-query.html) for details.
    ///
    /// Your query request will fail in the following cases:
    ///
    /// * If you submit a `Query` request with the same client token outside
    /// of the 5-minute idempotency window.
    ///
    /// * If you submit a `Query` request with the same client token, but
    /// change other parameters, within the 5-minute idempotency window.
    ///
    /// * If the size of the row (including the query metadata) exceeds 1 MB, then
    ///   the
    /// query will fail with the following error message:
    ///
    /// `Query aborted as max page response size has been exceeded by the output
    /// result row`
    ///
    /// * If the IAM principal of the query initiator and the result reader are not
    ///   the
    /// same and/or the query initiator and the result reader do not have the same
    /// query
    /// string in the query requests, the query will fail with an `Invalid
    /// pagination token` error.
    pub fn query(self: *Self, allocator: std.mem.Allocator, input: query_.QueryInput, options: query_.Options) !query_.QueryOutput {
        return query_.execute(self, allocator, input, options);
    }

    /// Associate a set of tags with a Timestream resource. You can then activate
    /// these
    /// user-defined tags so that they appear on the Billing and Cost Management
    /// console for
    /// cost allocation tracking.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the association of tags from a Timestream query resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Transitions your account to use TCUs for query pricing and modifies the
    /// maximum query compute units that you've configured. If you reduce the value
    /// of `MaxQueryTCU` to a desired configuration, the new value can take up to 24
    /// hours to be effective.
    ///
    /// After you've transitioned your account to use TCUs for query pricing, you
    /// can't transition to using bytes scanned for query pricing.
    pub fn updateAccountSettings(self: *Self, allocator: std.mem.Allocator, input: update_account_settings.UpdateAccountSettingsInput, options: update_account_settings.Options) !update_account_settings.UpdateAccountSettingsOutput {
        return update_account_settings.execute(self, allocator, input, options);
    }

    /// Update a scheduled query.
    pub fn updateScheduledQuery(self: *Self, allocator: std.mem.Allocator, input: update_scheduled_query.UpdateScheduledQueryInput, options: update_scheduled_query.Options) !update_scheduled_query.UpdateScheduledQueryOutput {
        return update_scheduled_query.execute(self, allocator, input, options);
    }

    pub fn listScheduledQueriesPaginator(self: *Self, params: list_scheduled_queries.ListScheduledQueriesInput) paginator.ListScheduledQueriesPaginator {
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

    pub fn queryPaginator(self: *Self, params: query_.QueryInput) paginator.QueryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
