const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KxDatabaseConfiguration = @import("kx_database_configuration.zig").KxDatabaseConfiguration;
const KxDeploymentConfiguration = @import("kx_deployment_configuration.zig").KxDeploymentConfiguration;

pub const UpdateKxClusterDatabasesInput = struct {
    /// A token that ensures idempotency. This token expires in 10 minutes.
    client_token: ?[]const u8 = null,

    /// A unique name for the cluster that you want to modify.
    cluster_name: []const u8,

    /// The structure of databases mounted on the cluster.
    databases: []const KxDatabaseConfiguration,

    /// The configuration that allows you to choose how you want to update the
    /// databases on a cluster.
    deployment_configuration: ?KxDeploymentConfiguration = null,

    /// The unique identifier of a kdb environment.
    environment_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .cluster_name = "clusterName",
        .databases = "databases",
        .deployment_configuration = "deploymentConfiguration",
        .environment_id = "environmentId",
    };
};

pub const UpdateKxClusterDatabasesOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateKxClusterDatabasesInput, options: CallOptions) !UpdateKxClusterDatabasesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateKxClusterDatabasesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace", "finspace", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/kx/environments/");
    try path_buf.appendSlice(allocator, input.environment_id);
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/configuration/databases");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"databases\":");
    try aws.json.writeValue(@TypeOf(input.databases), input.databases, allocator, &body_buf);
    has_prev = true;
    if (input.deployment_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deploymentConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateKxClusterDatabasesOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateKxClusterDatabasesOutput = .{};

    return result;
}
