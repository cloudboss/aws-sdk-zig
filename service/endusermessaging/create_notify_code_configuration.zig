const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChannelParameters = @import("channel_parameters.zig").ChannelParameters;
const CodeConfigurationParameters = @import("code_configuration_parameters.zig").CodeConfigurationParameters;
const Tag = @import("tag.zig").Tag;
const NotifyCodeConfiguration = @import("notify_code_configuration.zig").NotifyCodeConfiguration;

pub const CreateNotifyCodeConfigurationInput = struct {
    /// The channel-specific parameters used to render and deliver the one-time
    /// passcode. Provide parameters for any subset of channels. Each member
    /// configures one delivery route, and the route that is selected at send time
    /// uses the matching channel.
    channel_parameters: ?ChannelParameters = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If you do not specify a client token, the AWS
    /// SDK automatically generates one.
    client_token: ?[]const u8 = null,

    /// The passcode policy parameters, including the code type, length, validity
    /// period, and maximum number of attempts. Each member is optional. When you
    /// omit a member, no value is applied at create time and the default is applied
    /// when a passcode is sent.
    code_configuration_parameters: ?CodeConfigurationParameters = null,

    /// Specifies whether deletion protection is enabled. When enabled, the resource
    /// cannot be deleted until deletion protection is turned off.
    deletion_protection_enabled: ?bool = null,

    /// The name of the notify code configuration.
    notify_code_configuration_name: []const u8,

    /// An array of key and value pair tags that are associated with the resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .channel_parameters = "channelParameters",
        .client_token = "clientToken",
        .code_configuration_parameters = "codeConfigurationParameters",
        .deletion_protection_enabled = "deletionProtectionEnabled",
        .notify_code_configuration_name = "notifyCodeConfigurationName",
        .tags = "tags",
    };
};

pub const CreateNotifyCodeConfigurationOutput = struct {
    /// The notify code configuration resource.
    notify_code_configuration: ?NotifyCodeConfiguration = null,

    pub const json_field_names = .{
        .notify_code_configuration = "notifyCodeConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateNotifyCodeConfigurationInput, options: CallOptions) !CreateNotifyCodeConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "end-user-messaging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateNotifyCodeConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("end-user-messaging", "EndUserMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/notify-code-configurations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.channel_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"channelParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.code_configuration_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"codeConfigurationParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.deletion_protection_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deletionProtectionEnabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"notifyCodeConfigurationName\":");
    try aws.json.writeValue(@TypeOf(input.notify_code_configuration_name), input.notify_code_configuration_name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateNotifyCodeConfigurationOutput {
    const result: CreateNotifyCodeConfigurationOutput = try aws.json.parseJsonObject(
        CreateNotifyCodeConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
