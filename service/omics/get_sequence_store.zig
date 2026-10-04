const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ETagAlgorithmFamily = @import("e_tag_algorithm_family.zig").ETagAlgorithmFamily;
const SequenceStoreS3Access = @import("sequence_store_s3_access.zig").SequenceStoreS3Access;
const SseConfig = @import("sse_config.zig").SseConfig;
const SequenceStoreStatus = @import("sequence_store_status.zig").SequenceStoreStatus;

pub const GetSequenceStoreInput = struct {
    /// The store's ID.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const GetSequenceStoreOutput = struct {
    /// The store's ARN.
    arn: []const u8,

    /// When the store was created.
    creation_time: i64,

    /// The store's description.
    description: ?[]const u8 = null,

    /// The algorithm family of the ETag.
    e_tag_algorithm_family: ?ETagAlgorithmFamily = null,

    /// An S3 location that is used to store files that have failed a direct upload.
    fallback_location: ?[]const u8 = null,

    /// The store's ID.
    id: []const u8,

    /// The store's name.
    name: ?[]const u8 = null,

    /// The tags keys to propagate to the S3 objects associated with read sets in
    /// the sequence store.
    propagated_set_level_tags: ?[]const []const u8 = null,

    /// The S3 metadata of a sequence store, including the ARN and S3 URI of the S3
    /// bucket.
    s_3_access: ?SequenceStoreS3Access = null,

    /// The store's server-side encryption (SSE) settings.
    sse_config: ?SseConfig = null,

    /// The status of the sequence store.
    status: ?SequenceStoreStatus = null,

    /// The status message of the sequence store.
    status_message: ?[]const u8 = null,

    /// The last-updated time of the sequence store.
    update_time: ?i64 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .e_tag_algorithm_family = "eTagAlgorithmFamily",
        .fallback_location = "fallbackLocation",
        .id = "id",
        .name = "name",
        .propagated_set_level_tags = "propagatedSetLevelTags",
        .s_3_access = "s3Access",
        .sse_config = "sseConfig",
        .status = "status",
        .status_message = "statusMessage",
        .update_time = "updateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSequenceStoreInput, options: CallOptions) !GetSequenceStoreOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "omics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSequenceStoreInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sequencestore/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSequenceStoreOutput {
    const result: GetSequenceStoreOutput = try aws.json.parseJsonObject(
        GetSequenceStoreOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
