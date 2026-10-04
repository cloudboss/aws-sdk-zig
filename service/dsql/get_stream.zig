const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StreamFormat = @import("stream_format.zig").StreamFormat;
const StreamOrdering = @import("stream_ordering.zig").StreamOrdering;
const StreamStatus = @import("stream_status.zig").StreamStatus;
const StatusReason = @import("status_reason.zig").StatusReason;
const TargetDefinition = @import("target_definition.zig").TargetDefinition;

pub const GetStreamInput = struct {
    /// The ID of the cluster containing the stream to retrieve.
    cluster_identifier: []const u8,

    /// The ID of the stream to retrieve.
    stream_identifier: []const u8,

    pub const json_field_names = .{
        .cluster_identifier = "clusterIdentifier",
        .stream_identifier = "streamIdentifier",
    };
};

pub const GetStreamOutput = struct {
    /// The ARN of the retrieved stream.
    arn: []const u8,

    /// The ID of the cluster for the retrieved stream.
    cluster_identifier: []const u8,

    /// The time when the stream was created.
    creation_time: i64,

    /// The format of the stream records.
    format: StreamFormat,

    /// The ordering mode of the stream.
    ordering: StreamOrdering,

    /// The current status of the retrieved stream.
    status: StreamStatus,

    /// Stream status reason with error code and timestamp (if applicable).
    status_reason: ?StatusReason = null,

    /// The ID of the retrieved stream.
    stream_identifier: []const u8,

    /// A map of tags associated with the stream.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The target definition for the stream destination.
    target_definition: ?TargetDefinition = null,

    pub const json_field_names = .{
        .arn = "arn",
        .cluster_identifier = "clusterIdentifier",
        .creation_time = "creationTime",
        .format = "format",
        .ordering = "ordering",
        .status = "status",
        .status_reason = "statusReason",
        .stream_identifier = "streamIdentifier",
        .tags = "tags",
        .target_definition = "targetDefinition",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetStreamInput, options: CallOptions) !GetStreamOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dsql", "DSQL", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/stream/");
    try path_buf.appendSlice(allocator, input.cluster_identifier);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.stream_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetStreamOutput {
    const result: GetStreamOutput = try aws.json.parseJsonObject(
        GetStreamOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
