const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Expression = @import("expression.zig").Expression;
const Granularity = @import("granularity.zig").Granularity;
const GroupDefinition = @import("group_definition.zig").GroupDefinition;
const DateInterval = @import("date_interval.zig").DateInterval;
const DimensionValuesWithAttributes = @import("dimension_values_with_attributes.zig").DimensionValuesWithAttributes;
const ResultByTime = @import("result_by_time.zig").ResultByTime;

pub const GetCostAndUsageInput = struct {
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

    /// Filters Amazon Web Services costs by different dimensions. For example, you
    /// can specify
    /// `SERVICE` and `LINKED_ACCOUNT` and get the costs that are associated
    /// with that account's usage of that service. You can nest `Expression` objects
    /// to
    /// define any combination of dimension filters. For more information, see
    /// [Expression](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_Expression.html).
    ///
    /// Valid values for `MatchOptions` for `Dimensions` are
    /// `EQUALS` and `CASE_SENSITIVE`.
    ///
    /// Valid values for `MatchOptions` for `CostCategories` and
    /// `Tags` are `EQUALS`, `ABSENT`, and
    /// `CASE_SENSITIVE`. Default values are `EQUALS` and
    /// `CASE_SENSITIVE`.
    filter: ?Expression = null,

    /// Sets the Amazon Web Services cost granularity to `MONTHLY` or
    /// `DAILY`, or `HOURLY`. If `Granularity` isn't set, the
    /// response object doesn't include the `Granularity`, either `MONTHLY` or
    /// `DAILY`, or `HOURLY`.
    granularity: Granularity,

    /// You can group Amazon Web Services costs using up to two different groups,
    /// either
    /// dimensions, tag keys, cost categories, or any two group by types.
    ///
    /// Valid values for the `DIMENSION` type are `AZ`,
    /// `INSTANCE_TYPE`, `LEGAL_ENTITY_NAME`, `INVOICING_ENTITY`,
    /// `LINKED_ACCOUNT`, `OPERATION`, `PLATFORM`,
    /// `PURCHASE_TYPE`, `SERVICE`, `TENANCY`,
    /// `RECORD_TYPE`, and `USAGE_TYPE`.
    ///
    /// When you group by the `TAG` type and include a valid tag key, you get all
    /// tag values, including empty strings.
    group_by: ?[]const GroupDefinition = null,

    /// Which metrics are returned in the query. For more information about blended
    /// and
    /// unblended rates, see [Why does the "blended" annotation
    /// appear on some line items in my
    /// bill?](http://aws.amazon.com/premiumsupport/knowledge-center/blended-rates-intro/).
    ///
    /// Valid values are `AmortizedCost`, `BlendedCost`,
    /// `NetAmortizedCost`, `NetUnblendedCost`,
    /// `NormalizedUsageAmount`, `UnblendedCost`, and
    /// `UsageQuantity`.
    ///
    /// If you return the `UsageQuantity` metric, the service aggregates all usage
    /// numbers without taking into account the units. For example, if you aggregate
    /// `usageQuantity` across all of Amazon EC2, the results aren't meaningful
    /// because
    /// Amazon EC2 compute hours and data transfer are measured in different units
    /// (for example,
    /// hours and GB). To get more meaningful `UsageQuantity` metrics, filter by
    /// `UsageType` or `UsageTypeGroups`.
    ///
    /// `Metrics` is required for `GetCostAndUsage` requests.
    metrics: []const []const u8,

    /// The token to retrieve the next set of results. Amazon Web Services provides
    /// the token
    /// when the response from a previous call has more results than the maximum
    /// page size.
    next_page_token: ?[]const u8 = null,

    /// Sets the start date and end date for retrieving Amazon Web Services costs.
    /// The start
    /// date is inclusive, but the end date is exclusive. For example, if `start` is
    /// `2017-01-01` and `end` is `2017-05-01`, then the cost and
    /// usage data is retrieved from `2017-01-01` up to and including
    /// `2017-04-30` but not including `2017-05-01`.
    time_period: DateInterval,

    pub const json_field_names = .{
        .billing_view_arn = "BillingViewArn",
        .filter = "Filter",
        .granularity = "Granularity",
        .group_by = "GroupBy",
        .metrics = "Metrics",
        .next_page_token = "NextPageToken",
        .time_period = "TimePeriod",
    };
};

pub const GetCostAndUsageOutput = struct {
    /// The attributes that apply to a specific dimension value. For example, if the
    /// value is a
    /// linked account, the attribute is that account name.
    dimension_value_attributes: ?[]const DimensionValuesWithAttributes = null,

    /// The groups that are specified by the `Filter` or `GroupBy`
    /// parameters in the request.
    group_definitions: ?[]const GroupDefinition = null,

    /// The token for the next set of retrievable results. Amazon Web Services
    /// provides the token
    /// when the response from a previous call has more results than the maximum
    /// page size.
    next_page_token: ?[]const u8 = null,

    /// The time period that's covered by the results in the response.
    results_by_time: ?[]const ResultByTime = null,

    pub const json_field_names = .{
        .dimension_value_attributes = "DimensionValueAttributes",
        .group_definitions = "GroupDefinitions",
        .next_page_token = "NextPageToken",
        .results_by_time = "ResultsByTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCostAndUsageInput, options: CallOptions) !GetCostAndUsageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCostAndUsageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.GetCostAndUsage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCostAndUsageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetCostAndUsageOutput, body, allocator);
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
