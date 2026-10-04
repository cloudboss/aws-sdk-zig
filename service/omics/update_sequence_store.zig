const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const S3AccessConfig = @import("s3_access_config.zig").S3AccessConfig;
const ETagAlgorithmFamily = @import("e_tag_algorithm_family.zig").ETagAlgorithmFamily;
const SequenceStoreS3Access = @import("sequence_store_s3_access.zig").SequenceStoreS3Access;
const SseConfig = @import("sse_config.zig").SseConfig;
const SequenceStoreStatus = @import("sequence_store_status.zig").SequenceStoreStatus;

pub const UpdateSequenceStoreInput = struct {
    /// To ensure that requests don't run multiple times, specify a unique token for
    /// each request.
    client_token: ?[]const u8 = null,

    /// A description for the sequence store.
    description: ?[]const u8 = null,

    /// The S3 URI of a bucket and folder to store Read Sets that fail to upload.
    fallback_location: ?[]const u8 = null,

    /// The ID of the sequence store.
    id: []const u8,

    /// A name for the sequence store.
    name: ?[]const u8 = null,

    /// The tags keys to propagate to the S3 objects associated with read sets in
    /// the sequence store.
    propagated_set_level_tags: ?[]const []const u8 = null,

    /// S3 access configuration parameters.
    s_3_access_config: ?S3AccessConfig = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .fallback_location = "fallbackLocation",
        .id = "id",
        .name = "name",
        .propagated_set_level_tags = "propagatedSetLevelTags",
        .s_3_access_config = "s3AccessConfig",
    };
};

pub const UpdateSequenceStoreOutput = struct {
    /// The ARN of the sequence store.
    arn: []const u8,

    /// The time when the store was created.
    creation_time: i64,

    /// Description of the sequence store.
    description: ?[]const u8 = null,

    /// The ETag algorithm family to use on ingested read sets.
    e_tag_algorithm_family: ?ETagAlgorithmFamily = null,

    /// The S3 URI of a bucket and folder to store Read Sets that fail to upload.
    fallback_location: ?[]const u8 = null,

    /// The ID of the sequence store.
    id: []const u8,

    /// The name of the sequence store.
    name: ?[]const u8 = null,

    /// The tags keys to propagate to the S3 objects associated with read sets in
    /// the sequence store.
    propagated_set_level_tags: ?[]const []const u8 = null,

    s_3_access: ?SequenceStoreS3Access = null,

    sse_config: ?SseConfig = null,

    /// The status of the sequence store.
    status: ?SequenceStoreStatus = null,

    /// The status message of the sequence store.
    status_message: ?[]const u8 = null,

    /// The last-updated time of the Sequence Store.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSequenceStoreInput, options: CallOptions) !UpdateSequenceStoreOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSequenceStoreInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sequencestore/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.fallback_location) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"fallbackLocation\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.propagated_set_level_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"propagatedSetLevelTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.s_3_access_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"s3AccessConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSequenceStoreOutput {
    const result: UpdateSequenceStoreOutput = try aws.json.parseJsonObject(
        UpdateSequenceStoreOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
