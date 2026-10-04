const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReplicationSet = @import("replication_set.zig").ReplicationSet;

pub const GetReplicationSetInput = struct {
    /// The Amazon Resource Name (ARN) of the replication set you want to retrieve.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};

pub const GetReplicationSetOutput = struct {
    /// Details of the replication set.
    replication_set: ?ReplicationSet = null,

    pub const json_field_names = .{
        .replication_set = "replicationSet",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetReplicationSetInput, options: CallOptions) !GetReplicationSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-incidents", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetReplicationSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-incidents", "SSM Incidents", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/getReplicationSet";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "arn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetReplicationSetOutput {
    const result: GetReplicationSetOutput = try aws.json.parseJsonObject(
        GetReplicationSetOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
