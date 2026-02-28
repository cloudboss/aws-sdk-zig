const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EvaluationStatus = @import("evaluation_status.zig").EvaluationStatus;
const ResourceWarning = @import("resource_warning.zig").ResourceWarning;

pub const GetPlanEvaluationStatusInput = struct {
    /// The number of objects that you want to return with this call.
    max_results: ?i32 = null,

    /// Specifies that you want to receive the next page of results. Valid only if
    /// you received a `nextToken` response in the previous request. If you did, it
    /// indicates that more output is available. Set this parameter to the value
    /// provided by the previous call's `nextToken` response to request the next
    /// page of results.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Region switch plan to retrieve
    /// evaluation status for.
    plan_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .plan_arn = "planArn",
    };
};

pub const GetPlanEvaluationStatusOutput = struct {
    /// The evaluation state for the plan.
    evaluation_state: ?EvaluationStatus = null,

    /// The version of the last evaluation of the plan.
    last_evaluated_version: ?[]const u8 = null,

    /// The time of the last time that Region switch ran an evaluation of the plan.
    last_evaluation_time: ?i64 = null,

    /// Specifies that you want to receive the next page of results. Valid only if
    /// you received a `nextToken` response in the previous request. If you did, it
    /// indicates that more output is available. Set this parameter to the value
    /// provided by the previous call's `nextToken` response to request the next
    /// page of results.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the plan.
    plan_arn: []const u8,

    /// The Amazon Web Services Region for the plan.
    region: ?[]const u8 = null,

    /// The current evaluation warnings for the plan.
    warnings: ?[]const ResourceWarning = null,

    pub const json_field_names = .{
        .evaluation_state = "evaluationState",
        .last_evaluated_version = "lastEvaluatedVersion",
        .last_evaluation_time = "lastEvaluationTime",
        .next_token = "nextToken",
        .plan_arn = "planArn",
        .region = "region",
        .warnings = "warnings",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPlanEvaluationStatusInput, options: Options) !GetPlanEvaluationStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "arcregionswitch");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetPlanEvaluationStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("arcregionswitch", "ARC Region switch", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "ArcRegionSwitch.GetPlanEvaluationStatus");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetPlanEvaluationStatusOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetPlanEvaluationStatusOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IllegalArgumentException")) {
        return .{ .arena = arena, .kind = .{ .illegal_argument_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IllegalStateException")) {
        return .{ .arena = arena, .kind = .{ .illegal_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
