const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Credentials = @import("credentials.zig").Credentials;

pub const GetClusterSessionCredentialsInput = struct {
    /// The unique identifier of the cluster.
    cluster_id: []const u8,

    /// The Amazon Resource Name (ARN) of the runtime role for interactive workload
    /// submission
    /// on the cluster. The runtime role can be a cross-account IAM role. The
    /// runtime role ARN is a combination of account ID, role name, and role type
    /// using the
    /// following format: `arn:partition:service:region:account:resource`.
    execution_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_id = "ClusterId",
        .execution_role_arn = "ExecutionRoleArn",
    };
};

pub const GetClusterSessionCredentialsOutput = struct {
    /// The credentials that you can use to connect to cluster endpoints that
    /// support username
    /// and password authentication.
    credentials: ?Credentials = null,

    /// The time when the credentials that are returned by the
    /// `GetClusterSessionCredentials` API expire.
    expires_at: ?i64 = null,

    pub const json_field_names = .{
        .credentials = "Credentials",
        .expires_at = "ExpiresAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetClusterSessionCredentialsInput, options: CallOptions) !GetClusterSessionCredentialsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetClusterSessionCredentialsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.GetClusterSessionCredentials");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetClusterSessionCredentialsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetClusterSessionCredentialsOutput, body, allocator);
}
