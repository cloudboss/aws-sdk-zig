const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AlternateIdentifier = @import("alternate_identifier.zig").AlternateIdentifier;

pub const GetGroupIdInput = struct {
    /// A unique identifier for a user or group that is not the primary identifier.
    /// This value can be an identifier from an external identity provider (IdP)
    /// that is associated with the user, the group, or a unique attribute. For the
    /// unique attribute, the only valid path is ` displayName`.
    alternate_identifier: AlternateIdentifier,

    /// The globally unique identifier for the identity store.
    identity_store_id: []const u8,

    pub const json_field_names = .{
        .alternate_identifier = "AlternateIdentifier",
        .identity_store_id = "IdentityStoreId",
    };
};

pub const GetGroupIdOutput = struct {
    /// The identifier for a group in the identity store.
    group_id: []const u8,

    /// The globally unique identifier for the identity store.
    identity_store_id: []const u8,

    pub const json_field_names = .{
        .group_id = "GroupId",
        .identity_store_id = "IdentityStoreId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGroupIdInput, options: CallOptions) !GetGroupIdOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "identitystore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetGroupIdInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("identitystore", "identitystore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSIdentityStore.GetGroupId");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetGroupIdOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetGroupIdOutput, body, allocator);
}
