const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapacityProviderSessionStatus = @import("capacity_provider_session_status.zig").CapacityProviderSessionStatus;

pub const DeleteCapacityProviderSessionInput = struct {
    /// The unique identifier of the capacity provider associated with the session.
    capacity_provider_id: []const u8,

    /// The unique identifier of the capacity provider session to delete.
    session_id: []const u8,

    pub const json_field_names = .{
        .capacity_provider_id = "capacityProviderId",
        .session_id = "sessionId",
    };
};

pub const DeleteCapacityProviderSessionOutput = struct {
    /// The Amazon Resource Name (ARN) of the capacity provider associated with the
    /// deleted session.
    capacity_provider_arn: []const u8,

    /// The unique identifier of the deleted capacity provider session.
    session_id: []const u8,

    /// The current status of the capacity provider session. When the status is
    /// `Deleting`, the session is being deleted and is not available. When the
    /// status is `Deleted`, the session is no longer available.
    status: CapacityProviderSessionStatus,

    pub const json_field_names = .{
        .capacity_provider_arn = "capacityProviderArn",
        .session_id = "sessionId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteCapacityProviderSessionInput, options: CallOptions) !DeleteCapacityProviderSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteCapacityProviderSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/capacity-providers/");
    try path_buf.appendSlice(allocator, input.capacity_provider_id);
    try path_buf.appendSlice(allocator, "/sessions/");
    try path_buf.appendSlice(allocator, input.session_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteCapacityProviderSessionOutput {
    const result: DeleteCapacityProviderSessionOutput = try aws.json.parseJsonObject(
        DeleteCapacityProviderSessionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
