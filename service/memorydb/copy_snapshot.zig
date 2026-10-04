const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const Snapshot = @import("snapshot.zig").Snapshot;

pub const CopySnapshotInput = struct {
    /// The ID of the KMS key used to encrypt the target snapshot.
    kms_key_id: ?[]const u8 = null,

    /// The name of an existing snapshot from which to make a copy.
    source_snapshot_name: []const u8,

    /// A list of tags to be added to this resource. A tag is a key-value pair. A
    /// tag key must be accompanied by a tag value, although null is accepted.
    tags: ?[]const Tag = null,

    /// The Amazon S3 bucket to which the snapshot is exported. This parameter is
    /// used only when exporting a snapshot for external access.
    ///
    /// When using this parameter to export a snapshot, be sure MemoryDB has the
    /// needed permissions to this S3 bucket. For more information, see
    ///
    /// [Step 2: Grant MemoryDB Access to Your Amazon S3
    /// Bucket](https://docs.aws.amazon.com/MemoryDB/latest/devguide/snapshots-exporting.html).
    target_bucket: ?[]const u8 = null,

    /// A name for the snapshot copy. MemoryDB does not permit overwriting a
    /// snapshot, therefore this name must be unique within its context - MemoryDB
    /// or an Amazon S3 bucket if exporting.
    target_snapshot_name: []const u8,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .source_snapshot_name = "SourceSnapshotName",
        .tags = "Tags",
        .target_bucket = "TargetBucket",
        .target_snapshot_name = "TargetSnapshotName",
    };
};

pub const CopySnapshotOutput = struct {
    /// Represents a copy of an entire cluster as of the time when the snapshot was
    /// taken.
    snapshot: ?Snapshot = null,

    pub const json_field_names = .{
        .snapshot = "Snapshot",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CopySnapshotInput, options: CallOptions) !CopySnapshotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "memorydb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CopySnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("memory-db", "MemoryDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMemoryDB.CopySnapshot");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CopySnapshotOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CopySnapshotOutput, body, allocator);
}
