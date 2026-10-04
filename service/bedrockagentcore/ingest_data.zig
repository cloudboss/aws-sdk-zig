const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExtractionConfig = @import("extraction_config.zig").ExtractionConfig;
const MetadataValue = @import("metadata_value.zig").MetadataValue;
const ContentSource = @import("content_source.zig").ContentSource;

pub const IngestDataInput = struct {
    /// The identifier of the actor associated with this content. An actor
    /// represents an entity that participates in sessions and generates content.
    actor_id: []const u8,

    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, AgentCore
    /// ignores the request, but does not return an error.
    client_token: ?[]const u8 = null,

    /// The timestamp of when the content occurred.
    content_timestamp: i64,

    /// The extraction configuration for long-term memory records. Use this
    /// parameter to specify namespace variable keys and their values for namespace
    /// substitution during extraction.
    extraction_config: ?ExtractionConfig = null,

    /// The identifier of the AgentCore Memory resource to ingest content into.
    memory_id: []const u8,

    /// The key-value metadata to attach to the content.
    metadata: ?[]const aws.map.MapEntry(MetadataValue) = null,

    /// The identifier of the session that the content belongs to. If not provided,
    /// a session identifier is generated and returned in the response.
    session_id: ?[]const u8 = null,

    /// The content to ingest. Only inline content is supported.
    source: ContentSource,

    pub const json_field_names = .{
        .actor_id = "actorId",
        .client_token = "clientToken",
        .content_timestamp = "contentTimestamp",
        .extraction_config = "extractionConfig",
        .memory_id = "memoryId",
        .metadata = "metadata",
        .session_id = "sessionId",
        .source = "source",
    };
};

pub const IngestDataOutput = struct {
    /// The identifier of the session that the service ingested the content into.
    /// This value echoes the session identifier from the request, or the identifier
    /// that the service generated when you did not provide one.
    session_id: []const u8,

    pub const json_field_names = .{
        .session_id = "sessionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: IngestDataInput, options: CallOptions) !IngestDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: IngestDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memories/");
    try path_buf.appendSlice(allocator, input.memory_id);
    try path_buf.appendSlice(allocator, "/ingest");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"actorId\":");
    try aws.json.writeValue(@TypeOf(input.actor_id), input.actor_id, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"contentTimestamp\":");
    try aws.json.writeValue(@TypeOf(input.content_timestamp), input.content_timestamp, allocator, &body_buf);
    has_prev = true;
    if (input.extraction_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"extractionConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"metadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.session_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sessionId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"source\":");
    try aws.json.writeValue(@TypeOf(input.source), input.source, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !IngestDataOutput {
    const result: IngestDataOutput = try aws.json.parseJsonObject(
        IngestDataOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
