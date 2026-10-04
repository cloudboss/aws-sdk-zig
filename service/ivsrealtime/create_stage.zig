const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoParticipantRecordingConfiguration = @import("auto_participant_recording_configuration.zig").AutoParticipantRecordingConfiguration;
const ParticipantTokenConfiguration = @import("participant_token_configuration.zig").ParticipantTokenConfiguration;
const ParticipantToken = @import("participant_token.zig").ParticipantToken;
const Stage = @import("stage.zig").Stage;

pub const CreateStageInput = struct {
    /// Configuration object for individual participant recording, to attach to the
    /// new stage.
    auto_participant_recording_configuration: ?AutoParticipantRecordingConfiguration = null,

    /// Optional name that can be specified for the stage being created.
    name: ?[]const u8 = null,

    /// Array of participant token configuration objects to attach to the new stage.
    participant_token_configurations: ?[]const ParticipantTokenConfiguration = null,

    /// Tags attached to the resource. Array of maps, each of the form
    /// `string:string
    /// (key:value)`. See [Best practices and
    /// strategies](https://docs.aws.amazon.com/tag-editor/latest/userguide/best-practices-and-strats.html)
    /// in *Tagging AWS Resources and Tag Editor* for details, including
    /// restrictions that apply to tags and "Tag naming
    /// limits and requirements"; Amazon IVS has no constraints on tags beyond what
    /// is documented
    /// there.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .auto_participant_recording_configuration = "autoParticipantRecordingConfiguration",
        .name = "name",
        .participant_token_configurations = "participantTokenConfigurations",
        .tags = "tags",
    };
};

pub const CreateStageOutput = struct {
    /// Participant tokens attached to the stage. These correspond to the
    /// `participants` in the request.
    participant_tokens: ?[]const ParticipantToken = null,

    /// The stage that was created.
    stage: ?Stage = null,

    pub const json_field_names = .{
        .participant_tokens = "participantTokens",
        .stage = "stage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStageInput, options: CallOptions) !CreateStageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivsrealtime", "IVS RealTime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateStage";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.auto_participant_recording_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"autoParticipantRecordingConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.participant_token_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"participantTokenConfigurations\":");
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
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStageOutput {
    var result: CreateStageOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateStageOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
