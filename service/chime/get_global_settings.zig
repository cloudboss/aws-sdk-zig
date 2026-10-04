const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BusinessCallingSettings = @import("business_calling_settings.zig").BusinessCallingSettings;
const VoiceConnectorSettings = @import("voice_connector_settings.zig").VoiceConnectorSettings;

pub const GetGlobalSettingsInput = struct {};

pub const GetGlobalSettingsOutput = struct {
    /// The Amazon Chime Business Calling settings.
    business_calling: ?BusinessCallingSettings = null,

    /// The Amazon Chime Voice Connector settings.
    voice_connector: ?VoiceConnectorSettings = null,

    pub const json_field_names = .{
        .business_calling = "BusinessCalling",
        .voice_connector = "VoiceConnector",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGlobalSettingsInput, options: CallOptions) !GetGlobalSettingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetGlobalSettingsInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("chime", "Chime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/settings";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetGlobalSettingsOutput {
    const result: GetGlobalSettingsOutput = try aws.json.parseJsonObject(
        GetGlobalSettingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
