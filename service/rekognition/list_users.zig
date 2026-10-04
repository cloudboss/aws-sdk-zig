const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const User = @import("user.zig").User;

pub const ListUsersInput = struct {
    /// The ID of an existing collection.
    collection_id: []const u8,

    /// Maximum number of UsersID to return.
    max_results: ?i32 = null,

    /// Pagingation token to receive the next set of UsersID.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .collection_id = "CollectionId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListUsersOutput = struct {
    /// A pagination token to be used with the subsequent request if the response is
    /// truncated.
    next_token: ?[]const u8 = null,

    /// List of UsersID associated with the specified collection.
    users: ?[]const User = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .users = "Users",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListUsersInput, options: CallOptions) !ListUsersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListUsersInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.ListUsers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListUsersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListUsersOutput, body, allocator);
}
