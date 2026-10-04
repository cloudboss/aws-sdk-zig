const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateProtectConfigurationInput = struct {
    /// When set to true deletion protection is enabled. By default this is set to
    /// false.
    deletion_protection_enabled: ?bool = null,

    /// The unique identifier for the protect configuration.
    protect_configuration_id: []const u8,

    pub const json_field_names = .{
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .protect_configuration_id = "ProtectConfigurationId",
    };
};

pub const UpdateProtectConfigurationOutput = struct {
    /// This is true if the protect configuration is set as your account default
    /// protect configuration.
    account_default: ?bool = null,

    /// The time when the protect configuration was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: i64,

    /// The status of deletion protection for the protect configuration. When set to
    /// true deletion protection is enabled. By default this is set to false.
    deletion_protection_enabled: ?bool = null,

    /// The Amazon Resource Name (ARN) of the protect configuration.
    protect_configuration_arn: []const u8,

    /// The unique identifier for the protect configuration.
    protect_configuration_id: []const u8,

    pub const json_field_names = .{
        .account_default = "AccountDefault",
        .created_timestamp = "CreatedTimestamp",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .protect_configuration_arn = "ProtectConfigurationArn",
        .protect_configuration_id = "ProtectConfigurationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProtectConfigurationInput, options: CallOptions) !UpdateProtectConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProtectConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sms-voice", "Pinpoint SMS Voice V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.UpdateProtectConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProtectConfigurationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateProtectConfigurationOutput, body, allocator);
}
