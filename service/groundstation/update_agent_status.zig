const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AggregateStatus = @import("aggregate_status.zig").AggregateStatus;
const ComponentStatusData = @import("component_status_data.zig").ComponentStatusData;

pub const UpdateAgentStatusInput = struct {
    /// UUID of agent to update.
    agent_id: []const u8,

    /// Aggregate status for agent.
    aggregate_status: AggregateStatus,

    /// List of component statuses for agent.
    component_statuses: []const ComponentStatusData,

    /// GUID of agent task.
    task_id: []const u8,

    pub const json_field_names = .{
        .agent_id = "agentId",
        .aggregate_status = "aggregateStatus",
        .component_statuses = "componentStatuses",
        .task_id = "taskId",
    };
};

pub const UpdateAgentStatusOutput = struct {
    /// UUID of updated agent.
    agent_id: []const u8,

    pub const json_field_names = .{
        .agent_id = "agentId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAgentStatusInput, options: CallOptions) !UpdateAgentStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "groundstation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAgentStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("groundstation", "GroundStation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/agent/");
    try path_buf.appendSlice(allocator, input.agent_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"aggregateStatus\":");
    try aws.json.writeValue(@TypeOf(input.aggregate_status), input.aggregate_status, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"componentStatuses\":");
    try aws.json.writeValue(@TypeOf(input.component_statuses), input.component_statuses, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"taskId\":");
    try aws.json.writeValue(@TypeOf(input.task_id), input.task_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAgentStatusOutput {
    const result: UpdateAgentStatusOutput = try aws.json.parseJsonObject(
        UpdateAgentStatusOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
