const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StreamStatus = @import("stream_status.zig").StreamStatus;

pub const DeleteStreamInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. Idempotency ensures that an API request
    /// completes only once. With an idempotent request, if the original request
    /// completes successfully, the subsequent retries with the same client token
    /// return the result from the original successful request and they have no
    /// additional effect.
    ///
    /// If you don't specify a client token, the Amazon Web Services SDK
    /// automatically generates one.
    client_token: ?[]const u8 = null,

    /// The ID of the cluster containing the stream to delete.
    cluster_identifier: []const u8,

    /// The ID of the stream to delete.
    stream_identifier: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .cluster_identifier = "clusterIdentifier",
        .stream_identifier = "streamIdentifier",
    };
};

pub const DeleteStreamOutput = struct {
    /// The ARN of the deleted stream.
    arn: []const u8,

    /// The ID of the cluster for the deleted stream.
    cluster_identifier: []const u8,

    /// The time when the stream was created.
    creation_time: i64,

    /// The status of the stream.
    status: StreamStatus,

    /// The ID of the deleted stream.
    stream_identifier: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .cluster_identifier = "clusterIdentifier",
        .creation_time = "creationTime",
        .status = "status",
        .stream_identifier = "streamIdentifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteStreamInput, options: CallOptions) !DeleteStreamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dsql", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dsql", "DSQL", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/stream/");
    try path_buf.appendSlice(allocator, input.cluster_identifier);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.stream_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.client_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "client-token=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteStreamOutput {
    const result: DeleteStreamOutput = try aws.json.parseJsonObject(
        DeleteStreamOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
