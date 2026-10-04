const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChatResponseConfigurationDetail = @import("chat_response_configuration_detail.zig").ChatResponseConfigurationDetail;

pub const GetChatResponseConfigurationInput = struct {
    /// The unique identifier of the Amazon Q Business application containing the
    /// chat response configuration to retrieve.
    application_id: []const u8,

    /// The unique identifier of the chat response configuration to retrieve from
    /// the specified application.
    chat_response_configuration_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .chat_response_configuration_id = "chatResponseConfigurationId",
    };
};

pub const GetChatResponseConfigurationOutput = struct {
    /// The Amazon Resource Name (ARN) of the retrieved chat response configuration,
    /// which uniquely identifies the resource across all Amazon Web Services
    /// services.
    chat_response_configuration_arn: ?[]const u8 = null,

    /// The unique identifier of the retrieved chat response configuration.
    chat_response_configuration_id: ?[]const u8 = null,

    /// The timestamp indicating when the chat response configuration was initially
    /// created.
    created_at: ?i64 = null,

    /// The human-readable name of the retrieved chat response configuration, making
    /// it easier to identify among multiple configurations.
    display_name: ?[]const u8 = null,

    /// The currently active configuration settings that are being used to generate
    /// responses in the Amazon Q Business application.
    in_use_configuration: ?ChatResponseConfigurationDetail = null,

    /// Information about the most recent update to the configuration, including
    /// timestamp and modification details.
    last_update_configuration: ?ChatResponseConfigurationDetail = null,

    pub const json_field_names = .{
        .chat_response_configuration_arn = "chatResponseConfigurationArn",
        .chat_response_configuration_id = "chatResponseConfigurationId",
        .created_at = "createdAt",
        .display_name = "displayName",
        .in_use_configuration = "inUseConfiguration",
        .last_update_configuration = "lastUpdateConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetChatResponseConfigurationInput, options: CallOptions) !GetChatResponseConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetChatResponseConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/chatresponseconfigurations/");
    try path_buf.appendSlice(allocator, input.chat_response_configuration_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetChatResponseConfigurationOutput {
    const result: GetChatResponseConfigurationOutput = try aws.json.parseJsonObject(
        GetChatResponseConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
