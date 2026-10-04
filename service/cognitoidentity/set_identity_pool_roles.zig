const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RoleMapping = @import("role_mapping.zig").RoleMapping;

pub const SetIdentityPoolRolesInput = struct {
    /// An identity pool ID in the format REGION:GUID.
    identity_pool_id: []const u8,

    /// How users for a specific identity provider are to mapped to roles. This is a
    /// string
    /// to RoleMapping object map. The string identifies the identity provider,
    /// for example, `graph.facebook.com` or
    /// `cognito-idp.us-east-1.amazonaws.com/us-east-1_abcdefghi:app_client_id`.
    ///
    /// Up to 25 rules can be specified per identity provider.
    role_mappings: ?[]const aws.map.MapEntry(RoleMapping) = null,

    /// The map of roles associated with this pool. For a given role, the key will
    /// be either
    /// "authenticated" or "unauthenticated" and the value will be the Role ARN.
    roles: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .identity_pool_id = "IdentityPoolId",
        .role_mappings = "RoleMappings",
        .roles = "Roles",
    };
};

pub const SetIdentityPoolRolesOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetIdentityPoolRolesInput, options: CallOptions) !SetIdentityPoolRolesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SetIdentityPoolRolesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityService.SetIdentityPoolRoles");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetIdentityPoolRolesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
