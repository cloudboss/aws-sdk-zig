const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Baseline = @import("baseline.zig").Baseline;

pub const DescribeMonitorInput = struct {
    /// The Amazon Resource Name (ARN) of the monitor resource to describe.
    monitor_arn: []const u8,

    pub const json_field_names = .{
        .monitor_arn = "MonitorArn",
    };
};

pub const DescribeMonitorOutput = struct {
    /// Metrics you can use as a baseline for comparison purposes. Use these values
    /// you interpret monitoring results for an auto predictor.
    baseline: ?Baseline = null,

    /// The timestamp for when the monitor resource was created.
    creation_time: ?i64 = null,

    /// The estimated number of minutes remaining before the monitor resource
    /// finishes its current evaluation.
    estimated_evaluation_time_remaining_in_minutes: ?i64 = null,

    /// The state of the monitor's latest evaluation.
    last_evaluation_state: ?[]const u8 = null,

    /// The timestamp of the latest evaluation completed by the monitor.
    last_evaluation_time: ?i64 = null,

    /// The timestamp of the latest modification to the monitor.
    last_modification_time: ?i64 = null,

    /// An error message, if any, for the monitor.
    message: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the monitor resource described.
    monitor_arn: ?[]const u8 = null,

    /// The name of the monitor.
    monitor_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the auto predictor being monitored.
    resource_arn: ?[]const u8 = null,

    /// The status of the monitor resource.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .baseline = "Baseline",
        .creation_time = "CreationTime",
        .estimated_evaluation_time_remaining_in_minutes = "EstimatedEvaluationTimeRemainingInMinutes",
        .last_evaluation_state = "LastEvaluationState",
        .last_evaluation_time = "LastEvaluationTime",
        .last_modification_time = "LastModificationTime",
        .message = "Message",
        .monitor_arn = "MonitorArn",
        .monitor_name = "MonitorName",
        .resource_arn = "ResourceArn",
        .status = "Status",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMonitorInput, options: Options) !DescribeMonitorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMonitorInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.DescribeMonitor");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMonitorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeMonitorOutput, body, allocator);
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
