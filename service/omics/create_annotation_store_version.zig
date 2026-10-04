const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VersionOptions = @import("version_options.zig").VersionOptions;
const VersionStatus = @import("version_status.zig").VersionStatus;

pub const CreateAnnotationStoreVersionInput = struct {
    /// The description of an annotation store version.
    description: ?[]const u8 = null,

    /// The name of an annotation store version from which versions are being
    /// created.
    name: []const u8,

    /// Any tags added to annotation store version.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The name given to an annotation store version to distinguish it from other
    /// versions.
    version_name: []const u8,

    /// The options for an annotation store version.
    version_options: ?VersionOptions = null,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .tags = "tags",
        .version_name = "versionName",
        .version_options = "versionOptions",
    };
};

pub const CreateAnnotationStoreVersionOutput = struct {
    /// The time stamp for the creation of an annotation store version.
    creation_time: i64,

    /// A generated ID for the annotation store
    id: []const u8,

    /// The name given to an annotation store version to distinguish it from other
    /// versions.
    name: []const u8,

    /// The status of a annotation store version.
    status: VersionStatus,

    /// The ID for the annotation store from which new versions are being created.
    store_id: []const u8,

    /// The name given to an annotation store version to distinguish it from other
    /// versions.
    version_name: []const u8,

    /// The options for an annotation store version.
    version_options: ?VersionOptions = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .id = "id",
        .name = "name",
        .status = "status",
        .store_id = "storeId",
        .version_name = "versionName",
        .version_options = "versionOptions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAnnotationStoreVersionInput, options: CallOptions) !CreateAnnotationStoreVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAnnotationStoreVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/annotationStore/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/version");
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
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"versionName\":");
    try aws.json.writeValue(@TypeOf(input.version_name), input.version_name, allocator, &body_buf);
    has_prev = true;
    if (input.version_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"versionOptions\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAnnotationStoreVersionOutput {
    var result: CreateAnnotationStoreVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAnnotationStoreVersionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
