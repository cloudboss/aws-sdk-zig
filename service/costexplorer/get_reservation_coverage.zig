const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Expression = @import("expression.zig").Expression;
const Granularity = @import("granularity.zig").Granularity;
const GroupDefinition = @import("group_definition.zig").GroupDefinition;
const SortDefinition = @import("sort_definition.zig").SortDefinition;
const DateInterval = @import("date_interval.zig").DateInterval;
const CoverageByTime = @import("coverage_by_time.zig").CoverageByTime;
const Coverage = @import("coverage.zig").Coverage;

pub const GetReservationCoverageInput = struct {
    /// Filters utilization data by dimensions. You can filter by the following
    /// dimensions:
    ///
    /// * AZ
    ///
    /// * CACHE_ENGINE
    ///
    /// * DATABASE_ENGINE
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
    /// * TAG
    ///
    /// * TENANCY
    ///
    /// `GetReservationCoverage` uses the same
    /// [Expression](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_Expression.html) object
    /// as the other operations, but only `AND` is supported among each dimension.
    /// You can
    /// nest only one level deep. If there are multiple values for a dimension, they
    /// are OR'd
    /// together.
    ///
    /// If you don't provide a `SERVICE` filter, Cost Explorer defaults to
    /// EC2.
    ///
    /// Cost category is also supported.
    filter: ?Expression = null,

    /// The granularity of the Amazon Web Services cost data for the reservation.
    /// Valid values
    /// are `MONTHLY` and `DAILY`.
    ///
    /// If `GroupBy` is set, `Granularity` can't be set. If
    /// `Granularity` isn't set, the response object doesn't include
    /// `Granularity`, either `MONTHLY` or `DAILY`.
    ///
    /// The `GetReservationCoverage` operation supports only `DAILY` and
    /// `MONTHLY` granularities.
    granularity: ?Granularity = null,

    /// You can group the data by the following attributes:
    ///
    /// * AZ
    ///
    /// * CACHE_ENGINE
    ///
    /// * DATABASE_ENGINE
    ///
    /// * DEPLOYMENT_OPTION
    ///
    /// * INSTANCE_TYPE
    ///
    /// * INVOICING_ENTITY
    ///
    /// * LINKED_ACCOUNT
    ///
    /// * OPERATING_SYSTEM
    ///
    /// * PLATFORM
    ///
    /// * REGION
    ///
    /// * TENANCY
    group_by: ?[]const GroupDefinition = null,

    /// The maximum number of objects that you returned for this request. If more
    /// objects are
    /// available, in the response, Amazon Web Services provides a NextPageToken
    /// value that you can use
    /// in a subsequent call to get the next batch of objects.
    max_results: ?i32 = null,

    /// The measurement that you want your reservation coverage reported in.
    ///
    /// Valid values are `Hour`, `Unit`, and `Cost`. You can use
    /// multiple values in a request.
    metrics: ?[]const []const u8 = null,

    /// The token to retrieve the next set of results. Amazon Web Services provides
    /// the token
    /// when the response from a previous call has more results than the maximum
    /// page size.
    next_page_token: ?[]const u8 = null,

    /// The value by which you want to sort the data.
    ///
    /// The following values are supported for `Key`:
    ///
    /// * `OnDemandCost`
    ///
    /// * `CoverageHoursPercentage`
    ///
    /// * `OnDemandHours`
    ///
    /// * `ReservedHours`
    ///
    /// * `TotalRunningHours`
    ///
    /// * `CoverageNormalizedUnitsPercentage`
    ///
    /// * `OnDemandNormalizedUnits`
    ///
    /// * `ReservedNormalizedUnits`
    ///
    /// * `TotalRunningNormalizedUnits`
    ///
    /// * `Time`
    ///
    /// Supported values for `SortOrder` are `ASCENDING` or
    /// `DESCENDING`.
    sort_by: ?SortDefinition = null,

    /// The start and end dates of the period that you want to retrieve data about
    /// reservation
    /// coverage for. You can retrieve data for a maximum of 13 months: the last 12
    /// months and the
    /// current month. The start date is inclusive, but the end date is exclusive.
    /// For example, if
    /// `start` is `2017-01-01` and `end` is
    /// `2017-05-01`, then the cost and usage data is retrieved from
    /// `2017-01-01` up to and including `2017-04-30` but not including
    /// `2017-05-01`.
    time_period: DateInterval,

    pub const json_field_names = .{
        .filter = "Filter",
        .granularity = "Granularity",
        .group_by = "GroupBy",
        .max_results = "MaxResults",
        .metrics = "Metrics",
        .next_page_token = "NextPageToken",
        .sort_by = "SortBy",
        .time_period = "TimePeriod",
    };
};

pub const GetReservationCoverageOutput = struct {
    /// The amount of time that your reservations covered.
    coverages_by_time: ?[]const CoverageByTime = null,

    /// The token for the next set of retrievable results. Amazon Web Services
    /// provides the token
    /// when the response from a previous call has more results than the maximum
    /// page size.
    next_page_token: ?[]const u8 = null,

    /// The total amount of instance usage that a reservation covered.
    total: ?Coverage = null,

    pub const json_field_names = .{
        .coverages_by_time = "CoveragesByTime",
        .next_page_token = "NextPageToken",
        .total = "Total",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetReservationCoverageInput, options: Options) !GetReservationCoverageOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetReservationCoverageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("costexplorer", "Cost Explorer", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AWSInsightsIndexService.GetReservationCoverage");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetReservationCoverageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetReservationCoverageOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
