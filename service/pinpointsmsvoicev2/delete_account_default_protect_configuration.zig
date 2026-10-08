const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteAccountDefaultProtectConfigurationInput = struct {};

pub const DeleteAccountDefaultProtectConfigurationOutput = struct {
    /// The Amazon Resource Name (ARN) of the account default protect configuration.
    default_protect_configuration_arn: []const u8,

    /// The unique identifier of the account default protect configuration.
    default_protect_configuration_id: []const u8,

    pub const json_field_names = .{
        .default_protect_configuration_arn = "DefaultProtectConfigurationArn",
        .default_protect_configuration_id = "DefaultProtectConfigurationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteAccountDefaultProtectConfigurationInput, options: CallOptions) !DeleteAccountDefaultProtectConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sms-voice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteAccountDefaultProtectConfigurationInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("sms-voice", "Pinpoint SMS Voice V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.DeleteAccountDefaultProtectConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteAccountDefaultProtectConfigurationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DeleteAccountDefaultProtectConfigurationOutput, body, allocator);
}
