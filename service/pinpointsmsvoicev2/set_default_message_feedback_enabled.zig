const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SetDefaultMessageFeedbackEnabledInput = struct {
    /// The name of the configuration set to use. This can be either the
    /// ConfigurationSetName or ConfigurationSetArn.
    configuration_set_name: []const u8,

    /// Set to true to enable message feedback.
    message_feedback_enabled: bool,

    pub const json_field_names = .{
        .configuration_set_name = "ConfigurationSetName",
        .message_feedback_enabled = "MessageFeedbackEnabled",
    };
};

pub const SetDefaultMessageFeedbackEnabledOutput = struct {
    /// The arn of the configuration set.
    configuration_set_arn: ?[]const u8 = null,

    /// The name of the configuration.
    configuration_set_name: ?[]const u8 = null,

    /// True if message feedback is enabled.
    message_feedback_enabled: ?bool = null,

    pub const json_field_names = .{
        .configuration_set_arn = "ConfigurationSetArn",
        .configuration_set_name = "ConfigurationSetName",
        .message_feedback_enabled = "MessageFeedbackEnabled",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetDefaultMessageFeedbackEnabledInput, options: CallOptions) !SetDefaultMessageFeedbackEnabledOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SetDefaultMessageFeedbackEnabledInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.SetDefaultMessageFeedbackEnabled");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetDefaultMessageFeedbackEnabledOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SetDefaultMessageFeedbackEnabledOutput, body, allocator);
}
