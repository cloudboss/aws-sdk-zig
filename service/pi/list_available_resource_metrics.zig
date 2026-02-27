const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ServiceType = @import("service_type.zig").ServiceType;
const ResponseResourceMetric = @import("response_resource_metric.zig").ResponseResourceMetric;

pub const ListAvailableResourceMetricsInput = struct {
    /// An immutable identifier for a data source that is unique within an Amazon
    /// Web Services Region. Performance Insights gathers
    /// metrics from this data source. To use an Amazon RDS DB instance as a data
    /// source, specify its
    /// `DbiResourceId` value. For example, specify `db-ABCDEFGHIJKLMNOPQRSTU1VWZ`.
    identifier: []const u8,

    /// The maximum number of items to return. If the `MaxRecords` value is less
    /// than the number
    /// of existing items, the response includes a pagination token.
    max_results: ?i32 = null,

    /// The types of metrics to return in the response. Valid values in the array
    /// include the following:
    ///
    /// * `os` (OS counter metrics) - All engines
    ///
    /// * `db` (DB load metrics) - All engines except for Amazon DocumentDB
    ///
    /// * `db.sql.stats` (per-SQL metrics) - All engines except for Amazon
    ///   DocumentDB
    ///
    /// * `db.sql_tokenized.stats` (per-SQL digest metrics) - All engines except for
    ///   Amazon DocumentDB
    metric_types: []const []const u8,

    /// An optional pagination token provided by a previous request. If this
    /// parameter is specified,
    /// the response includes only records beyond the token, up to the value
    /// specified by `MaxRecords`.
    next_token: ?[]const u8 = null,

    /// The Amazon Web Services service for which Performance Insights returns
    /// metrics.
    service_type: ServiceType,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .max_results = "MaxResults",
        .metric_types = "MetricTypes",
        .next_token = "NextToken",
        .service_type = "ServiceType",
    };
};

pub const ListAvailableResourceMetricsOutput = struct {
    /// An array of metrics available to query. Each array element contains the full
    /// name,
    /// description, and unit of the metric.
    metrics: ?[]const ResponseResourceMetric = null,

    /// A pagination token that indicates the response didn’t return all available
    /// records because `MaxRecords` was specified in the
    /// previous request. To get the remaining records, specify `NextToken` in a
    /// separate request with this value.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .metrics = "Metrics",
        .next_token = "NextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAvailableResourceMetricsInput, options: Options) !ListAvailableResourceMetricsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "pi");

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

fn serializeRequest(alloc: std.mem.Allocator, input: ListAvailableResourceMetricsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pi", "PI", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "PerformanceInsightsv20180227.ListAvailableResourceMetrics");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListAvailableResourceMetricsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAvailableResourceMetricsOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "InternalServiceError")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidArgumentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_argument_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotAuthorizedException")) {
        return .{ .arena = arena, .kind = .{ .not_authorized_exception = .{
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
