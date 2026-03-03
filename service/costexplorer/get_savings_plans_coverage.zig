const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Expression = @import("expression.zig").Expression;
const Granularity = @import("granularity.zig").Granularity;
const GroupDefinition = @import("group_definition.zig").GroupDefinition;
const SortDefinition = @import("sort_definition.zig").SortDefinition;
const DateInterval = @import("date_interval.zig").DateInterval;
const SavingsPlansCoverage = @import("savings_plans_coverage.zig").SavingsPlansCoverage;

pub const GetSavingsPlansCoverageInput = struct {
    /// Filters Savings Plans coverage data by dimensions. You can filter data for
    /// Savings Plans
    /// usage with the following dimensions:
    ///
    /// * `LINKED_ACCOUNT`
    ///
    /// * `REGION`
    ///
    /// * `SERVICE`
    ///
    /// * `INSTANCE_FAMILY`
    ///
    /// `GetSavingsPlansCoverage` uses the same
    /// [Expression](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_Expression.html) object
    /// as the other operations, but only `AND` is supported among each dimension.
    /// If there
    /// are multiple values for a dimension, they are OR'd together.
    ///
    /// Cost category is also supported.
    filter: ?Expression = null,

    /// The granularity of the Amazon Web Services cost data for your Savings Plans.
    /// `Granularity` can't be set if `GroupBy` is set.
    ///
    /// The `GetSavingsPlansCoverage` operation supports only `DAILY` and
    /// `MONTHLY` granularities.
    granularity: ?Granularity = null,

    /// You can group the data using the attributes `INSTANCE_FAMILY`,
    /// `REGION`, or `SERVICE`.
    group_by: ?[]const GroupDefinition = null,

    /// The number of items to be returned in a response. The default is `20`, with
    /// a
    /// minimum value of `1`.
    max_results: ?i32 = null,

    /// The measurement that you want your Savings Plans coverage reported in. The
    /// only valid
    /// value is `SpendCoveredBySavingsPlans`.
    metrics: ?[]const []const u8 = null,

    /// The token to retrieve the next set of results. Amazon Web Services provides
    /// the token when
    /// the response from a previous call has more results than the maximum page
    /// size.
    next_token: ?[]const u8 = null,

    /// The value that you want to sort the data by.
    ///
    /// The following values are supported for `Key`:
    ///
    /// * `SpendCoveredBySavingsPlan`
    ///
    /// * `OnDemandCost`
    ///
    /// * `CoveragePercentage`
    ///
    /// * `TotalCost`
    ///
    /// * `InstanceFamily`
    ///
    /// * `Region`
    ///
    /// * `Service`
    ///
    /// The supported values for `SortOrder` are `ASCENDING` and
    /// `DESCENDING`.
    sort_by: ?SortDefinition = null,

    /// The time period that you want the usage and costs for. The `Start` date must
    /// be
    /// within 13 months. The `End` date must be after the `Start` date, and
    /// before the current date. Future dates can't be used as an `End` date.
    time_period: DateInterval,

    pub const json_field_names = .{
        .filter = "Filter",
        .granularity = "Granularity",
        .group_by = "GroupBy",
        .max_results = "MaxResults",
        .metrics = "Metrics",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .time_period = "TimePeriod",
    };
};

pub const GetSavingsPlansCoverageOutput = struct {
    /// The token to retrieve the next set of results. Amazon Web Services provides
    /// the token when
    /// the response from a previous call has more results than the maximum page
    /// size.
    next_token: ?[]const u8 = null,

    /// The amount of spend that your Savings Plans covered.
    savings_plans_coverages: ?[]const SavingsPlansCoverage = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .savings_plans_coverages = "SavingsPlansCoverages",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSavingsPlansCoverageInput, options: Options) !GetSavingsPlansCoverageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "costexplorer");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSavingsPlansCoverageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("costexplorer", "Cost Explorer", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.GetSavingsPlansCoverage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSavingsPlansCoverageOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetSavingsPlansCoverageOutput, body, allocator);
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
