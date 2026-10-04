const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReplicatorState = @import("replicator_state.zig").ReplicatorState;

pub const DeleteReplicatorInput = struct {
    /// The current version of the replicator.
    current_version: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the replicator to be deleted.
    replicator_arn: []const u8,

    pub const json_field_names = .{
        .current_version = "CurrentVersion",
        .replicator_arn = "ReplicatorArn",
    };
};

pub const DeleteReplicatorOutput = struct {
    /// The Amazon Resource Name (ARN) of the replicator.
    replicator_arn: ?[]const u8 = null,

    /// The state of the replicator.
    replicator_state: ?ReplicatorState = null,

    pub const json_field_names = .{
        .replicator_arn = "ReplicatorArn",
        .replicator_state = "ReplicatorState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteReplicatorInput, options: CallOptions) !DeleteReplicatorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kafka", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteReplicatorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/replication/v1/replicators/");
    try path_buf.appendSlice(allocator, input.replicator_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.current_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "currentVersion=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteReplicatorOutput {
    const result: DeleteReplicatorOutput = try aws.json.parseJsonObject(
        DeleteReplicatorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
