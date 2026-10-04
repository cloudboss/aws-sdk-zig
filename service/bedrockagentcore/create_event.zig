const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Branch = @import("branch.zig").Branch;
const ExtractionConfig = @import("extraction_config.zig").ExtractionConfig;
const ExtractionMode = @import("extraction_mode.zig").ExtractionMode;
const MetadataValue = @import("metadata_value.zig").MetadataValue;
const PayloadType = @import("payload_type.zig").PayloadType;
const Event = @import("event.zig").Event;

pub const CreateEventInput = struct {
    /// The identifier of the actor associated with this event. An actor represents
    /// an entity that participates in sessions and generates events.
    actor_id: []const u8,

    /// The branch information for this event. Branches allow for organizing events
    /// into different conversation threads or paths.
    branch: ?Branch = null,

    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, AgentCore
    /// ignores the request, but does not return an error.
    client_token: ?[]const u8 = null,

    /// The timestamp when the event occurred. If not specified, the current time is
    /// used.
    event_timestamp: i64,

    /// The extraction configuration for long-term memory records. Use this
    /// parameter to specify namespace variable keys and their values for namespace
    /// substitution during extraction.
    extraction_config: ?ExtractionConfig = null,

    /// Controls long-term memory extraction for this event. When set to `SKIP`, the
    /// event is stored in short-term memory but is excluded from long-term memory
    /// extraction. If not specified, the event is processed for extraction as
    /// usual.
    extraction_mode: ?ExtractionMode = null,

    /// The identifier of the AgentCore Memory resource in which to create the
    /// event.
    memory_id: []const u8,

    /// The key-value metadata to attach to the event.
    metadata: ?[]const aws.map.MapEntry(MetadataValue) = null,

    /// The content payload of the event. This can include conversational data, JSON
    /// data, or binary content.
    payload: []const PayloadType,

    /// The identifier of the session in which this event occurs. A session
    /// represents a sequence of related events.
    session_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .actor_id = "actorId",
        .branch = "branch",
        .client_token = "clientToken",
        .event_timestamp = "eventTimestamp",
        .extraction_config = "extractionConfig",
        .extraction_mode = "extractionMode",
        .memory_id = "memoryId",
        .metadata = "metadata",
        .payload = "payload",
        .session_id = "sessionId",
    };
};

pub const CreateEventOutput = struct {
    /// The event that was created.
    event: ?Event = null,

    pub const json_field_names = .{
        .event = "event",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEventInput, options: CallOptions) !CreateEventOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEventInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memories/");
    try path_buf.appendSlice(allocator, input.memory_id);
    try path_buf.appendSlice(allocator, "/events");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"actorId\":");
    try aws.json.writeValue(@TypeOf(input.actor_id), input.actor_id, allocator, &body_buf);
    has_prev = true;
    if (input.branch) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"branch\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"eventTimestamp\":");
    try aws.json.writeValue(@TypeOf(input.event_timestamp), input.event_timestamp, allocator, &body_buf);
    has_prev = true;
    if (input.extraction_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"extractionConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.extraction_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"extractionMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"metadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"payload\":");
    try aws.json.writeValue(@TypeOf(input.payload), input.payload, allocator, &body_buf);
    has_prev = true;
    if (input.session_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sessionId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEventOutput {
    const result: CreateEventOutput = try aws.json.parseJsonObject(
        CreateEventOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
