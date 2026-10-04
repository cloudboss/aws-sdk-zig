const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RoleMapping = @import("role_mapping.zig").RoleMapping;

pub const GetIdentityPoolRolesInput = struct {
    /// An identity pool ID in the format REGION:GUID.
    identity_pool_id: []const u8,

    pub const json_field_names = .{
        .identity_pool_id = "IdentityPoolId",
    };
};

pub const GetIdentityPoolRolesOutput = struct {
    /// An identity pool ID in the format REGION:GUID.
    identity_pool_id: ?[]const u8 = null,

    /// How users for a specific identity provider are to mapped to roles. This is a
    /// String-to-RoleMapping object map. The string identifies the identity
    /// provider, for example, `graph.facebook.com` or
    /// `cognito-idp.us-east-1.amazonaws.com/us-east-1_abcdefghi:app_client_id`.
    role_mappings: ?[]const aws.map.MapEntry(RoleMapping) = null,

    /// The map of roles associated with this pool. Currently only authenticated and
    /// unauthenticated roles are supported.
    roles: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .identity_pool_id = "IdentityPoolId",
        .role_mappings = "RoleMappings",
        .roles = "Roles",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIdentityPoolRolesInput, options: CallOptions) !GetIdentityPoolRolesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetIdentityPoolRolesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityService.GetIdentityPoolRoles");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIdentityPoolRolesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetIdentityPoolRolesOutput, body, allocator);
}
