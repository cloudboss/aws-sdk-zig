const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccountPreferences = @import("account_preferences.zig").AccountPreferences;

pub const GetAccountPreferencesInput = struct {
};

pub const GetAccountPreferencesOutput = struct {
    /// The preferences related to AWS Chatbot usage in the calling AWS account.
    account_preferences: ?AccountPreferences = null,

    pub const json_field_names = .{
        .account_preferences = "AccountPreferences",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAccountPreferencesInput, options: CallOptions) !GetAccountPreferencesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chatbot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAccountPreferencesInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("chatbot", "chatbot", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/get-account-preferences";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAccountPreferencesOutput {
    var result: GetAccountPreferencesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAccountPreferencesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
