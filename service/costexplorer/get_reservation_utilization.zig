const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Expression = @import("expression.zig").Expression;
const Granularity = @import("granularity.zig").Granularity;
const GroupDefinition = @import("group_definition.zig").GroupDefinition;
const SortDefinition = @import("sort_definition.zig").SortDefinition;
const DateInterval = @import("date_interval.zig").DateInterval;
const ReservationAggregates = @import("reservation_aggregates.zig").ReservationAggregates;
const UtilizationByTime = @import("utilization_by_time.zig").UtilizationByTime;

pub const GetReservationUtilizationInput = struct {
    /// Filters utilization data by dimensions. You can filter by the following
    /// dimensions:
    ///
    /// * AZ
    ///
    /// * CACHE_ENGINE
    ///
    /// * DEPLOYMENT_OPTION
    ///
    /// * INSTANCE_TYPE
    ///
    /// * LINKED_ACCOUNT
    ///
    /// * OPERATING_SYSTEM
    ///
    /// * PLATFORM
    ///
    /// * REGION
    ///
    /// * SERVICE
    ///
    /// If not specified, the `SERVICE` filter defaults to Amazon Elastic
    /// Compute Cloud - Compute. Supported values for `SERVICE` are Amazon Elastic
    /// Compute Cloud - Compute, Amazon Relational Database Service, Amazon
    /// ElastiCache, Amazon
    /// Redshift, and Amazon Elasticsearch Service. The value for the `SERVICE`
    /// filter should not exceed "1".
    ///
    /// * SCOPE
    ///
    /// * TENANCY
    ///
    /// `GetReservationUtilization` uses the same
    /// [Expression](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_Expression.html) object
    /// as the other operations, but only `AND` is supported among each dimension,
    /// and
    /// nesting is supported up to only one level deep. If there are multiple values
    /// for a dimension,
    /// they are OR'd together.
    filter: ?Expression = null,

    /// If `GroupBy` is set, `Granularity` can't be set. If
    /// `Granularity` isn't set, the response object doesn't include
    /// `Granularity`, either `MONTHLY` or `DAILY`. If both
    /// `GroupBy` and `Granularity` aren't set,
    /// `GetReservationUtilization` defaults to `DAILY`.
    ///
    /// The `GetReservationUtilization` operation supports only `DAILY` and
    /// `MONTHLY` granularities.
    granularity: ?Granularity = null,

    /// Groups only by `SUBSCRIPTION_ID`. Metadata is included.
    group_by: ?[]const GroupDefinition = null,

    /// The maximum number of objects that you returned for this request. If more
    /// objects are
    /// available, in the response, Amazon Web Services provides a NextPageToken
    /// value that you can use
    /// in a subsequent call to get the next batch of objects.
    max_results: ?i32 = null,

    /// The token to retrieve the next set of results. Amazon Web Services provides
    /// the token
    /// when the response from a previous call has more results than the maximum
    /// page size.
    next_page_token: ?[]const u8 = null,

    /// The value that you want to sort the data by.
    ///
    /// The following values are supported for `Key`:
    ///
    /// * `UtilizationPercentage`
    ///
    /// * `UtilizationPercentageInUnits`
    ///
    /// * `PurchasedHours`
    ///
    /// * `PurchasedUnits`
    ///
    /// * `TotalActualHours`
    ///
    /// * `TotalActualUnits`
    ///
    /// * `UnusedHours`
    ///
    /// * `UnusedUnits`
    ///
    /// * `OnDemandCostOfRIHoursUsed`
    ///
    /// * `NetRISavings`
    ///
    /// * `TotalPotentialRISavings`
    ///
    /// * `AmortizedUpfrontFee`
    ///
    /// * `AmortizedRecurringFee`
    ///
    /// * `TotalAmortizedFee`
    ///
    /// * `RICostForUnusedHours`
    ///
    /// * `RealizedSavings`
    ///
    /// * `UnrealizedSavings`
    ///
    /// The supported values for `SortOrder` are `ASCENDING` and
    /// `DESCENDING`.
    sort_by: ?SortDefinition = null,

    /// Sets the start and end dates for retrieving Reserved Instance (RI)
    /// utilization. The
    /// start date is inclusive, but the end date is exclusive. For example, if
    /// `start` is
    /// `2017-01-01` and `end` is `2017-05-01`, then the cost and
    /// usage data is retrieved from `2017-01-01` up to and including
    /// `2017-04-30` but not including `2017-05-01`.
    time_period: DateInterval,

    pub const json_field_names = .{
        .filter = "Filter",
        .granularity = "Granularity",
        .group_by = "GroupBy",
        .max_results = "MaxResults",
        .next_page_token = "NextPageToken",
        .sort_by = "SortBy",
        .time_period = "TimePeriod",
    };
};

pub const GetReservationUtilizationOutput = struct {
    /// The token for the next set of retrievable results. Amazon Web Services
    /// provides the token
    /// when the response from a previous call has more results than the maximum
    /// page size.
    next_page_token: ?[]const u8 = null,

    /// The total amount of time that you used your Reserved Instances (RIs).
    total: ?ReservationAggregates = null,

    /// The amount of time that you used your Reserved Instances (RIs).
    utilizations_by_time: ?[]const UtilizationByTime = null,

    pub const json_field_names = .{
        .next_page_token = "NextPageToken",
        .total = "Total",
        .utilizations_by_time = "UtilizationsByTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetReservationUtilizationInput, options: CallOptions) !GetReservationUtilizationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ce", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetReservationUtilizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ce", "Cost Explorer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.GetReservationUtilization");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetReservationUtilizationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetReservationUtilizationOutput, body, allocator);
}
