const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IndexMode = @import("index_mode.zig").IndexMode;
const VectorData = @import("vector_data.zig").VectorData;
const DistanceMetric = @import("distance_metric.zig").DistanceMetric;
const QueryOutputVector = @import("query_output_vector.zig").QueryOutputVector;

pub const QueryVectorsInput = struct {
    /// Metadata filter to apply during the query. For more information about
    /// metadata keys, see [Metadata
    /// filtering](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-vectors-metadata-filtering.html) in the *Amazon S3 User Guide*.
    filter: ?[]const u8 = null,

    /// The ARN of the vector index that you want to query.
    index_arn: ?[]const u8 = null,

    /// The name of the vector index that you want to query.
    index_name: ?[]const u8 = null,

    /// Pagination token from a previous request. The value of this field is empty
    /// for an initial request.
    next_token: ?[]const u8 = null,

    /// The mode to use to process the query. If you don't specify a query mode, the
    /// operation uses the mode that's currently configured for the vector index.
    ///
    /// Valid values:
    ///
    /// * `CLASSIC` - Applies metadata filters during the vector search. You can't
    ///   specify `CLASSIC` for an `ENHANCED` index.
    /// * `ENHANCED` - Applies metadata filters before the vector search.
    query_mode: ?IndexMode = null,

    /// The query vector. Ensure that the query vector has the same dimension as the
    /// dimension of the vector index that's being queried. For example, if your
    /// vector index contains vectors with 384 dimensions, your query vector must
    /// also have 384 dimensions.
    query_vector: VectorData,

    /// Indicates whether to include the computed distance in the response. The
    /// default value is `false`.
    return_distance: ?bool = null,

    /// Indicates whether to include metadata in the response. The default value is
    /// `false`.
    return_metadata: ?bool = null,

    /// The number of results to return for each query.
    top_k: i32,

    /// The name of the vector bucket that contains the vector index.
    vector_bucket_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter = "filter",
        .index_arn = "indexArn",
        .index_name = "indexName",
        .next_token = "nextToken",
        .query_mode = "queryMode",
        .query_vector = "queryVector",
        .return_distance = "returnDistance",
        .return_metadata = "returnMetadata",
        .top_k = "topK",
        .vector_bucket_name = "vectorBucketName",
    };
};

pub const QueryVectorsOutput = struct {
    /// The distance metric that was used for the similarity search calculation.
    /// This is the same distance metric that was configured for the vector index
    /// when it was created.
    distance_metric: DistanceMetric,

    /// Pagination token to be used in the subsequent page request. The field is
    /// empty if no further pagination is required.
    next_token: ?[]const u8 = null,

    /// The vectors in the approximate nearest neighbor search.
    vectors: ?[]const QueryOutputVector = null,

    pub const json_field_names = .{
        .distance_metric = "distanceMetric",
        .next_token = "nextToken",
        .vectors = "vectors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: QueryVectorsInput, options: CallOptions) !QueryVectorsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: QueryVectorsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3vectors", "S3Vectors", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/QueryVectors";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.query_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"queryMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"queryVector\":");
    try aws.json.writeValue(@TypeOf(input.query_vector), input.query_vector, allocator, &body_buf);
    has_prev = true;
    if (input.return_distance) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"returnDistance\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.return_metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"returnMetadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"topK\":");
    try aws.json.writeValue(@TypeOf(input.top_k), input.top_k, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !QueryVectorsOutput {
    const result: QueryVectorsOutput = try aws.json.parseJsonObject(
        QueryVectorsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
