const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SipMediaApplicationLoggingConfiguration = @import("sip_media_application_logging_configuration.zig").SipMediaApplicationLoggingConfiguration;

pub const GetSipMediaApplicationLoggingConfigurationInput = struct {
    /// The SIP media application ID.
    sip_media_application_id: []const u8,

    pub const json_field_names = .{
        .sip_media_application_id = "SipMediaApplicationId",
    };
};

pub const GetSipMediaApplicationLoggingConfigurationOutput = struct {
    /// The actual logging configuration.
    sip_media_application_logging_configuration: ?SipMediaApplicationLoggingConfiguration = null,

    pub const json_field_names = .{
        .sip_media_application_logging_configuration = "SipMediaApplicationLoggingConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSipMediaApplicationLoggingConfigurationInput, options: CallOptions) !GetSipMediaApplicationLoggingConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSipMediaApplicationLoggingConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voice-chime", "Chime SDK Voice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sip-media-applications/");
    try path_buf.appendSlice(allocator, input.sip_media_application_id);
    try path_buf.appendSlice(allocator, "/logging-configuration");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSipMediaApplicationLoggingConfigurationOutput {
    var result: GetSipMediaApplicationLoggingConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSipMediaApplicationLoggingConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
