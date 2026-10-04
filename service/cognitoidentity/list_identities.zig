const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdentityDescription = @import("identity_description.zig").IdentityDescription;

pub const ListIdentitiesInput = struct {
    /// An optional boolean parameter that allows you to hide disabled identities.
    /// If
    /// omitted, the ListIdentities API will include disabled identities in the
    /// response.
    hide_disabled: ?bool = null,

    /// An identity pool ID in the format REGION:GUID.
    identity_pool_id: []const u8,

    /// The maximum number of identities to return.
    max_results: i32,

    /// A pagination token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .hide_disabled = "HideDisabled",
        .identity_pool_id = "IdentityPoolId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListIdentitiesOutput = struct {
    /// An object containing a set of identities and associated mappings.
    identities: ?[]const IdentityDescription = null,

    /// An identity pool ID in the format REGION:GUID.
    identity_pool_id: ?[]const u8 = null,

    /// A pagination token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .identities = "Identities",
        .identity_pool_id = "IdentityPoolId",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListIdentitiesInput, options: CallOptions) !ListIdentitiesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListIdentitiesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityService.ListIdentities");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListIdentitiesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListIdentitiesOutput, body, allocator);
}
