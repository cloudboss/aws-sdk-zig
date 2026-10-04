const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MessageType = @import("message_type.zig").MessageType;

pub const DeleteDefaultMessageTypeInput = struct {
    /// The name of the configuration set or the configuration set Amazon Resource
    /// Name (ARN) to delete the default message type from. The ConfigurationSetName
    /// and ConfigurationSetArn can be found using the DescribeConfigurationSets
    /// action.
    configuration_set_name: []const u8,

    pub const json_field_names = .{
        .configuration_set_name = "ConfigurationSetName",
    };
};

pub const DeleteDefaultMessageTypeOutput = struct {
    /// The Amazon Resource Name (ARN) of the configuration set.
    configuration_set_arn: ?[]const u8 = null,

    /// The name of the configuration set.
    configuration_set_name: ?[]const u8 = null,

    /// The current message type for the configuration set.
    message_type: ?MessageType = null,

    pub const json_field_names = .{
        .configuration_set_arn = "ConfigurationSetArn",
        .configuration_set_name = "ConfigurationSetName",
        .message_type = "MessageType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteDefaultMessageTypeInput, options: CallOptions) !DeleteDefaultMessageTypeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteDefaultMessageTypeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.DeleteDefaultMessageType");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteDefaultMessageTypeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteDefaultMessageTypeOutput, body, allocator);
}
