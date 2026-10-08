const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateChannelParameters = @import("update_channel_parameters.zig").UpdateChannelParameters;
const UpdateCodeConfigurationParameters = @import("update_code_configuration_parameters.zig").UpdateCodeConfigurationParameters;
const NotifyCodeConfiguration = @import("notify_code_configuration.zig").NotifyCodeConfiguration;

pub const UpdateNotifyCodeConfigurationInput = struct {
    /// The updated channel-specific parameters used to render and deliver the
    /// one-time passcode. This is a loose, nested update: when you omit a channel,
    /// that channel's parameters remain unchanged. Within a supplied channel, an
    /// empty string on a string member, or an empty map on the destination-country
    /// parameters, clears the currently stored value, and absent members preserve
    /// the current value.
    channel_parameters: ?UpdateChannelParameters = null,

    /// The updated passcode policy parameters, including the code type, length,
    /// validity period, and maximum number of attempts. When you omit a member, its
    /// current value is preserved.
    code_configuration_parameters: ?UpdateCodeConfigurationParameters = null,

    /// Specifies whether deletion protection is enabled. When enabled, the resource
    /// cannot be deleted until deletion protection is turned off.
    deletion_protection_enabled: ?bool = null,

    /// The unique identifier of the notify code configuration. You can specify
    /// either the bare ID or the full Amazon Resource Name (ARN).
    notify_code_configuration_id: []const u8,

    /// The name of the notify code configuration.
    notify_code_configuration_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_parameters = "channelParameters",
        .code_configuration_parameters = "codeConfigurationParameters",
        .deletion_protection_enabled = "deletionProtectionEnabled",
        .notify_code_configuration_id = "notifyCodeConfigurationId",
        .notify_code_configuration_name = "notifyCodeConfigurationName",
    };
};

pub const UpdateNotifyCodeConfigurationOutput = struct {
    /// The notify code configuration resource.
    notify_code_configuration: ?NotifyCodeConfiguration = null,

    pub const json_field_names = .{
        .notify_code_configuration = "notifyCodeConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateNotifyCodeConfigurationInput, options: CallOptions) !UpdateNotifyCodeConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateNotifyCodeConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("end-user-messaging", "EndUserMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/notify-code-configurations/");
    try path_buf.appendSlice(allocator, input.notify_code_configuration_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.channel_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"channelParameters\":");
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
    if (input.notify_code_configuration_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"notifyCodeConfigurationName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateNotifyCodeConfigurationOutput {
    const result: UpdateNotifyCodeConfigurationOutput = try aws.json.parseJsonObject(
        UpdateNotifyCodeConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
