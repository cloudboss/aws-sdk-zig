const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectionRecordingPreferences = @import("connection_recording_preferences.zig").ConnectionRecordingPreferences;

pub const GetConnectionRecordingPreferencesInput = struct {};

pub const GetConnectionRecordingPreferencesOutput = struct {
    /// Service-provided idempotency token.
    client_token: ?[]const u8 = null,

    /// The set of preferences used for recording RDP connections in the requesting
    /// Amazon Web Services account and Amazon Web Services Region. This includes
    /// details such as which S3 bucket recordings are stored in.
    connection_recording_preferences: ?ConnectionRecordingPreferences = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .connection_recording_preferences = "ConnectionRecordingPreferences",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConnectionRecordingPreferencesInput, options: CallOptions) !GetConnectionRecordingPreferencesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-guiconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConnectionRecordingPreferencesInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("ssm-guiconnect", "SSM GuiConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetConnectionRecordingPreferences";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConnectionRecordingPreferencesOutput {
    var result: GetConnectionRecordingPreferencesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetConnectionRecordingPreferencesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
