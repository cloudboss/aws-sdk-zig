const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SendUsersMessageRequest = @import("send_users_message_request.zig").SendUsersMessageRequest;
const SendUsersMessageResponse = @import("send_users_message_response.zig").SendUsersMessageResponse;

pub const SendUsersMessagesInput = struct {
    /// The unique identifier for the application. This identifier is displayed as
    /// the **Project ID** on the Amazon Pinpoint console.
    application_id: []const u8,

    send_users_message_request: SendUsersMessageRequest,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .send_users_message_request = "SendUsersMessageRequest",
    };
};

pub const SendUsersMessagesOutput = struct {
    send_users_message_response: ?SendUsersMessageResponse = null,

    pub const json_field_names = .{
        .send_users_message_response = "SendUsersMessageResponse",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendUsersMessagesInput, options: CallOptions) !SendUsersMessagesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mobiletargeting", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SendUsersMessagesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pinpoint", "Pinpoint", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/apps/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/users-messages");
    const path = try path_buf.toOwnedSlice(allocator);

    const body = try aws.json.jsonStringify(input.send_users_message_request, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendUsersMessagesOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: SendUsersMessagesOutput = .{};

    return result;
}
