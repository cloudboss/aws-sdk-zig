const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataType = @import("data_type.zig").DataType;
const DistanceMetric = @import("distance_metric.zig").DistanceMetric;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const MetadataConfiguration = @import("metadata_configuration.zig").MetadataConfiguration;

pub const CreateIndexInput = struct {
    /// The data type of the vectors to be inserted into the vector index.
    data_type: DataType,

    /// The dimensions of the vectors to be inserted into the vector index.
    dimension: i32,

    /// The distance metric to be used for similarity search.
    distance_metric: DistanceMetric,

    /// The encryption configuration for a vector index. By default, if you don't
    /// specify, all new vectors in the vector index will use the encryption
    /// configuration of the vector bucket.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The name of the vector index to create.
    index_name: []const u8,

    /// The metadata configuration for the vector index.
    metadata_configuration: ?MetadataConfiguration = null,

    /// An array of user-defined tags that you would like to apply to the vector
    /// index that you are creating. A tag is a key-value pair that you apply to
    /// your resources. Tags can help you organize, track costs, and control access
    /// to resources. For more information, see [Tagging for cost allocation or
    /// attribute-based access control
    /// (ABAC)](https://docs.aws.amazon.com/AmazonS3/latest/userguide/tagging.html).
    ///
    /// You must have the `s3vectors:TagResource` permission in addition to
    /// `s3vectors:CreateIndex` permission to create a vector index with tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the vector bucket to create the vector
    /// index in.
    vector_bucket_arn: ?[]const u8 = null,

    /// The name of the vector bucket to create the vector index in.
    vector_bucket_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_type = "dataType",
        .dimension = "dimension",
        .distance_metric = "distanceMetric",
        .encryption_configuration = "encryptionConfiguration",
        .index_name = "indexName",
        .metadata_configuration = "metadataConfiguration",
        .tags = "tags",
        .vector_bucket_arn = "vectorBucketArn",
        .vector_bucket_name = "vectorBucketName",
    };
};

pub const CreateIndexOutput = struct {
    /// The Amazon Resource Name (ARN) of the newly created vector index.
    index_arn: []const u8,

    pub const json_field_names = .{
        .index_arn = "indexArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIndexInput, options: CallOptions) !CreateIndexOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateIndexInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3vectors", "S3Vectors", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateIndex";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"dataType\":");
    try aws.json.writeValue(@TypeOf(input.data_type), input.data_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"dimension\":");
    try aws.json.writeValue(@TypeOf(input.dimension), input.dimension, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"distanceMetric\":");
    try aws.json.writeValue(@TypeOf(input.distance_metric), input.distance_metric, allocator, &body_buf);
    has_prev = true;
    if (input.encryption_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"encryptionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"indexName\":");
    try aws.json.writeValue(@TypeOf(input.index_name), input.index_name, allocator, &body_buf);
    has_prev = true;
    if (input.metadata_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"metadataConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateIndexOutput {
    const result: CreateIndexOutput = try aws.json.parseJsonObject(
        CreateIndexOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
