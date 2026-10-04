const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SetDefaultSenderIdInput = struct {
    /// The configuration set to updated with a new default SenderId. This field can
    /// be the ConsigurationSetName or ConfigurationSetArn.
    configuration_set_name: []const u8,

    /// The current sender ID for the configuration set. When sending a text message
    /// to a destination country which supports SenderIds, the default sender ID on
    /// the configuration set specified on SendTextMessage will be used if no
    /// dedicated origination phone numbers or registered SenderIds are available in
    /// your account, instead of a generic sender ID, such as 'NOTICE'.
    sender_id: []const u8,

    pub const json_field_names = .{
        .configuration_set_name = "ConfigurationSetName",
        .sender_id = "SenderId",
    };
};

pub const SetDefaultSenderIdOutput = struct {
    /// The Amazon Resource Name (ARN) of the updated configuration set.
    configuration_set_arn: ?[]const u8 = null,

    /// The name of the configuration set that was updated.
    configuration_set_name: ?[]const u8 = null,

    /// The default sender ID to set for the ConfigurationSet.
    sender_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_set_arn = "ConfigurationSetArn",
        .configuration_set_name = "ConfigurationSetName",
        .sender_id = "SenderId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetDefaultSenderIdInput, options: CallOptions) !SetDefaultSenderIdOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SetDefaultSenderIdInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.SetDefaultSenderId");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetDefaultSenderIdOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SetDefaultSenderIdOutput, body, allocator);
}
