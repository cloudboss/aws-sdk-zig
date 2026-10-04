const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Credentials = @import("credentials.zig").Credentials;

pub const GetSessionEndpointInput = struct {
    /// The ID of the cluster that the session belongs to.
    cluster_id: []const u8,

    /// The ID of the session.
    session_id: []const u8,

    pub const json_field_names = .{
        .cluster_id = "ClusterId",
        .session_id = "SessionId",
    };
};

pub const GetSessionEndpointOutput = struct {
    /// A time-limited authentication token used to connect to the Spark Connect
    /// endpoint.
    auth_token: ?[]const u8 = null,

    /// The time at which the authentication token expires. After this time, call
    /// `GetSessionEndpoint` again to obtain a new token.
    auth_token_expiration_time: ?i64 = null,

    /// Username and password used to authenticate with the Spark Connect server
    /// when connecting directly over VPC peering.
    credentials: ?Credentials = null,

    /// The Spark Connect endpoint URL to use in the PySpark client.
    endpoint: []const u8,

    pub const json_field_names = .{
        .auth_token = "AuthToken",
        .auth_token_expiration_time = "AuthTokenExpirationTime",
        .credentials = "Credentials",
        .endpoint = "Endpoint",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSessionEndpointInput, options: CallOptions) !GetSessionEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticmapreduce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSessionEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticmapreduce", "EMR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.GetSessionEndpoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSessionEndpointOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetSessionEndpointOutput, body, allocator);
}
