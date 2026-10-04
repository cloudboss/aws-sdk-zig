const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserPoolReplicaType = @import("user_pool_replica_type.zig").UserPoolReplicaType;

pub const DeleteUserPoolReplicaInput = struct {
    /// The Amazon Web Services Region of the replica to delete.
    region_name: []const u8,

    /// The ID of the user pool that contains the replica to delete.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .region_name = "RegionName",
        .user_pool_id = "UserPoolId",
    };
};

pub const DeleteUserPoolReplicaOutput = struct {
    /// Information about the deleted user pool replica.
    user_pool_replica: ?UserPoolReplicaType = null,

    pub const json_field_names = .{
        .user_pool_replica = "UserPoolReplica",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteUserPoolReplicaInput, options: CallOptions) !DeleteUserPoolReplicaOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-idp", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteUserPoolReplicaInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-idp", "Cognito Identity Provider", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.DeleteUserPoolReplica");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteUserPoolReplicaOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteUserPoolReplicaOutput, body, allocator);
}
