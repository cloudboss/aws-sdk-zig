const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WhatsAppBusinessAccountEventDestination = @import("whats_app_business_account_event_destination.zig").WhatsAppBusinessAccountEventDestination;

pub const PutWhatsAppBusinessAccountEventDestinationsInput = struct {
    /// An array of `WhatsAppBusinessAccountEventDestination` event destinations.
    event_destinations: []const WhatsAppBusinessAccountEventDestination,

    /// The unique identifier of your WhatsApp Business Account. WABA identifiers
    /// are formatted as
    /// `waba-01234567890123456789012345678901`. Use
    /// [ListLinkedWhatsAppBusinessAccounts](https://docs.aws.amazon.com/social-messaging/latest/APIReference/API_ListLinkedWhatsAppBusinessAccounts.html) to list all WABAs and their details.
    id: []const u8,

    pub const json_field_names = .{
        .event_destinations = "eventDestinations",
        .id = "id",
    };
};

pub const PutWhatsAppBusinessAccountEventDestinationsOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutWhatsAppBusinessAccountEventDestinationsInput, options: CallOptions) !PutWhatsAppBusinessAccountEventDestinationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutWhatsAppBusinessAccountEventDestinationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("social-messaging", "SocialMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/whatsapp/waba/eventdestinations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"eventDestinations\":");
    try aws.json.writeValue(@TypeOf(input.event_destinations), input.event_destinations, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"id\":");
    try aws.json.writeValue(@TypeOf(input.id), input.id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutWhatsAppBusinessAccountEventDestinationsOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutWhatsAppBusinessAccountEventDestinationsOutput = .{};

    return result;
}
