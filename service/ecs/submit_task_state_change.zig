const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttachmentStateChange = @import("attachment_state_change.zig").AttachmentStateChange;
const ContainerStateChange = @import("container_state_change.zig").ContainerStateChange;
const ManagedAgentStateChange = @import("managed_agent_state_change.zig").ManagedAgentStateChange;

pub const SubmitTaskStateChangeInput = struct {
    /// Any attachments associated with the state change request.
    attachments: ?[]const AttachmentStateChange = null,

    /// The short name or full Amazon Resource Name (ARN) of the cluster that hosts
    /// the task.
    cluster: ?[]const u8 = null,

    /// Any containers that's associated with the state change request.
    containers: ?[]const ContainerStateChange = null,

    /// The Unix timestamp for the time when the task execution stopped.
    execution_stopped_at: ?i64 = null,

    /// The details for the managed agent that's associated with the task.
    managed_agents: ?[]const ManagedAgentStateChange = null,

    /// The Unix timestamp for the time when the container image pull started.
    pull_started_at: ?i64 = null,

    /// The Unix timestamp for the time when the container image pull completed.
    pull_stopped_at: ?i64 = null,

    /// The reason for the state change request.
    reason: ?[]const u8 = null,

    /// The status of the state change request.
    status: ?[]const u8 = null,

    /// The task ID or full ARN of the task in the state change request.
    task: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachments = "attachments",
        .cluster = "cluster",
        .containers = "containers",
        .execution_stopped_at = "executionStoppedAt",
        .managed_agents = "managedAgents",
        .pull_started_at = "pullStartedAt",
        .pull_stopped_at = "pullStoppedAt",
        .reason = "reason",
        .status = "status",
        .task = "task",
    };
};

pub const SubmitTaskStateChangeOutput = struct {
    /// Acknowledgement of the state change.
    acknowledgment: ?[]const u8 = null,

    pub const json_field_names = .{
        .acknowledgment = "acknowledgment",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SubmitTaskStateChangeInput, options: CallOptions) !SubmitTaskStateChangeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SubmitTaskStateChangeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ecs", "ECS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.SubmitTaskStateChange");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SubmitTaskStateChangeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SubmitTaskStateChangeOutput, body, allocator);
}
