const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetaFlowCategory = @import("meta_flow_category.zig").MetaFlowCategory;

pub const UpdateWhatsAppFlowInput = struct {
    /// The updated categories for the Flow.
    categories: ?[]const MetaFlowCategory = null,

    /// The updated HTTPS endpoint for a data exchange Flow.
    endpoint_uri: ?[]const u8 = null,

    /// The unique identifier of the Flow to update.
    flow_id: []const u8,

    /// The updated name for the Flow.
    flow_name: ?[]const u8 = null,

    /// The ID of the WhatsApp Business Account associated with this Flow.
    id: []const u8,

    /// The ID of the Meta application to attach to the Flow.
    meta_app_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .categories = "categories",
        .endpoint_uri = "endpointUri",
        .flow_id = "flowId",
        .flow_name = "flowName",
        .id = "id",
        .meta_app_id = "metaAppId",
    };
};

pub const UpdateWhatsAppFlowOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWhatsAppFlowInput, options: CallOptions) !UpdateWhatsAppFlowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "social-messaging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWhatsAppFlowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("social-messaging", "SocialMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/whatsapp/flow/update";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.categories) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"categories\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.endpoint_uri) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"endpointUri\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"flowId\":");
    try aws.json.writeValue(@TypeOf(input.flow_id), input.flow_id, allocator, &body_buf);
    has_prev = true;
    if (input.flow_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"flowName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"id\":");
    try aws.json.writeValue(@TypeOf(input.id), input.id, allocator, &body_buf);
    has_prev = true;
    if (input.meta_app_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"metaAppId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWhatsAppFlowOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateWhatsAppFlowOutput = .{};

    return result;
}
