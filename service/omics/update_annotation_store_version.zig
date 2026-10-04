const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VersionStatus = @import("version_status.zig").VersionStatus;

pub const UpdateAnnotationStoreVersionInput = struct {
    /// The description of an annotation store.
    description: ?[]const u8 = null,

    /// The name of an annotation store.
    name: []const u8,

    /// The name of an annotation store version.
    version_name: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .version_name = "versionName",
    };
};

pub const UpdateAnnotationStoreVersionOutput = struct {
    /// The time stamp for when an annotation store version was created.
    creation_time: i64,

    /// The description of an annotation store version.
    description: []const u8,

    /// The annotation store version ID.
    id: []const u8,

    /// The name of an annotation store.
    name: []const u8,

    /// The status of an annotation store version.
    status: VersionStatus,

    /// The annotation store ID.
    store_id: []const u8,

    /// The time stamp for when an annotation store version was updated.
    update_time: i64,

    /// The name of an annotation store version.
    version_name: []const u8,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .name = "name",
        .status = "status",
        .store_id = "storeId",
        .update_time = "updateTime",
        .version_name = "versionName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAnnotationStoreVersionInput, options: CallOptions) !UpdateAnnotationStoreVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAnnotationStoreVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/annotationStore/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/version/");
    try path_buf.appendSlice(allocator, input.version_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAnnotationStoreVersionOutput {
    var result: UpdateAnnotationStoreVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateAnnotationStoreVersionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
