const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AfterContactWorkConfigPerChannel = @import("after_contact_work_config_per_channel.zig").AfterContactWorkConfigPerChannel;
const AutoAcceptConfig = @import("auto_accept_config.zig").AutoAcceptConfig;
const PersistentConnectionConfig = @import("persistent_connection_config.zig").PersistentConnectionConfig;
const PhoneNumberConfig = @import("phone_number_config.zig").PhoneNumberConfig;
const VoiceEnhancementConfig = @import("voice_enhancement_config.zig").VoiceEnhancementConfig;

pub const UpdateUserConfigInput = struct {
    /// The list of after contact work (ACW) timeout configuration settings for each
    /// channel. ACW timeout specifies how many seconds agents have for after
    /// contact work, such as entering notes about the contact. The minimum setting
    /// is 1 second, and the maximum is 2,000,000 seconds (24 days). Enter 0 for an
    /// indefinite amount of time, meaning agents must manually choose to end ACW.
    after_contact_work_configs: ?[]const AfterContactWorkConfigPerChannel = null,

    /// The list of auto-accept configuration settings for each channel. When
    /// auto-accept is enabled for a channel, available agents are automatically
    /// connected to contacts from that channel without needing to manually accept.
    /// Auto-accept connects agents to contacts in less than one second.
    auto_accept_configs: ?[]const AutoAcceptConfig = null,

    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The list of persistent connection configuration settings for each channel.
    persistent_connection_configs: ?[]const PersistentConnectionConfig = null,

    /// The list of phone number configuration settings for each channel.
    phone_number_configs: ?[]const PhoneNumberConfig = null,

    /// The identifier of the user account.
    user_id: []const u8,

    /// The list of voice enhancement configuration settings for each channel.
    voice_enhancement_configs: ?[]const VoiceEnhancementConfig = null,

    pub const json_field_names = .{
        .after_contact_work_configs = "AfterContactWorkConfigs",
        .auto_accept_configs = "AutoAcceptConfigs",
        .instance_id = "InstanceId",
        .persistent_connection_configs = "PersistentConnectionConfigs",
        .phone_number_configs = "PhoneNumberConfigs",
        .user_id = "UserId",
        .voice_enhancement_configs = "VoiceEnhancementConfigs",
    };
};

pub const UpdateUserConfigOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateUserConfigInput, options: CallOptions) !UpdateUserConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateUserConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/users/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.user_id);
    try path_buf.appendSlice(allocator, "/config");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.after_contact_work_configs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AfterContactWorkConfigs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.auto_accept_configs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AutoAcceptConfigs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.persistent_connection_configs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PersistentConnectionConfigs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.phone_number_configs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PhoneNumberConfigs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.voice_enhancement_configs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"VoiceEnhancementConfigs\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateUserConfigOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateUserConfigOutput = .{};

    return result;
}
