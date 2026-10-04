const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IndexMode = @import("index_mode.zig").IndexMode;

pub const PutVectorBucketDefaultIndexModeInput = struct {
    /// The default mode to assign to new vector indexes in the vector bucket. This
    /// change doesn't affect existing vector indexes.
    default_index_mode: IndexMode,

    /// The Amazon Resource Name (ARN) of the vector bucket to update.
    vector_bucket_arn: ?[]const u8 = null,

    /// The name of the vector bucket to update.
    vector_bucket_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .default_index_mode = "defaultIndexMode",
        .vector_bucket_arn = "vectorBucketArn",
        .vector_bucket_name = "vectorBucketName",
    };
};

pub const PutVectorBucketDefaultIndexModeOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutVectorBucketDefaultIndexModeInput, options: CallOptions) !PutVectorBucketDefaultIndexModeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3vectors", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutVectorBucketDefaultIndexModeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3vectors", "S3Vectors", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/PutVectorBucketDefaultIndexMode";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"defaultIndexMode\":");
    try aws.json.writeValue(@TypeOf(input.default_index_mode), input.default_index_mode, allocator, &body_buf);
    has_prev = true;
    if (input.vector_bucket_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"vectorBucketArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vector_bucket_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"vectorBucketName\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutVectorBucketDefaultIndexModeOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutVectorBucketDefaultIndexModeOutput = .{};

    return result;
}
