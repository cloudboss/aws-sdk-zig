const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StreamFormat = @import("stream_format.zig").StreamFormat;
const StreamOrdering = @import("stream_ordering.zig").StreamOrdering;
const TargetDefinition = @import("target_definition.zig").TargetDefinition;
const StreamStatus = @import("stream_status.zig").StreamStatus;

pub const CreateStreamInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. Idempotency ensures that an API request
    /// completes only once. With an idempotent request, if the original request
    /// completes successfully, the subsequent retries with the same client token
    /// return the result from the original successful request and they have no
    /// additional effect.
    ///
    /// If you don't specify a client token, the Amazon Web Services SDK
    /// automatically generates one.
    client_token: ?[]const u8 = null,

    /// The ID of the cluster for which to create the stream.
    cluster_identifier: []const u8,

    /// The format of the stream records.
    format: StreamFormat,

    /// The ordering mode for the stream. Determines how change events are ordered
    /// when delivered to the target.
    ordering: StreamOrdering,

    /// A map of key and value pairs to use to tag your stream.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The target destination configuration for the stream. Contains Kinesis stream
    /// configuration including stream ARN and IAM role ARN.
    target_definition: TargetDefinition,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .cluster_identifier = "clusterIdentifier",
        .format = "format",
        .ordering = "ordering",
        .tags = "tags",
        .target_definition = "targetDefinition",
    };
};

pub const CreateStreamOutput = struct {
    /// The ARN of the created stream.
    arn: []const u8,

    /// The ID of the cluster for the created stream.
    cluster_identifier: []const u8,

    /// The time when created the stream.
    creation_time: i64,

    /// The format of the created stream records.
    format: StreamFormat,

    /// The ordering mode of the created stream.
    ordering: StreamOrdering,

    /// The status of the created stream.
    status: StreamStatus,

    /// The ID of the created stream.
    stream_identifier: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .cluster_identifier = "clusterIdentifier",
        .creation_time = "creationTime",
        .format = "format",
        .ordering = "ordering",
        .status = "status",
        .stream_identifier = "streamIdentifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStreamInput, options: CallOptions) !CreateStreamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dsql", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dsql", "DSQL", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/stream/");
    try path_buf.appendSlice(allocator, input.cluster_identifier);
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"format\":");
    try aws.json.writeValue(@TypeOf(input.format), input.format, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ordering\":");
    try aws.json.writeValue(@TypeOf(input.ordering), input.ordering, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetDefinition\":");
    try aws.json.writeValue(@TypeOf(input.target_definition), input.target_definition, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStreamOutput {
    const result: CreateStreamOutput = try aws.json.parseJsonObject(
        CreateStreamOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
