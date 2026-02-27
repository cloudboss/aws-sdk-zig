const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ServiceType = @import("service_type.zig").ServiceType;
const AnalysisReportSummary = @import("analysis_report_summary.zig").AnalysisReportSummary;

pub const ListPerformanceAnalysisReportsInput = struct {
    /// An immutable identifier for a data source that is unique for an Amazon Web
    /// Services Region. Performance Insights gathers metrics from this data source.
    /// In the
    /// console, the identifier is shown as *ResourceID*. When you call
    /// `DescribeDBInstances`, the identifier is
    /// returned as `DbiResourceId`.
    ///
    /// To use a DB instance as a data source, specify its `DbiResourceId` value.
    /// For example, specify
    /// `db-ABCDEFGHIJKLMNOPQRSTU1VW2X`.
    identifier: []const u8,

    /// Specifies whether or not to include the list of tags in the response.
    list_tags: ?bool = null,

    /// The maximum number of items to return in the response. If more items exist
    /// than the specified `MaxResults` value, a
    /// pagination token is included in the response so that the remaining results
    /// can be retrieved.
    max_results: ?i32 = null,

    /// An optional pagination token provided by a previous request.
    /// If this parameter is specified, the response includes only records beyond
    /// the token, up to the value specified by `MaxResults`.
    next_token: ?[]const u8 = null,

    /// The Amazon Web Services service for which Performance Insights returns
    /// metrics. Valid value is
    /// `RDS`.
    service_type: ServiceType,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .list_tags = "ListTags",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .service_type = "ServiceType",
    };
};

pub const ListPerformanceAnalysisReportsOutput = struct {
    /// List of reports including the report identifier, start and end time,
    /// creation time,
    /// and status.
    analysis_reports: ?[]const AnalysisReportSummary = null,

    /// An optional pagination token provided by a previous request.
    /// If this parameter is specified, the response includes only records beyond
    /// the token,
    /// up to the value specified by `MaxResults`.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .analysis_reports = "AnalysisReports",
        .next_token = "NextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPerformanceAnalysisReportsInput, options: Options) !ListPerformanceAnalysisReportsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ListPerformanceAnalysisReportsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "PerformanceInsightsv20180227.ListPerformanceAnalysisReports");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListPerformanceAnalysisReportsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListPerformanceAnalysisReportsOutput, body, alloc);
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
