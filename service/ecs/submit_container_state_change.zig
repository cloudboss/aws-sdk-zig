const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NetworkBinding = @import("network_binding.zig").NetworkBinding;

pub const SubmitContainerStateChangeInput = struct {
    /// The short name or full ARN of the cluster that hosts the container.
    cluster: ?[]const u8 = null,

    /// The name of the container.
    container_name: ?[]const u8 = null,

    /// The exit code that's returned for the state change request.
    exit_code: ?i32 = null,

    /// The network bindings of the container.
    network_bindings: ?[]const NetworkBinding = null,

    /// The reason for the state change request.
    reason: ?[]const u8 = null,

    /// The ID of the Docker container.
    runtime_id: ?[]const u8 = null,

    /// The status of the state change request.
    status: ?[]const u8 = null,

    /// The task ID or full Amazon Resource Name (ARN) of the task that hosts the
    /// container.
    task: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster = "cluster",
        .container_name = "containerName",
        .exit_code = "exitCode",
        .network_bindings = "networkBindings",
        .reason = "reason",
        .runtime_id = "runtimeId",
        .status = "status",
        .task = "task",
    };
};

pub const SubmitContainerStateChangeOutput = struct {
    /// Acknowledgement of the state change.
    acknowledgment: ?[]const u8 = null,

    pub const json_field_names = .{
        .acknowledgment = "acknowledgment",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SubmitContainerStateChangeInput, options: CallOptions) !SubmitContainerStateChangeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SubmitContainerStateChangeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.SubmitContainerStateChange");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SubmitContainerStateChangeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SubmitContainerStateChangeOutput, body, allocator);
}
