const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ScalableDimension = @import("scalable_dimension.zig").ScalableDimension;
const ServiceNamespace = @import("service_namespace.zig").ServiceNamespace;
const CapacityForecast = @import("capacity_forecast.zig").CapacityForecast;
const LoadForecast = @import("load_forecast.zig").LoadForecast;

pub const GetPredictiveScalingForecastInput = struct {
    /// The exclusive end time of the time range for the forecast data to get. The
    /// maximum
    /// time duration between the start and end time is 30 days.
    end_time: i64,

    /// The name of the policy.
    policy_name: []const u8,

    /// The identifier of the resource.
    resource_id: []const u8,

    /// The scalable dimension.
    scalable_dimension: ScalableDimension,

    /// The namespace of the Amazon Web Services service that provides the resource.
    /// For a resource provided
    /// by your own application or service, use `custom-resource` instead.
    service_namespace: ServiceNamespace,

    /// The inclusive start time of the time range for the forecast data to get. At
    /// most, the
    /// date and time can be one year before the current date and time
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .policy_name = "PolicyName",
        .resource_id = "ResourceId",
        .scalable_dimension = "ScalableDimension",
        .service_namespace = "ServiceNamespace",
        .start_time = "StartTime",
    };
};

pub const GetPredictiveScalingForecastOutput = struct {
    /// The capacity forecast.
    capacity_forecast: ?CapacityForecast = null,

    /// The load forecast.
    load_forecast: ?[]const LoadForecast = null,

    /// The time the forecast was made.
    update_time: ?i64 = null,

    pub const json_field_names = .{
        .capacity_forecast = "CapacityForecast",
        .load_forecast = "LoadForecast",
        .update_time = "UpdateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPredictiveScalingForecastInput, options: CallOptions) !GetPredictiveScalingForecastOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "application-autoscaling");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPredictiveScalingForecastInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("application-autoscaling", "Application Auto Scaling", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AnyScaleFrontendService.GetPredictiveScalingForecast");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPredictiveScalingForecastOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetPredictiveScalingForecastOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "FailedResourceAccessException")) {
        return .{ .arena = arena, .kind = .{ .failed_resource_access_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
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
