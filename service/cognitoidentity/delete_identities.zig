const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UnprocessedIdentityId = @import("unprocessed_identity_id.zig").UnprocessedIdentityId;

pub const DeleteIdentitiesInput = struct {
    /// A list of 1-60 identities that you want to delete.
    identity_ids_to_delete: []const []const u8,

    pub const json_field_names = .{
        .identity_ids_to_delete = "IdentityIdsToDelete",
    };
};

pub const DeleteIdentitiesOutput = struct {
    /// An array of UnprocessedIdentityId objects, each of which contains an
    /// ErrorCode and
    /// IdentityId.
    unprocessed_identity_ids: ?[]const UnprocessedIdentityId = null,

    pub const json_field_names = .{
        .unprocessed_identity_ids = "UnprocessedIdentityIds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteIdentitiesInput, options: CallOptions) !DeleteIdentitiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-identity", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteIdentitiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-identity", "Cognito Identity", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityService.DeleteIdentities");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteIdentitiesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteIdentitiesOutput, body, allocator);
}
