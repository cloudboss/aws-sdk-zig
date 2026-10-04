const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const StorageClassConfiguration = @import("storage_class_configuration.zig").StorageClassConfiguration;

pub const CreateTableBucketInput = struct {
    /// The encryption configuration to use for the table bucket. This configuration
    /// specifies the default encryption settings that will be applied to all tables
    /// created in this bucket unless overridden at the table level. The
    /// configuration includes the encryption algorithm and, if using SSE-KMS, the
    /// KMS key to use.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The name for the table bucket.
    name: []const u8,

    /// The default storage class configuration for the table bucket. This
    /// configuration will be applied to all new tables created in this bucket
    /// unless overridden at the table level. If not specified, the service default
    /// storage class will be used.
    storage_class_configuration: ?StorageClassConfiguration = null,

    /// A map of user-defined tags that you would like to apply to the table bucket
    /// that you are creating. A tag is a key-value pair that you apply to your
    /// resources. Tags can help you organize and control access to resources. For
    /// more information, see [Tagging for cost allocation or attribute-based access
    /// control
    /// (ABAC)](https://docs.aws.amazon.com/AmazonS3/latest/userguide/tagging.html).
    ///
    /// You must have the `s3tables:TagResource` permission in addition to
    /// `s3tables:CreateTableBucket` permisson to create a table bucket with tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .encryption_configuration = "encryptionConfiguration",
        .name = "name",
        .storage_class_configuration = "storageClassConfiguration",
        .tags = "tags",
    };
};

pub const CreateTableBucketOutput = struct {
    /// The Amazon Resource Name (ARN) of the table bucket.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTableBucketInput, options: CallOptions) !CreateTableBucketOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3tables", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTableBucketInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3tables", "S3Tables", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/buckets";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.encryption_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"encryptionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.storage_class_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"storageClassConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTableBucketOutput {
    const result: CreateTableBucketOutput = try aws.json.parseJsonObject(
        CreateTableBucketOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
