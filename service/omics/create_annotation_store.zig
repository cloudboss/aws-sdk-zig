const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReferenceItem = @import("reference_item.zig").ReferenceItem;
const SseConfig = @import("sse_config.zig").SseConfig;
const StoreFormat = @import("store_format.zig").StoreFormat;
const StoreOptions = @import("store_options.zig").StoreOptions;
const StoreStatus = @import("store_status.zig").StoreStatus;

pub const CreateAnnotationStoreInput = struct {
    /// A description for the store.
    description: ?[]const u8 = null,

    /// A name for the store.
    name: ?[]const u8 = null,

    /// The genome reference for the store's annotations.
    reference: ?ReferenceItem = null,

    /// Server-side encryption (SSE) settings for the store.
    sse_config: ?SseConfig = null,

    /// The annotation file format of the store.
    store_format: StoreFormat,

    /// File parsing options for the annotation store.
    store_options: ?StoreOptions = null,

    /// Tags for the store.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The name given to an annotation store version to distinguish it from other
    /// versions.
    version_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .reference = "reference",
        .sse_config = "sseConfig",
        .store_format = "storeFormat",
        .store_options = "storeOptions",
        .tags = "tags",
        .version_name = "versionName",
    };
};

pub const CreateAnnotationStoreOutput = struct {
    /// When the store was created.
    creation_time: i64,

    /// The store's ID.
    id: []const u8,

    /// The store's name.
    name: []const u8,

    /// The store's genome reference. Required for all stores except TSV format with
    /// generic annotations.
    reference: ?ReferenceItem = null,

    /// The store's status.
    status: StoreStatus,

    /// The annotation file format of the store.
    store_format: ?StoreFormat = null,

    /// The store's file parsing options.
    store_options: ?StoreOptions = null,

    /// The name given to an annotation store version to distinguish it from other
    /// versions.
    version_name: []const u8,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .id = "id",
        .name = "name",
        .reference = "reference",
        .status = "status",
        .store_format = "storeFormat",
        .store_options = "storeOptions",
        .version_name = "versionName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAnnotationStoreInput, options: CallOptions) !CreateAnnotationStoreOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAnnotationStoreInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/annotationStore";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.reference) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"reference\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sse_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sseConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"storeFormat\":");
    try aws.json.writeValue(@TypeOf(input.store_format), input.store_format, allocator, &body_buf);
    has_prev = true;
    if (input.store_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"storeOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.version_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"versionName\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAnnotationStoreOutput {
    const result: CreateAnnotationStoreOutput = try aws.json.parseJsonObject(
        CreateAnnotationStoreOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
