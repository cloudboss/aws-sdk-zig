const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const WebhookDefinition = @import("webhook_definition.zig").WebhookDefinition;
const ListWebhookItem = @import("list_webhook_item.zig").ListWebhookItem;

pub const PutWebhookInput = struct {
    /// The tags for the webhook.
    tags: ?[]const Tag = null,

    /// The detail provided in an input file to create the webhook, such as the
    /// webhook
    /// name, the pipeline name, and the action name. Give the webhook a unique name
    /// that helps
    /// you identify it. You might name the webhook after the pipeline and action it
    /// targets so
    /// that you can easily recognize what it's used for later.
    webhook: WebhookDefinition,

    pub const json_field_names = .{
        .tags = "tags",
        .webhook = "webhook",
    };
};

pub const PutWebhookOutput = struct {
    /// The detail returned from creating the webhook, such as the webhook name,
    /// webhook
    /// URL, and webhook ARN.
    webhook: ?ListWebhookItem = null,

    pub const json_field_names = .{
        .webhook = "webhook",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutWebhookInput, options: CallOptions) !PutWebhookOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codepipeline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutWebhookInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codepipeline", "CodePipeline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.PutWebhook");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutWebhookOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutWebhookOutput, body, allocator);
}
