const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthorizationData = @import("authorization_data.zig").AuthorizationData;

pub const GetAuthorizationTokenInput = struct {
    /// A list of Amazon Web Services account IDs that are associated with the
    /// registries for which to get
    /// AuthorizationData objects. If you do not specify a registry, the default
    /// registry is assumed.
    registry_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .registry_ids = "registryIds",
    };
};

pub const GetAuthorizationTokenOutput = struct {
    /// A list of authorization token data objects that correspond to the
    /// `registryIds` values in the request.
    ///
    /// The size of the authorization token returned by Amazon ECR is not fixed. We
    /// recommend
    /// that you don't make assumptions about the maximum size.
    authorization_data: ?[]const AuthorizationData = null,

    pub const json_field_names = .{
        .authorization_data = "authorizationData",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAuthorizationTokenInput, options: CallOptions) !GetAuthorizationTokenOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecr", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAuthorizationTokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.ecr", "ECR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerRegistry_V20150921.GetAuthorizationToken");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAuthorizationTokenOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetAuthorizationTokenOutput, body, allocator);
}
