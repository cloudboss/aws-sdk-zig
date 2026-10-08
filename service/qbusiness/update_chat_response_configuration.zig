const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResponseConfiguration = @import("response_configuration.zig").ResponseConfiguration;

pub const UpdateChatResponseConfigurationInput = struct {
    /// The unique identifier of the Amazon Q Business application containing the
    /// chat response configuration to update.
    application_id: []const u8,

    /// The unique identifier of the chat response configuration to update within
    /// the specified application.
    chat_response_configuration_id: []const u8,

    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    /// This helps prevent the same update from being processed multiple times if
    /// retries occur.
    client_token: ?[]const u8 = null,

    /// The new human-readable name to assign to the chat response configuration,
    /// making it easier to identify among multiple configurations.
    display_name: ?[]const u8 = null,

    /// The updated collection of response configuration settings that define how
    /// Amazon Q Business generates and formats responses to user queries.
    response_configurations: []const aws.map.MapEntry(ResponseConfiguration),

    pub const json_field_names = .{
        .application_id = "applicationId",
        .chat_response_configuration_id = "chatResponseConfigurationId",
        .client_token = "clientToken",
        .display_name = "displayName",
        .response_configurations = "responseConfigurations",
    };
};

pub const UpdateChatResponseConfigurationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateChatResponseConfigurationInput, options: CallOptions) !UpdateChatResponseConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateChatResponseConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/chatresponseconfigurations/");
    try path_buf.appendSlice(allocator, input.chat_response_configuration_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.display_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"displayName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"responseConfigurations\":");
    try aws.json.writeValue(@TypeOf(input.response_configurations), input.response_configurations, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateChatResponseConfigurationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateChatResponseConfigurationOutput = .{};

    return result;
}
