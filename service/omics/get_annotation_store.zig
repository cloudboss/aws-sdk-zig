const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReferenceItem = @import("reference_item.zig").ReferenceItem;
const SseConfig = @import("sse_config.zig").SseConfig;
const StoreStatus = @import("store_status.zig").StoreStatus;
const StoreFormat = @import("store_format.zig").StoreFormat;
const StoreOptions = @import("store_options.zig").StoreOptions;

pub const GetAnnotationStoreInput = struct {
    /// The store's name.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};

pub const GetAnnotationStoreOutput = struct {
    /// When the store was created.
    creation_time: i64,

    /// The store's description.
    description: []const u8,

    /// The store's ID.
    id: []const u8,

    /// The store's name.
    name: []const u8,

    /// An integer indicating how many versions of an annotation store exist.
    num_versions: i32,

    /// The store's genome reference.
    reference: ?ReferenceItem = null,

    /// The store's server-side encryption (SSE) settings.
    sse_config: ?SseConfig = null,

    /// The store's status.
    status: StoreStatus,

    /// A status message.
    status_message: []const u8,

    /// The store's ARN.
    store_arn: []const u8,

    /// The store's annotation file format.
    store_format: ?StoreFormat = null,

    /// The store's parsing options.
    store_options: ?StoreOptions = null,

    /// The store's size in bytes.
    store_size_bytes: i64,

    /// The store's tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// When the store was updated.
    update_time: i64,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .name = "name",
        .num_versions = "numVersions",
        .reference = "reference",
        .sse_config = "sseConfig",
        .status = "status",
        .status_message = "statusMessage",
        .store_arn = "storeArn",
        .store_format = "storeFormat",
        .store_options = "storeOptions",
        .store_size_bytes = "storeSizeBytes",
        .tags = "tags",
        .update_time = "updateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAnnotationStoreInput, options: CallOptions) !GetAnnotationStoreOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAnnotationStoreInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/annotationStore/");
    try path_buf.appendSlice(allocator, input.name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAnnotationStoreOutput {
    const result: GetAnnotationStoreOutput = try aws.json.parseJsonObject(
        GetAnnotationStoreOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
