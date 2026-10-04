const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const LookupDeveloperIdentityInput = struct {
    /// A unique ID used by your backend authentication process to identify a user.
    /// Typically, a developer identity provider would issue many developer user
    /// identifiers, in
    /// keeping with the number of users.
    developer_user_identifier: ?[]const u8 = null,

    /// A unique identifier in the format REGION:GUID.
    identity_id: ?[]const u8 = null,

    /// An identity pool ID in the format REGION:GUID.
    identity_pool_id: []const u8,

    /// The maximum number of identities to return.
    max_results: ?i32 = null,

    /// A pagination token. The first call you make will have `NextToken` set to
    /// null. After that the service will return `NextToken` values as needed. For
    /// example, let's say you make a request with `MaxResults` set to 10, and there
    /// are
    /// 20 matches in the database. The service will return a pagination token as a
    /// part of the
    /// response. This token can be used to call the API again and get results
    /// starting from the
    /// 11th match.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .developer_user_identifier = "DeveloperUserIdentifier",
        .identity_id = "IdentityId",
        .identity_pool_id = "IdentityPoolId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const LookupDeveloperIdentityOutput = struct {
    /// This is the list of developer user identifiers associated with an identity
    /// ID.
    /// Cognito supports the association of multiple developer user identifiers with
    /// an identity
    /// ID.
    developer_user_identifier_list: ?[]const []const u8 = null,

    /// A unique identifier in the format REGION:GUID.
    identity_id: ?[]const u8 = null,

    /// A pagination token. The first call you make will have `NextToken` set to
    /// null. After that the service will return `NextToken` values as needed. For
    /// example, let's say you make a request with `MaxResults` set to 10, and there
    /// are
    /// 20 matches in the database. The service will return a pagination token as a
    /// part of the
    /// response. This token can be used to call the API again and get results
    /// starting from the
    /// 11th match.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .developer_user_identifier_list = "DeveloperUserIdentifierList",
        .identity_id = "IdentityId",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: LookupDeveloperIdentityInput, options: CallOptions) !LookupDeveloperIdentityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: LookupDeveloperIdentityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityService.LookupDeveloperIdentity");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !LookupDeveloperIdentityOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(LookupDeveloperIdentityOutput, body, allocator);
}
