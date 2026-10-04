const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Snapshot = @import("snapshot.zig").Snapshot;

pub const GetSnapshotInput = struct {
    /// The owner Amazon Web Services account of a snapshot shared with another
    /// user.
    owner_account: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the snapshot to return.
    snapshot_arn: ?[]const u8 = null,

    /// The name of the snapshot to return.
    snapshot_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .owner_account = "ownerAccount",
        .snapshot_arn = "snapshotArn",
        .snapshot_name = "snapshotName",
    };
};

pub const GetSnapshotOutput = struct {
    /// The returned snapshot object.
    snapshot: ?Snapshot = null,

    pub const json_field_names = .{
        .snapshot = "snapshot",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSnapshotInput, options: CallOptions) !GetSnapshotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift-serverless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift-serverless", "Redshift Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.GetSnapshot");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSnapshotOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetSnapshotOutput, body, allocator);
}
