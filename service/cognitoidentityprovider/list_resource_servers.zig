const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceServerType = @import("resource_server_type.zig").ResourceServerType;

pub const ListResourceServersInput = struct {
    /// The maximum number of resource servers that you want Amazon Cognito to
    /// return in the
    /// response.
    max_results: ?i32 = null,

    /// This API operation returns a limited number of results. The pagination token
    /// is
    /// an identifier that you can present in an additional API request with the
    /// same parameters. When
    /// you include the pagination token, Amazon Cognito returns the next set of
    /// items after the current list.
    /// Subsequent requests return a new pagination token. By use of this token, you
    /// can paginate
    /// through the full list of items.
    next_token: ?[]const u8 = null,

    /// The ID of the user pool where you want to list resource servers.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .user_pool_id = "UserPoolId",
    };
};

pub const ListResourceServersOutput = struct {
    /// The identifier that Amazon Cognito returned with the previous request to
    /// this operation. When
    /// you include a pagination token in your request, Amazon Cognito returns the
    /// next set of items in
    /// the list. By use of this token, you can paginate through the full list of
    /// items.
    next_token: ?[]const u8 = null,

    /// An array of resource servers and the details of their configuration. For
    /// each, the
    /// response includes names, identifiers, and custom scopes.
    resource_servers: ?[]const ResourceServerType = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_servers = "ResourceServers",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResourceServersInput, options: CallOptions) !ListResourceServersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListResourceServersInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.ListResourceServers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResourceServersOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListResourceServersOutput, body, allocator);
}
