const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Webhook = @import("webhook.zig").Webhook;

pub const ListWebhooksInput = struct {
    /// The unique identifier of the AgentSpace
    agent_space_id: []const u8,

    /// The unique identifier of the given association.
    association_id: []const u8,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .association_id = "associationId",
    };
};

pub const ListWebhooksOutput = struct {
    /// The list of association webhooks.
    webhooks: ?[]const Webhook = null,

    pub const json_field_names = .{
        .webhooks = "webhooks",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListWebhooksInput, options: CallOptions) !ListWebhooksOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aidevops", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListWebhooksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aidevops", "DevOps Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/agentspaces/");
    try path_buf.appendSlice(allocator, input.agent_space_id);
    try path_buf.appendSlice(allocator, "/associations/");
    try path_buf.appendSlice(allocator, input.association_id);
    try path_buf.appendSlice(allocator, "/webhooks/list");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListWebhooksOutput {
    const result: ListWebhooksOutput = try aws.json.parseJsonObject(
        ListWebhooksOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
