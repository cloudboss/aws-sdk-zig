const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const CreateSnapshotInput = struct {
    /// Textual description of the snapshot that appears in the Amazon EC2 console,
    /// Elastic
    /// Block Store snapshots panel in the **Description** field, and
    /// in the Storage Gateway snapshot **Details** pane,
    /// **Description** field.
    snapshot_description: []const u8,

    /// A list of up to 50 tags that can be assigned to a snapshot. Each tag is a
    /// key-value
    /// pair.
    ///
    /// Valid characters for key and value are letters, spaces, and numbers
    /// representable in
    /// UTF-8 format, and the following special characters: + - = . _ : / @. The
    /// maximum length
    /// of a tag's key is 128 characters, and the maximum length for a tag's value
    /// is
    /// 256.
    tags: ?[]const Tag = null,

    /// The Amazon Resource Name (ARN) of the volume. Use the ListVolumes
    /// operation to return a list of gateway volumes.
    volume_arn: []const u8,

    pub const json_field_names = .{
        .snapshot_description = "SnapshotDescription",
        .tags = "Tags",
        .volume_arn = "VolumeARN",
    };
};

pub const CreateSnapshotOutput = struct {
    /// The snapshot ID that is used to refer to the snapshot in future operations
    /// such as
    /// describing snapshots (Amazon Elastic Compute Cloud API `DescribeSnapshots`)
    /// or
    /// creating a volume from a snapshot (CreateStorediSCSIVolume).
    snapshot_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the volume of which the snapshot was
    /// taken.
    volume_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .snapshot_id = "SnapshotId",
        .volume_arn = "VolumeARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSnapshotInput, options: CallOptions) !CreateSnapshotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "storagegateway", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.CreateSnapshot");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSnapshotOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateSnapshotOutput, body, allocator);
}
