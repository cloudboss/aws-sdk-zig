const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VoiceProfileDomain = @import("voice_profile_domain.zig").VoiceProfileDomain;

pub const UpdateVoiceProfileDomainInput = struct {
    /// The description of the voice profile domain.
    description: ?[]const u8 = null,

    /// The name of the voice profile domain.
    name: ?[]const u8 = null,

    /// The domain ID.
    voice_profile_domain_id: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
        .voice_profile_domain_id = "VoiceProfileDomainId",
    };
};

pub const UpdateVoiceProfileDomainOutput = struct {
    /// The updated details of the voice profile domain.
    voice_profile_domain: ?VoiceProfileDomain = null,

    pub const json_field_names = .{
        .voice_profile_domain = "VoiceProfileDomain",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateVoiceProfileDomainInput, options: CallOptions) !UpdateVoiceProfileDomainOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateVoiceProfileDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voice-chime", "Chime SDK Voice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/voice-profile-domains/");
    try path_buf.appendSlice(allocator, input.voice_profile_domain_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateVoiceProfileDomainOutput {
    var result: UpdateVoiceProfileDomainOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateVoiceProfileDomainOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
