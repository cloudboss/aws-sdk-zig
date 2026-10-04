const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AgentOrchestrationConfig = @import("agent_orchestration_config.zig").AgentOrchestrationConfig;
const ProfilingGroupDescription = @import("profiling_group_description.zig").ProfilingGroupDescription;

pub const UpdateProfilingGroupInput = struct {
    /// Specifies whether profiling is enabled or disabled for a profiling group.
    agent_orchestration_config: AgentOrchestrationConfig,

    /// The name of the profiling group to update.
    profiling_group_name: []const u8,

    pub const json_field_names = .{
        .agent_orchestration_config = "agentOrchestrationConfig",
        .profiling_group_name = "profilingGroupName",
    };
};

pub const UpdateProfilingGroupOutput = struct {
    /// A [
    /// `ProfilingGroupDescription`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_ProfilingGroupDescription.html)
    /// that contains information about the returned updated profiling group.
    profiling_group: ?ProfilingGroupDescription = null,

    pub const json_field_names = .{
        .profiling_group = "profilingGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProfilingGroupInput, options: CallOptions) !UpdateProfilingGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProfilingGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-profiler", "CodeGuruProfiler", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/profilingGroups/");
    try path_buf.appendSlice(allocator, input.profiling_group_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"agentOrchestrationConfig\":");
    try aws.json.writeValue(@TypeOf(input.agent_orchestration_config), input.agent_orchestration_config, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProfilingGroupOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateProfilingGroupOutput = .{};

    return result;
}
