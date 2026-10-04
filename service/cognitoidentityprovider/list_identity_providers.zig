const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProviderDescription = @import("provider_description.zig").ProviderDescription;

pub const ListIdentityProvidersInput = struct {
    /// The maximum number of IdPs that you want Amazon Cognito to return in the
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

    /// The ID of the user pool where you want to list IdPs.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .user_pool_id = "UserPoolId",
    };
};

pub const ListIdentityProvidersOutput = struct {
    /// The identifier that Amazon Cognito returned with the previous request to
    /// this operation. When
    /// you include a pagination token in your request, Amazon Cognito returns the
    /// next set of items in
    /// the list. By use of this token, you can paginate through the full list of
    /// items.
    next_token: ?[]const u8 = null,

    /// An array of the IdPs in your user pool. For each, the response includes
    /// identifiers,
    /// the IdP name and type, and trust-relationship details like the issuer URL.
    providers: ?[]const ProviderDescription = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .providers = "Providers",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListIdentityProvidersInput, options: CallOptions) !ListIdentityProvidersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListIdentityProvidersInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.ListIdentityProviders");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListIdentityProvidersOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListIdentityProvidersOutput, body, allocator);
}
