const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetKxConnectionStringInput = struct {
    /// A name of the kdb cluster.
    cluster_name: []const u8,

    /// A unique identifier for the kdb environment.
    environment_id: []const u8,

    /// The Amazon Resource Name (ARN) that identifies the user. For more
    /// information about ARNs and
    /// how to use ARNs in policies, see [IAM
    /// Identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html) in the
    /// *IAM User Guide*.
    user_arn: []const u8,

    pub const json_field_names = .{
        .cluster_name = "clusterName",
        .environment_id = "environmentId",
        .user_arn = "userArn",
    };
};

pub const GetKxConnectionStringOutput = struct {
    /// The signed connection string that you can use to connect to clusters.
    signed_connection_string: ?[]const u8 = null,

    pub const json_field_names = .{
        .signed_connection_string = "signedConnectionString",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetKxConnectionStringInput, options: CallOptions) !GetKxConnectionStringOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "finspace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetKxConnectionStringInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace", "finspace", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/kx/environments/");
    try path_buf.appendSlice(allocator, input.environment_id);
    try path_buf.appendSlice(allocator, "/connectionString");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "clusterName=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.cluster_name);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "userArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.user_arn);
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetKxConnectionStringOutput {
    var result: GetKxConnectionStringOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetKxConnectionStringOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
