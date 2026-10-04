const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SendWhatsAppConversionEventInput = struct {
    /// The Meta-generated dataset ID to send the event to.
    dataset_id: []const u8,

    /// The raw Meta Conversions API event payload as a JSON blob. See [Meta's
    /// server event
    /// parameters](https://developers.facebook.com/docs/marketing-api/conversions-api/parameters/server-event) for the supported format.
    event_data: []const u8,

    /// The ID of the WhatsApp Business Account associated with the dataset,
    /// formatted as `waba-01234567890123456789012345678901`.
    id: []const u8,

    pub const json_field_names = .{
        .dataset_id = "datasetId",
        .event_data = "eventData",
        .id = "id",
    };
};

pub const SendWhatsAppConversionEventOutput = struct {
    /// The unique identifier for the conversion event request.
    request_id: []const u8,

    pub const json_field_names = .{
        .request_id = "requestId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendWhatsAppConversionEventInput, options: CallOptions) !SendWhatsAppConversionEventOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SendWhatsAppConversionEventInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("social-messaging", "SocialMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/whatsapp/waba/dataset/events";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"datasetId\":");
    try aws.json.writeValue(@TypeOf(input.dataset_id), input.dataset_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"eventData\":");
    try aws.json.writeValue(@TypeOf(input.event_data), input.event_data, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendWhatsAppConversionEventOutput {
    const result: SendWhatsAppConversionEventOutput = try aws.json.parseJsonObject(
        SendWhatsAppConversionEventOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
