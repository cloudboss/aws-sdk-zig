const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ParticipantTokenCapability = @import("participant_token_capability.zig").ParticipantTokenCapability;
const ParticipantToken = @import("participant_token.zig").ParticipantToken;

pub const CreateParticipantTokenInput = struct {
    /// Application-provided attributes to encode into the token and attach to a
    /// stage. Map keys
    /// and values can contain UTF-8 encoded text. The maximum length of this field
    /// is 1 KB total.
    /// *This field is exposed to all stage participants and should not be used for
    /// personally identifying, confidential, or sensitive information.*
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// Set of capabilities that the user is allowed to perform in the stage.
    /// Default:
    /// `PUBLISH, SUBSCRIBE`.
    capabilities: ?[]const ParticipantTokenCapability = null,

    /// Duration (in minutes), after which the token expires. Default: 720 (12
    /// hours).
    duration: ?i32 = null,

    /// ARN of the stage to which this token is scoped.
    stage_arn: []const u8,

    /// Name that can be specified to help identify the token. This can be any UTF-8
    /// encoded
    /// text. *This field is exposed to all stage participants and should not be
    /// used for
    /// personally identifying, confidential, or sensitive information.*
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes = "attributes",
        .capabilities = "capabilities",
        .duration = "duration",
        .stage_arn = "stageArn",
        .user_id = "userId",
    };
};

pub const CreateParticipantTokenOutput = struct {
    /// The participant token that was created.
    participant_token: ?ParticipantToken = null,

    pub const json_field_names = .{
        .participant_token = "participantToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateParticipantTokenInput, options: CallOptions) !CreateParticipantTokenOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ivs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateParticipantTokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivsrealtime", "IVS RealTime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateParticipantToken";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"attributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.capabilities) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"capabilities\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.duration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"duration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"stageArn\":");
    try aws.json.writeValue(@TypeOf(input.stage_arn), input.stage_arn, allocator, &body_buf);
    has_prev = true;
    if (input.user_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"userId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateParticipantTokenOutput {
    var result: CreateParticipantTokenOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateParticipantTokenOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
