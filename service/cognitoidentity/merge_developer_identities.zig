const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const MergeDeveloperIdentitiesInput = struct {
    /// User identifier for the destination user. The value should be a
    /// `DeveloperUserIdentifier`.
    destination_user_identifier: []const u8,

    /// The "domain" by which Cognito will refer to your users. This is a (pseudo)
    /// domain
    /// name that you provide while creating an identity pool. This name acts as a
    /// placeholder that
    /// allows your backend and the Cognito service to communicate about the
    /// developer provider.
    /// For the `DeveloperProviderName`, you can use letters as well as period (.),
    /// underscore (_), and dash (-).
    developer_provider_name: []const u8,

    /// An identity pool ID in the format REGION:GUID.
    identity_pool_id: []const u8,

    /// User identifier for the source user. The value should be a
    /// `DeveloperUserIdentifier`.
    source_user_identifier: []const u8,

    pub const json_field_names = .{
        .destination_user_identifier = "DestinationUserIdentifier",
        .developer_provider_name = "DeveloperProviderName",
        .identity_pool_id = "IdentityPoolId",
        .source_user_identifier = "SourceUserIdentifier",
    };
};

pub const MergeDeveloperIdentitiesOutput = struct {
    /// A unique identifier in the format REGION:GUID.
    identity_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .identity_id = "IdentityId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: MergeDeveloperIdentitiesInput, options: CallOptions) !MergeDeveloperIdentitiesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: MergeDeveloperIdentitiesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityService.MergeDeveloperIdentities");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !MergeDeveloperIdentitiesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(MergeDeveloperIdentitiesOutput, body, allocator);
}
