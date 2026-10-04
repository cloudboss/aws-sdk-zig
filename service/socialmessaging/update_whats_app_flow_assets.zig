const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateWhatsAppFlowAssetsInput = struct {
    /// The unique identifier of the Flow whose assets to update.
    flow_id: []const u8,

    /// The updated Flow JSON definition. Maximum size is 10 MB.
    flow_json: []const u8,

    /// The ID of the WhatsApp Business Account associated with this Flow.
    id: []const u8,

    pub const json_field_names = .{
        .flow_id = "flowId",
        .flow_json = "flowJson",
        .id = "id",
    };
};

pub const UpdateWhatsAppFlowAssetsOutput = struct {
    /// A list of validation errors returned by Meta, if any. Validation errors must
    /// be resolved before the Flow can be published.
    validation_errors: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .validation_errors = "validationErrors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWhatsAppFlowAssetsInput, options: CallOptions) !UpdateWhatsAppFlowAssetsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWhatsAppFlowAssetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("social-messaging", "SocialMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/whatsapp/flow/assets/update";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"flowId\":");
    try aws.json.writeValue(@TypeOf(input.flow_id), input.flow_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"flowJson\":");
    try aws.json.writeValue(@TypeOf(input.flow_json), input.flow_json, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"id\":");
    try aws.json.writeValue(@TypeOf(input.id), input.id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWhatsAppFlowAssetsOutput {
    const result: UpdateWhatsAppFlowAssetsOutput = try aws.json.parseJsonObject(
        UpdateWhatsAppFlowAssetsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
