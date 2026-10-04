const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ParticipantDetailsToAdd = @import("participant_details_to_add.zig").ParticipantDetailsToAdd;
const ParticipantTokenCredentials = @import("participant_token_credentials.zig").ParticipantTokenCredentials;

pub const CreateParticipantInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8 = null,

    /// The identifier of the contact in this instance of Connect Customer. Supports
    /// contacts in the CHAT channel and VOICE (WebRTC) channels. For WebRTC calls,
    /// this should be
    /// the initial contact ID that was generated when the contact was first created
    /// (from the StartWebRTCContact API) in the
    /// VOICE channel
    contact_id: []const u8,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// Information identifying the participant.
    ///
    /// The only valid value for `ParticipantRole` is `CUSTOM_BOT` for chat contact
    /// and
    /// `CUSTOMER` for voice contact.
    participant_details: ParticipantDetailsToAdd,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .contact_id = "ContactId",
        .instance_id = "InstanceId",
        .participant_details = "ParticipantDetails",
    };
};

pub const CreateParticipantOutput = struct {
    /// The token used by the chat participant to call
    /// `CreateParticipantConnection`. The participant token
    /// is valid for the lifetime of a chat participant.
    participant_credentials: ?ParticipantTokenCredentials = null,

    /// The identifier for a chat participant. The participantId for a chat
    /// participant is the same throughout the chat
    /// lifecycle.
    participant_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .participant_credentials = "ParticipantCredentials",
        .participant_id = "ParticipantId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateParticipantInput, options: CallOptions) !CreateParticipantOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateParticipantInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/contact/create-participant";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ContactId\":");
    try aws.json.writeValue(@TypeOf(input.contact_id), input.contact_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InstanceId\":");
    try aws.json.writeValue(@TypeOf(input.instance_id), input.instance_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ParticipantDetails\":");
    try aws.json.writeValue(@TypeOf(input.participant_details), input.participant_details, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateParticipantOutput {
    const result: CreateParticipantOutput = try aws.json.parseJsonObject(
        CreateParticipantOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
