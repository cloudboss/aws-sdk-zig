const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Expression = @import("expression.zig").Expression;
const Granularity = @import("granularity.zig").Granularity;
const Metric = @import("metric.zig").Metric;
const DateInterval = @import("date_interval.zig").DateInterval;
const ForecastResult = @import("forecast_result.zig").ForecastResult;
const MetricValue = @import("metric_value.zig").MetricValue;

pub const GetUsageForecastInput = struct {
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
    /// `GetUsageForecast` API supports filtering by the following dimensions:
    ///
    /// * `AZ`
    ///
    /// * `INSTANCE_TYPE`
    ///
    /// * `LINKED_ACCOUNT`
    ///
    /// * `LINKED_ACCOUNT_NAME`
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
    /// The `GetUsageForecast` operation supports only `DAILY` and
    /// `MONTHLY` granularities.
    granularity: Granularity,

    /// Which metric Cost Explorer uses to create your forecast.
    ///
    /// Valid values for a `GetUsageForecast` call are the following:
    ///
    /// * USAGE_QUANTITY
    ///
    /// * NORMALIZED_USAGE_AMOUNT
    metric: Metric,

    /// Amazon Web Services Cost Explorer always returns the mean forecast as a
    /// single point.
    /// You can request a prediction interval around the mean by specifying a
    /// confidence level. The
    /// higher the confidence level, the more confident Cost Explorer is about the
    /// actual value
    /// falling in the prediction interval. Higher confidence levels result in wider
    /// prediction
    /// intervals.
    prediction_interval_level: ?i32 = null,

    /// The start and end dates of the period that you want to retrieve usage
    /// forecast for. The
    /// start date is included in the period, but the end date isn't included in the
    /// period. For
    /// example, if `start` is `2017-01-01` and `end` is
    /// `2017-05-01`, then the cost and usage data is retrieved from
    /// `2017-01-01` up to and including `2017-04-30` but not including
    /// `2017-05-01`. The start date must be equal to or later than the current date
    /// to
    /// avoid a validation error.
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

pub const GetUsageForecastOutput = struct {
    /// The forecasts for your query, in order. For `DAILY` forecasts, this is a
    /// list of days. For `MONTHLY` forecasts, this is a list of months.
    forecast_results_by_time: ?[]const ForecastResult = null,

    /// How much you're forecasted to use over the forecast period.
    total: ?MetricValue = null,

    pub const json_field_names = .{
        .forecast_results_by_time = "ForecastResultsByTime",
        .total = "Total",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUsageForecastInput, options: CallOptions) !GetUsageForecastOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ce");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUsageForecastInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ce", "Cost Explorer", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.GetUsageForecast");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUsageForecastOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetUsageForecastOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AnalysisNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .analysis_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BackfillLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .backfill_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BillExpirationException")) {
        return .{ .arena = arena, .kind = .{ .bill_expiration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BillingViewHealthStatusException")) {
        return .{ .arena = arena, .kind = .{ .billing_view_health_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DataUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .data_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GenerationExistsException")) {
        return .{ .arena = arena, .kind = .{ .generation_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
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
    if (std.mem.eql(u8, error_code, "RequestChangedException")) {
        return .{ .arena = arena, .kind = .{ .request_changed_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnknownMonitorException")) {
        return .{ .arena = arena, .kind = .{ .unknown_monitor_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnknownSubscriptionException")) {
        return .{ .arena = arena, .kind = .{ .unknown_subscription_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnresolvableUsageUnitException")) {
        return .{ .arena = arena, .kind = .{ .unresolvable_usage_unit_exception = .{
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
