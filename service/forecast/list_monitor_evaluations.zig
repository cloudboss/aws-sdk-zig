const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const PredictorMonitorEvaluation = @import("predictor_monitor_evaluation.zig").PredictorMonitorEvaluation;

pub const ListMonitorEvaluationsInput = struct {
    /// An array of filters. For each filter, provide a condition and a match
    /// statement. The
    /// condition is either `IS` or `IS_NOT`, which specifies whether to
    /// include or exclude the resources that match the statement from the list. The
    /// match
    /// statement consists of a key and a value.
    ///
    /// **Filter properties**
    ///
    /// * `Condition` - The condition to apply. Valid values are
    /// `IS` and `IS_NOT`.
    ///
    /// * `Key` - The name of the parameter to filter on. The only valid value is
    /// `EvaluationState`.
    ///
    /// * `Value` - The value to match. Valid values are only `SUCCESS` or
    ///   `FAILURE`.
    ///
    /// For example, to list only successful monitor evaluations, you would specify:
    ///
    /// `"Filters": [ { "Condition": "IS", "Key": "EvaluationState", "Value":
    /// "SUCCESS" } ]`
    filters: ?[]const Filter = null,

    /// The maximum number of monitoring results to return.
    max_results: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the monitor resource to get results from.
    monitor_arn: []const u8,

    /// If the result of the previous request was truncated, the response includes a
    /// `NextToken`. To retrieve the next set of results, use the token in the next
    /// request. Tokens expire after 24 hours.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .monitor_arn = "MonitorArn",
        .next_token = "NextToken",
    };
};

pub const ListMonitorEvaluationsOutput = struct {
    /// If the response is truncated, Amazon Forecast returns this token. To
    /// retrieve the next set of
    /// results, use the token in the next request. Tokens expire after 24 hours.
    next_token: ?[]const u8 = null,

    /// The monitoring results and predictor events collected by the monitor
    /// resource during different windows of time.
    ///
    /// For information about monitoring see [Viewing Monitoring
    /// Results](https://docs.aws.amazon.com/forecast/latest/dg/predictor-monitoring-results.html). For more information about retrieving monitoring results see [Viewing Monitoring Results](https://docs.aws.amazon.com/forecast/latest/dg/predictor-monitoring-results.html).
    predictor_monitor_evaluations: ?[]const PredictorMonitorEvaluation = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .predictor_monitor_evaluations = "PredictorMonitorEvaluations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMonitorEvaluationsInput, options: CallOptions) !ListMonitorEvaluationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "forecast");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMonitorEvaluationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("forecast", "forecast", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.ListMonitorEvaluations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMonitorEvaluationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListMonitorEvaluationsOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
