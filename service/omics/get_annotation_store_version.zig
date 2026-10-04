const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VersionStatus = @import("version_status.zig").VersionStatus;
const VersionOptions = @import("version_options.zig").VersionOptions;

pub const GetAnnotationStoreVersionInput = struct {
    /// The name given to an annotation store version to distinguish it from others.
    name: []const u8,

    /// The name given to an annotation store version to distinguish it from others.
    version_name: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .version_name = "versionName",
    };
};

pub const GetAnnotationStoreVersionOutput = struct {
    /// The time stamp for when an annotation store version was created.
    creation_time: i64,

    /// The description for an annotation store version.
    description: []const u8,

    /// The annotation store version ID.
    id: []const u8,

    /// The name of the annotation store.
    name: []const u8,

    /// The status of an annotation store version.
    status: VersionStatus,

    /// The status of an annotation store version.
    status_message: []const u8,

    /// The store ID for annotation store version.
    store_id: []const u8,

    /// Any tags associated with an annotation store version.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The time stamp for when an annotation store version was updated.
    update_time: i64,

    /// The Arn for the annotation store.
    version_arn: []const u8,

    /// The name given to an annotation store version to distinguish it from others.
    version_name: []const u8,

    /// The options for an annotation store version.
    version_options: ?VersionOptions = null,

    /// The size of the annotation store version in Bytes.
    version_size_bytes: i64,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .name = "name",
        .status = "status",
        .status_message = "statusMessage",
        .store_id = "storeId",
        .tags = "tags",
        .update_time = "updateTime",
        .version_arn = "versionArn",
        .version_name = "versionName",
        .version_options = "versionOptions",
        .version_size_bytes = "versionSizeBytes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAnnotationStoreVersionInput, options: CallOptions) !GetAnnotationStoreVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAnnotationStoreVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/annotationStore/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/version/");
    try path_buf.appendSlice(allocator, input.version_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAnnotationStoreVersionOutput {
    var result: GetAnnotationStoreVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAnnotationStoreVersionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
