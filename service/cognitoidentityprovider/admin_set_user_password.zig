const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AdminSetUserPasswordInput = struct {
    /// The new temporary or permanent password that you want to set for the user.
    /// You
    /// can't remove the password for a user who already has a password so that they
    /// can
    /// only sign in with passwordless methods. In this scenario, you must create a
    /// new user
    /// without a password.
    password: []const u8,

    /// Set to `true` to set a password that the user can immediately sign in with.
    /// Set to `false` to set a temporary password that the user must change on
    /// their
    /// next sign-in.
    permanent: ?bool = null,

    /// The name of the user that you want to query or modify. The value of this
    /// parameter
    /// is typically your user's username, but it can be any of their alias
    /// attributes. If
    /// `username` isn't an alias attribute in your user pool, this value
    /// must be the `sub` of a local user or the username of a user from a
    /// third-party IdP.
    username: []const u8,

    /// The ID of the user pool where you want to set the user's password.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .password = "Password",
        .permanent = "Permanent",
        .username = "Username",
        .user_pool_id = "UserPoolId",
    };
};

pub const AdminSetUserPasswordOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AdminSetUserPasswordInput, options: CallOptions) !AdminSetUserPasswordOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AdminSetUserPasswordInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.AdminSetUserPassword");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AdminSetUserPasswordOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
