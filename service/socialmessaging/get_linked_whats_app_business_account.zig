const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LinkedWhatsAppBusinessAccount = @import("linked_whats_app_business_account.zig").LinkedWhatsAppBusinessAccount;

pub const GetLinkedWhatsAppBusinessAccountInput = struct {
    /// The unique identifier, from Amazon Web Services, of the linked WhatsApp
    /// Business
    /// Account. WABA identifiers are formatted as
    /// `waba-01234567890123456789012345678901`. Use
    /// [ListLinkedWhatsAppBusinessAccounts](https://docs.aws.amazon.com/social-messaging/latest/APIReference/API_ListLinkedWhatsAppBusinessAccounts.html) to list all WABAs and their details.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const GetLinkedWhatsAppBusinessAccountOutput = struct {
    /// The details of the linked WhatsApp Business Account.
    account: ?LinkedWhatsAppBusinessAccount = null,

    pub const json_field_names = .{
        .account = "account",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLinkedWhatsAppBusinessAccountInput, options: CallOptions) !GetLinkedWhatsAppBusinessAccountOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLinkedWhatsAppBusinessAccountInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("social-messaging", "SocialMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/whatsapp/waba/details";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "id=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLinkedWhatsAppBusinessAccountOutput {
    var result: GetLinkedWhatsAppBusinessAccountOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetLinkedWhatsAppBusinessAccountOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
