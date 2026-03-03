const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ApplicationSource = @import("application_source.zig").ApplicationSource;
const ScalingPlan = @import("scaling_plan.zig").ScalingPlan;

pub const DescribeScalingPlansInput = struct {
    /// The sources for the applications (up to 10). If you specify scaling plan
    /// names, you
    /// cannot specify application sources.
    application_sources: ?[]const ApplicationSource = null,

    /// The maximum number of scalable resources to return. This value can be
    /// between
    /// 1 and 50. The default value is 50.
    max_results: ?i32 = null,

    /// The token for the next set of results.
    next_token: ?[]const u8 = null,

    /// The names of the scaling plans (up to 10). If you specify application
    /// sources, you
    /// cannot specify scaling plan names.
    scaling_plan_names: ?[]const []const u8 = null,

    /// The version number of the scaling plan. Currently, the only valid value is
    /// `1`.
    ///
    /// If you specify a scaling plan version, you must also specify a scaling plan
    /// name.
    scaling_plan_version: ?i64 = null,

    pub const json_field_names = .{
        .application_sources = "ApplicationSources",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .scaling_plan_names = "ScalingPlanNames",
        .scaling_plan_version = "ScalingPlanVersion",
    };
};

pub const DescribeScalingPlansOutput = struct {
    /// The token required to get the next set of results. This value is `null` if
    /// there are no more results to return.
    next_token: ?[]const u8 = null,

    /// Information about the scaling plans.
    scaling_plans: ?[]const ScalingPlan = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .scaling_plans = "ScalingPlans",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeScalingPlansInput, options: Options) !DescribeScalingPlansOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "autoscalingplans");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeScalingPlansInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscalingplans", "Auto Scaling Plans", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AnyScaleScalingPlannerFrontendService.DescribeScalingPlans");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeScalingPlansOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeScalingPlansOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConcurrentUpdateException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_update_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
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
    if (std.mem.eql(u8, error_code, "ObjectNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .object_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
