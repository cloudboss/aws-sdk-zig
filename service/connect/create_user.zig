const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AfterContactWorkConfigPerChannel = @import("after_contact_work_config_per_channel.zig").AfterContactWorkConfigPerChannel;
const AutoAcceptConfig = @import("auto_accept_config.zig").AutoAcceptConfig;
const UserIdentityInfo = @import("user_identity_info.zig").UserIdentityInfo;
const PersistentConnectionConfig = @import("persistent_connection_config.zig").PersistentConnectionConfig;
const UserPhoneConfig = @import("user_phone_config.zig").UserPhoneConfig;
const PhoneNumberConfig = @import("phone_number_config.zig").PhoneNumberConfig;
const VoiceEnhancementConfig = @import("voice_enhancement_config.zig").VoiceEnhancementConfig;

pub const CreateUserInput = struct {
    /// The list of after contact work (ACW) timeout configuration settings for each
    /// channel.
    after_contact_work_configs: ?[]const AfterContactWorkConfigPerChannel = null,

    /// The list of auto-accept configuration settings for each channel.
    auto_accept_configs: ?[]const AutoAcceptConfig = null,

    /// The identifier of the user account in the directory used for identity
    /// management. If Amazon Connect cannot
    /// access the directory, you can specify this identifier to authenticate users.
    /// If you include the identifier, we assume
    /// that Amazon Connect cannot access the directory. Otherwise, the identity
    /// information is used to authenticate
    /// users from your directory.
    ///
    /// This parameter is required if you are using an existing directory for
    /// identity management in Amazon Connect
    /// when Amazon Connect cannot access your directory to authenticate users. If
    /// you are using SAML for identity
    /// management and include this parameter, an error is returned.
    directory_user_id: ?[]const u8 = null,

    /// The identifier of the hierarchy group for the user.
    hierarchy_group_id: ?[]const u8 = null,

    /// The information about the identity of the user.
    identity_info: ?UserIdentityInfo = null,

    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The password for the user account. A password is required if you are using
    /// Amazon Connect for identity
    /// management. Otherwise, it is an error to include a password.
    password: ?[]const u8 = null,

    /// The list of persistent connection configuration settings for each channel.
    persistent_connection_configs: ?[]const PersistentConnectionConfig = null,

    /// The phone settings for the user. This parameter is optional. If not
    /// provided, the user can be configured using channel-specific parameters such
    /// as `AutoAcceptConfigs`, `AfterContactWorkConfigs`, `PhoneNumberConfigs`,
    /// `PersistentConnectionConfigs`, and `VoiceEnhancementConfigs`.
    phone_config: ?UserPhoneConfig = null,

    /// The list of phone number configuration settings for each channel.
    phone_number_configs: ?[]const PhoneNumberConfig = null,

    /// The identifier of the routing profile for the user.
    routing_profile_id: []const u8,

    /// The identifier of the security profile for the user.
    security_profile_ids: []const []const u8,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The user name for the account. For instances not using SAML for identity
    /// management, the user name can include
    /// up to 20 characters. If you are using SAML for identity management, the user
    /// name can include up to 64 characters
    /// from [a-zA-Z0-9_-.\@]+.
    ///
    /// Username can include @ only if used in an email format. For example:
    ///
    /// * Correct: testuser
    ///
    /// * Correct: testuser@example.com
    ///
    /// * Incorrect: testuser@example
    username: []const u8,

    /// The list of voice enhancement configuration settings for each channel.
    voice_enhancement_configs: ?[]const VoiceEnhancementConfig = null,

    pub const json_field_names = .{
        .after_contact_work_configs = "AfterContactWorkConfigs",
        .auto_accept_configs = "AutoAcceptConfigs",
        .directory_user_id = "DirectoryUserId",
        .hierarchy_group_id = "HierarchyGroupId",
        .identity_info = "IdentityInfo",
        .instance_id = "InstanceId",
        .password = "Password",
        .persistent_connection_configs = "PersistentConnectionConfigs",
        .phone_config = "PhoneConfig",
        .phone_number_configs = "PhoneNumberConfigs",
        .routing_profile_id = "RoutingProfileId",
        .security_profile_ids = "SecurityProfileIds",
        .tags = "Tags",
        .username = "Username",
        .voice_enhancement_configs = "VoiceEnhancementConfigs",
    };
};

pub const CreateUserOutput = struct {
    /// The Amazon Resource Name (ARN) of the user account.
    user_arn: ?[]const u8 = null,

    /// The identifier of the user account.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .user_arn = "UserArn",
        .user_id = "UserId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateUserInput, options: CallOptions) !CreateUserOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/users/");
    try path_buf.appendSlice(allocator, input.instance_id);
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
    if (input.directory_user_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DirectoryUserId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.hierarchy_group_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"HierarchyGroupId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.identity_info) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IdentityInfo\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.password) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Password\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.persistent_connection_configs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PersistentConnectionConfigs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.phone_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PhoneConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.phone_number_configs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PhoneNumberConfigs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RoutingProfileId\":");
    try aws.json.writeValue(@TypeOf(input.routing_profile_id), input.routing_profile_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SecurityProfileIds\":");
    try aws.json.writeValue(@TypeOf(input.security_profile_ids), input.security_profile_ids, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Username\":");
    try aws.json.writeValue(@TypeOf(input.username), input.username, allocator, &body_buf);
    has_prev = true;
    if (input.voice_enhancement_configs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"VoiceEnhancementConfigs\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateUserOutput {
    var result: CreateUserOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateUserOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
