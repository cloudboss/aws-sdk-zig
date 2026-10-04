const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Expression = @import("expression.zig").Expression;
const Granularity = @import("granularity.zig").Granularity;
const Metric = @import("metric.zig").Metric;
const DateInterval = @import("date_interval.zig").DateInterval;
const ForecastResult = @import("forecast_result.zig").ForecastResult;
const MetricValue = @import("metric_value.zig").MetricValue;

pub const GetCostForecastInput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies a specific billing
    /// view. The ARN
    /// is used to specify which particular billing view you want to interact with
    /// or retrieve
    /// information from when making API calls related to Amazon Web Services
    /// Billing and Cost
    /// Management features. The BillingViewArn can be retrieved by calling the
    /// ListBillingViews
    /// API.
    billing_view_arn: ?[]const u8 = null,

    /// The filters that you want to use to filter your forecast. The
    /// `GetCostForecast` API supports filtering by the following dimensions:
    ///
    /// * `AZ`
    ///
    /// * `INSTANCE_TYPE`
    ///
    /// * `LINKED_ACCOUNT`
    ///
    /// * `OPERATION`
    ///
    /// * `PURCHASE_TYPE`
    ///
    /// * `REGION`
    ///
    /// * `SERVICE`
    ///
    /// * `USAGE_TYPE`
    ///
    /// * `USAGE_TYPE_GROUP`
    ///
    /// * `RECORD_TYPE`
    ///
    /// * `OPERATING_SYSTEM`
    ///
    /// * `TENANCY`
    ///
    /// * `SCOPE`
    ///
    /// * `PLATFORM`
    ///
    /// * `SUBSCRIPTION_ID`
    ///
    /// * `LEGAL_ENTITY_NAME`
    ///
    /// * `DEPLOYMENT_OPTION`
    ///
    /// * `DATABASE_ENGINE`
    ///
    /// * `INSTANCE_TYPE_FAMILY`
    ///
    /// * `BILLING_ENTITY`
    ///
    /// * `RESERVATION_ID`
    ///
    /// * `SAVINGS_PLAN_ARN`
    filter: ?Expression = null,

    /// How granular you want the forecast to be. You can get 3 months of `DAILY`
    /// forecasts or 18 months of `MONTHLY` forecasts.
    ///
    /// The `GetCostForecast` operation supports only `DAILY` and
    /// `MONTHLY` granularities.
    granularity: Granularity,

    /// Which metric Cost Explorer uses to create your forecast. For more
    /// information about
    /// blended and unblended rates, see [Why does the "blended" annotation
    /// appear on some line items in my
    /// bill?](http://aws.amazon.com/premiumsupport/knowledge-center/blended-rates-intro/).
    ///
    /// Valid values for a `GetCostForecast` call are the following:
    ///
    /// * AMORTIZED_COST
    ///
    /// * BLENDED_COST
    ///
    /// * NET_AMORTIZED_COST
    ///
    /// * NET_UNBLENDED_COST
    ///
    /// * UNBLENDED_COST
    metric: Metric,

    /// Cost Explorer always returns the mean forecast as a single point. You can
    /// request a
    /// prediction interval around the mean by specifying a confidence level. The
    /// higher the
    /// confidence level, the more confident Cost Explorer is about the actual value
    /// falling in the
    /// prediction interval. Higher confidence levels result in wider prediction
    /// intervals.
    prediction_interval_level: ?i32 = null,

    /// The period of time that you want the forecast to cover. The start date must
    /// be equal to or
    /// no later than the current date to avoid a validation error.
    time_period: DateInterval,

    pub const json_field_names = .{
        .billing_view_arn = "BillingViewArn",
        .filter = "Filter",
        .granularity = "Granularity",
        .metric = "Metric",
        .prediction_interval_level = "PredictionIntervalLevel",
        .time_period = "TimePeriod",
    };
};

pub const GetCostForecastOutput = struct {
    /// The forecasts for your query, in order. For `DAILY` forecasts, this is a
    /// list
    /// of days. For `MONTHLY` forecasts, this is a list of months.
    forecast_results_by_time: ?[]const ForecastResult = null,

    /// How much you are forecasted to spend over the forecast period, in `USD`.
    total: ?MetricValue = null,

    pub const json_field_names = .{
        .forecast_results_by_time = "ForecastResultsByTime",
        .total = "Total",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCostForecastInput, options: CallOptions) !GetCostForecastOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCostForecastInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.GetCostForecast");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCostForecastOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetCostForecastOutput, body, allocator);
}
