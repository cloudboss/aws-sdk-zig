const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const Snapshot = @import("snapshot.zig").Snapshot;

pub const CreateSnapshotInput = struct {
    /// The namespace to create a snapshot for.
    namespace_name: []const u8,

    /// How long to retain the created snapshot.
    retention_period: ?i32 = null,

    /// The name of the snapshot.
    snapshot_name: []const u8,

    /// An array of [Tag
    /// objects](https://docs.aws.amazon.com/redshift-serverless/latest/APIReference/API_Tag.html) to associate with the snapshot.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .namespace_name = "namespaceName",
        .retention_period = "retentionPeriod",
        .snapshot_name = "snapshotName",
        .tags = "tags",
    };
};

pub const CreateSnapshotOutput = struct {
    /// The created snapshot object.
    snapshot: ?Snapshot = null,

    pub const json_field_names = .{
        .snapshot = "snapshot",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSnapshotInput, options: CallOptions) !CreateSnapshotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSnapshotInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.CreateSnapshot");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSnapshotOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateSnapshotOutput, body, allocator);
}
