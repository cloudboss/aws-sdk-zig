const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VectorBucket = @import("vector_bucket.zig").VectorBucket;

pub const GetVectorBucketInput = struct {
    /// The ARN of the vector bucket to retrieve information about.
    vector_bucket_arn: ?[]const u8 = null,

    /// The name of the vector bucket to retrieve information about.
    vector_bucket_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .vector_bucket_arn = "vectorBucketArn",
        .vector_bucket_name = "vectorBucketName",
    };
};

pub const GetVectorBucketOutput = struct {
    /// The attributes of the vector bucket.
    vector_bucket: ?VectorBucket = null,

    pub const json_field_names = .{
        .vector_bucket = "vectorBucket",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetVectorBucketInput, options: CallOptions) !GetVectorBucketOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetVectorBucketInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3vectors", "S3Vectors", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetVectorBucket";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetVectorBucketOutput {
    var result: GetVectorBucketOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetVectorBucketOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
