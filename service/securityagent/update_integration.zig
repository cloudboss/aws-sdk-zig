const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WebhookAction = @import("webhook_action.zig").WebhookAction;

pub const UpdateIntegrationInput = struct {
    /// The ID of the integration whose webhook you want to create or rotate.
    integration_id: []const u8,

    /// The action to perform on the integration's webhook.
    webhook_action: WebhookAction,

    pub const json_field_names = .{
        .integration_id = "integrationId",
        .webhook_action = "webhookAction",
    };
};

pub const UpdateIntegrationOutput = struct {
    /// The ID of the integration.
    integration_id: []const u8,

    /// The HMAC signing secret for the webhook. Returned only once, in this
    /// response; it is never returned again.
    secret: ?[]const u8 = null,

    /// The payload URL to configure on your provider instance. Returned when a
    /// webhook is created; unchanged by a rotate.
    webhook_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .integration_id = "integrationId",
        .secret = "secret",
        .webhook_url = "webhookUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateIntegrationInput, options: CallOptions) !UpdateIntegrationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityagent", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateIntegrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/UpdateIntegration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"integrationId\":");
    try aws.json.writeValue(@TypeOf(input.integration_id), input.integration_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"webhookAction\":");
    try aws.json.writeValue(@TypeOf(input.webhook_action), input.webhook_action, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateIntegrationOutput {
    const result: UpdateIntegrationOutput = try aws.json.parseJsonObject(
        UpdateIntegrationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
