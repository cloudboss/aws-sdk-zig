const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceServerType = @import("resource_server_type.zig").ResourceServerType;

pub const DescribeResourceServerInput = struct {
    /// A unique resource server identifier for the resource server. The identifier
    /// can be an
    /// API friendly name like `solar-system-data`. You can also set an API URL like
    /// `https://solar-system-data-api.example.com` as your identifier.
    ///
    /// Amazon Cognito represents scopes in the access token in the format
    /// `$resource-server-identifier/$scope`. Longer scope-identifier strings
    /// increase the size of your access tokens.
    identifier: []const u8,

    /// The ID of the user pool that hosts the resource server.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .user_pool_id = "UserPoolId",
    };
};

pub const DescribeResourceServerOutput = struct {
    /// The details of the requested resource server.
    resource_server: ?ResourceServerType = null,

    pub const json_field_names = .{
        .resource_server = "ResourceServer",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeResourceServerInput, options: CallOptions) !DescribeResourceServerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeResourceServerInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.DescribeResourceServer");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeResourceServerOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeResourceServerOutput, body, allocator);
}
