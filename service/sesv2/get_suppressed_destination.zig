const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SuppressedDestination = @import("suppressed_destination.zig").SuppressedDestination;

pub const GetSuppressedDestinationInput = struct {
    /// The email address that's on the account suppression list.
    email_address: []const u8,

    pub const json_field_names = .{
        .email_address = "EmailAddress",
    };
};

pub const GetSuppressedDestinationOutput = struct {
    /// An object containing information about the suppressed email address.
    suppressed_destination: ?SuppressedDestination = null,

    pub const json_field_names = .{
        .suppressed_destination = "SuppressedDestination",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSuppressedDestinationInput, options: CallOptions) !GetSuppressedDestinationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSuppressedDestinationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/email/suppression/addresses/");
    try path_buf.appendSlice(allocator, input.email_address);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSuppressedDestinationOutput {
    var result: GetSuppressedDestinationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSuppressedDestinationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
