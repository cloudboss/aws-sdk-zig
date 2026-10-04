const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RoleCredentials = @import("role_credentials.zig").RoleCredentials;

pub const GetRoleCredentialsInput = struct {
    /// The token issued by the `CreateToken` API call. For more information, see
    /// [CreateToken](https://docs.aws.amazon.com/singlesignon/latest/OIDCAPIReference/API_CreateToken.html) in the *IAM Identity Center OIDC API Reference Guide*.
    access_token: []const u8,

    /// The identifier for the AWS account that is assigned to the user.
    account_id: []const u8,

    /// The friendly name of the role that is assigned to the user.
    role_name: []const u8,

    pub const json_field_names = .{
        .access_token = "accessToken",
        .account_id = "accountId",
        .role_name = "roleName",
    };
};

pub const GetRoleCredentialsOutput = struct {
    /// The credentials for the role that is assigned to the user.
    role_credentials: ?RoleCredentials = null,

    pub const json_field_names = .{
        .role_credentials = "roleCredentials",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRoleCredentialsInput, options: CallOptions) !GetRoleCredentialsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsssoportal", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRoleCredentialsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("portal.sso", "SSO", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/federation/credentials";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "account_id=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.account_id);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "role_name=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.role_name);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "x-amz-sso_bearer_token", input.access_token);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRoleCredentialsOutput {
    var result: GetRoleCredentialsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetRoleCredentialsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
