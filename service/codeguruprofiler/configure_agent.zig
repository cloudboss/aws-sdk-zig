const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeguru-profiler", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ConfigureAgentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-profiler", "CodeGuruProfiler", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/profilingGroups/");
    try path_buf.appendSlice(allocator, input.profiling_group_name);
    try path_buf.appendSlice(allocator, "/configureAgent");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
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
