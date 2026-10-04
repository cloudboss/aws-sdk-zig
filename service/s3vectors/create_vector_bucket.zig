const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;

pub const CreateVectorBucketInput = struct {
    /// The encryption configuration for the vector bucket. By default, if you don't
    /// specify, all new vectors in Amazon S3 vector buckets use server-side
    /// encryption with Amazon S3 managed keys (SSE-S3), specifically `AES256`.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// An array of user-defined tags that you would like to apply to the vector
    /// bucket that you are creating. A tag is a key-value pair that you apply to
    /// your resources. Tags can help you organize and control access to resources.
    /// For more information, see [Tagging for cost allocation or attribute-based
    /// access control
    /// (ABAC)](https://docs.aws.amazon.com/AmazonS3/latest/userguide/tagging.html).
    ///
    /// You must have the `s3vectors:TagResource` permission in addition to
    /// `s3vectors:CreateVectorBucket` permission to create a vector bucket with
    /// tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The name of the vector bucket to create.
    vector_bucket_name: []const u8,

    pub const json_field_names = .{
        .encryption_configuration = "encryptionConfiguration",
        .tags = "tags",
        .vector_bucket_name = "vectorBucketName",
    };
};

pub const CreateVectorBucketOutput = struct {
    /// The Amazon Resource Name (ARN) of the newly created vector bucket.
    vector_bucket_arn: []const u8,

    pub const json_field_names = .{
        .vector_bucket_arn = "vectorBucketArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVectorBucketInput, options: CallOptions) !CreateVectorBucketOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVectorBucketInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3vectors", "S3Vectors", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateVectorBucket";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.encryption_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"encryptionConfiguration\":");
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
    try body_buf.appendSlice(allocator, "\"vectorBucketName\":");
    try aws.json.writeValue(@TypeOf(input.vector_bucket_name), input.vector_bucket_name, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVectorBucketOutput {
    const result: CreateVectorBucketOutput = try aws.json.parseJsonObject(
        CreateVectorBucketOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
