const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteUserInput = struct {
    /// Idempotent token used to identify the request to `DeleteUser`. If you use
    /// the
    /// same token with multiple `DeleteUser `requests, the same response is
    /// returned. Use
    /// ClientRequestToken to prevent the same request from being processed more
    /// than once.
    client_request_token: ?[]const u8 = null,

    /// The ID of an existing collection from which the UserID needs to be deleted.
    collection_id: []const u8,

    /// ID for the UserID to be deleted.
    user_id: []const u8,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .collection_id = "CollectionId",
        .user_id = "UserId",
    };
};

pub const DeleteUserOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteUserInput, options: CallOptions) !DeleteUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rekognition", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rekognition", "Rekognition", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.DeleteUser");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteUserOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
