const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SipMediaApplicationAlexaSkillConfiguration = @import("sip_media_application_alexa_skill_configuration.zig").SipMediaApplicationAlexaSkillConfiguration;

pub const PutSipMediaApplicationAlexaSkillConfigurationInput = struct {
    /// The Alexa Skill configuration.
    sip_media_application_alexa_skill_configuration: ?SipMediaApplicationAlexaSkillConfiguration = null,

    /// The SIP media application ID.
    sip_media_application_id: []const u8,

    pub const json_field_names = .{
        .sip_media_application_alexa_skill_configuration = "SipMediaApplicationAlexaSkillConfiguration",
        .sip_media_application_id = "SipMediaApplicationId",
    };
};

pub const PutSipMediaApplicationAlexaSkillConfigurationOutput = struct {
    /// Returns the Alexa Skill configuration.
    sip_media_application_alexa_skill_configuration: ?SipMediaApplicationAlexaSkillConfiguration = null,

    pub const json_field_names = .{
        .sip_media_application_alexa_skill_configuration = "SipMediaApplicationAlexaSkillConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutSipMediaApplicationAlexaSkillConfigurationInput, options: CallOptions) !PutSipMediaApplicationAlexaSkillConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutSipMediaApplicationAlexaSkillConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voice-chime", "Chime SDK Voice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sip-media-applications/");
    try path_buf.appendSlice(allocator, input.sip_media_application_id);
    try path_buf.appendSlice(allocator, "/alexa-skill-configuration");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.sip_media_application_alexa_skill_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SipMediaApplicationAlexaSkillConfiguration\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutSipMediaApplicationAlexaSkillConfigurationOutput {
    var result: PutSipMediaApplicationAlexaSkillConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutSipMediaApplicationAlexaSkillConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
