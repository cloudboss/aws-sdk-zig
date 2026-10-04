const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GetOutputVector = @import("get_output_vector.zig").GetOutputVector;

pub const GetVectorsInput = struct {
    /// The ARN of the vector index.
    index_arn: ?[]const u8 = null,

    /// The name of the vector index.
    index_name: ?[]const u8 = null,

    /// The names of the vectors you want to return attributes for.
    keys: []const []const u8,

    /// Indicates whether to include the vector data in the response. The default
    /// value is `false`.
    return_data: ?bool = null,

    /// Indicates whether to include metadata in the response. The default value is
    /// `false`.
    return_metadata: ?bool = null,

    /// The name of the vector bucket that contains the vector index.
    vector_bucket_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .index_arn = "indexArn",
        .index_name = "indexName",
        .keys = "keys",
        .return_data = "returnData",
        .return_metadata = "returnMetadata",
        .vector_bucket_name = "vectorBucketName",
    };
};

pub const GetVectorsOutput = struct {
    /// The attributes of the vectors.
    vectors: ?[]const GetOutputVector = null,

    pub const json_field_names = .{
        .vectors = "vectors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetVectorsInput, options: CallOptions) !GetVectorsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetVectorsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3vectors", "S3Vectors", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetVectors";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.index_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"indexArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.index_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"indexName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"keys\":");
    try aws.json.writeValue(@TypeOf(input.keys), input.keys, allocator, &body_buf);
    has_prev = true;
    if (input.return_data) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"returnData\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.return_metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"returnMetadata\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetVectorsOutput {
    const result: GetVectorsOutput = try aws.json.parseJsonObject(
        GetVectorsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
