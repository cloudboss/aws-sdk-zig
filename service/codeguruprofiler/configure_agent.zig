const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AgentConfiguration = @import("agent_configuration.zig").AgentConfiguration;

pub const ConfigureAgentInput = struct {
    /// A universally unique identifier (UUID) for a profiling instance. For
    /// example, if the
    /// profiling instance is an Amazon EC2 instance, it is the instance ID. If it
    /// is an AWS
    /// Fargate container, it is the container's task ID.
    fleet_instance_id: ?[]const u8 = null,

    /// Metadata captured about the compute platform the agent is running on. It
    /// includes
    /// information about sampling and reporting. The valid fields are:
    ///
    /// * `COMPUTE_PLATFORM` - The compute platform on which the agent is running
    ///
    /// * `AGENT_ID` - The ID for an agent instance.
    ///
    /// * `AWS_REQUEST_ID` - The AWS request ID of a Lambda invocation.
    ///
    /// * `EXECUTION_ENVIRONMENT` - The execution environment a Lambda function is
    ///   running on.
    ///
    /// * `LAMBDA_FUNCTION_ARN` - The Amazon Resource Name (ARN) that is used to
    ///   invoke a Lambda function.
    ///
    /// * `LAMBDA_MEMORY_LIMIT_IN_MB` - The memory allocated to a Lambda function.
    ///
    /// * `LAMBDA_REMAINING_TIME_IN_MILLISECONDS` - The time in milliseconds before
    ///   execution of a Lambda function times out.
    ///
    /// * `LAMBDA_TIME_GAP_BETWEEN_INVOKES_IN_MILLISECONDS` - The time in
    ///   milliseconds between two invocations of a Lambda function.
    ///
    /// * `LAMBDA_PREVIOUS_EXECUTION_TIME_IN_MILLISECONDS` - The time in
    ///   milliseconds for the previous Lambda invocation.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// The name of the profiling group for which the configured agent is collecting
    /// profiling data.
    profiling_group_name: []const u8,

    pub const json_field_names = .{
        .fleet_instance_id = "fleetInstanceId",
        .metadata = "metadata",
        .profiling_group_name = "profilingGroupName",
    };
};

pub const ConfigureAgentOutput = struct {
    /// An [
    /// `AgentConfiguration`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_AgentConfiguration.html)
    /// object that specifies if an agent profiles or not and for how long to return
    /// profiling data.
    configuration: ?AgentConfiguration = null,

    pub const json_field_names = .{
        .configuration = "configuration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ConfigureAgentInput, options: CallOptions) !ConfigureAgentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "codeguruprofiler");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ConfigureAgentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguruprofiler", "CodeGuruProfiler", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/profilingGroups/");
    try path_buf.appendSlice(allocator, input.profiling_group_name);
    try path_buf.appendSlice(allocator, "/configureAgent");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.fleet_instance_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"fleetInstanceId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"metadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ConfigureAgentOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: ConfigureAgentOutput = .{};

    return result;
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
