const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ReportGroupTrendFieldType = @import("report_group_trend_field_type.zig").ReportGroupTrendFieldType;
const ReportWithRawData = @import("report_with_raw_data.zig").ReportWithRawData;
const ReportGroupTrendStats = @import("report_group_trend_stats.zig").ReportGroupTrendStats;

pub const GetReportGroupTrendInput = struct {
    /// The number of reports to analyze. This operation always retrieves the most
    /// recent
    /// reports.
    ///
    /// If this parameter is omitted, the most recent 100 reports are analyzed.
    num_of_reports: ?i32 = null,

    /// The ARN of the report group that contains the reports to analyze.
    report_group_arn: []const u8,

    /// The test report value to accumulate. This must be one of the following
    /// values:
    ///
    /// **Test reports:**
    ///
    /// **DURATION**
    ///
    /// Accumulate the test run times for the specified
    /// reports.
    ///
    /// **PASS_RATE**
    ///
    /// Accumulate the percentage of tests that passed for the
    /// specified test reports.
    ///
    /// **TOTAL**
    ///
    /// Accumulate the total number of tests for the specified test
    /// reports.
    ///
    /// **Code coverage reports:**
    ///
    /// **BRANCH_COVERAGE**
    ///
    /// Accumulate the branch coverage percentages for the specified
    /// test reports.
    ///
    /// **BRANCHES_COVERED**
    ///
    /// Accumulate the branches covered values for the specified test
    /// reports.
    ///
    /// **BRANCHES_MISSED**
    ///
    /// Accumulate the branches missed values for the specified test
    /// reports.
    ///
    /// **LINE_COVERAGE**
    ///
    /// Accumulate the line coverage percentages for the specified
    /// test reports.
    ///
    /// **LINES_COVERED**
    ///
    /// Accumulate the lines covered values for the specified test
    /// reports.
    ///
    /// **LINES_MISSED**
    ///
    /// Accumulate the lines not covered values for the specified test
    /// reports.
    trend_field: ReportGroupTrendFieldType,

    pub const json_field_names = .{
        .num_of_reports = "numOfReports",
        .report_group_arn = "reportGroupArn",
        .trend_field = "trendField",
    };
};

pub const GetReportGroupTrendOutput = struct {
    /// An array that contains the raw data for each report.
    raw_data: ?[]const ReportWithRawData = null,

    /// Contains the accumulated trend data.
    stats: ?ReportGroupTrendStats = null,

    pub const json_field_names = .{
        .raw_data = "rawData",
        .stats = "stats",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetReportGroupTrendInput, options: Options) !GetReportGroupTrendOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "codebuild");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetReportGroupTrendInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codebuild", "CodeBuild", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "CodeBuild_20161006.GetReportGroupTrend");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetReportGroupTrendOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetReportGroupTrendOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "AccountLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .account_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccountSuspendedException")) {
        return .{ .arena = arena, .kind = .{ .account_suspended_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OAuthProviderException")) {
        return .{ .arena = arena, .kind = .{ .o_auth_provider_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
