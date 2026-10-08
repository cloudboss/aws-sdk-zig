const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NotifyChannel = @import("notify_channel.zig").NotifyChannel;
const ChannelParameters = @import("channel_parameters.zig").ChannelParameters;
const CodeConfigurationParameters = @import("code_configuration_parameters.zig").CodeConfigurationParameters;

pub const SendNotifyCodeVerificationInput = struct {
    /// The channel used to deliver the one-time passcode to the recipient.
    channel: NotifyChannel,

    /// The name of the configuration set used to control how delivery events for
    /// the message are handled.
    configuration_set_name: ?[]const u8 = null,

    /// A map of custom key and value pairs that are propagated to the delivery
    /// events for this verification.
    context: ?[]const aws.map.StringMapEntry = null,

    /// The recipient identifier. For the TEXT and VOICE channels, specify an E.164
    /// phone number. For the WhatsApp channel, specify a WhatsApp address.
    destination_identity: []const u8,

    /// The identifier or Amazon Resource Name (ARN) of the notify code
    /// configuration that supplies the passcode policy and template defaults. When
    /// you do not specify a configuration, you must supply the template in the
    /// request.
    notify_code_configuration: ?[]const u8 = null,

    /// The identity used to send the message, such as a phone number, sender ID, or
    /// pool that is owned by your account.
    origination_identity: []const u8,

    /// The channel-specific parameters used to render and deliver the one-time
    /// passcode for this request. The route that is derived from the channel and
    /// the origination identity selects the matching channel. When you do not
    /// specify channel parameters, the service uses the parameters from the
    /// referenced notify code configuration.
    override_channel_parameters: ?ChannelParameters = null,

    /// The per-send overrides for the passcode policy parameters, including the
    /// code type, length, validity period, and maximum number of attempts. These
    /// values override the values from the referenced notify code configuration.
    /// When you do not specify a value, the value from the configuration is used,
    /// and if neither is set, the service default applies.
    override_code_configuration_parameters: ?CodeConfigurationParameters = null,

    /// A caller-supplied reference identifier that binds a send request to a later
    /// validate request. Specify the same value in both requests.
    reference_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel = "channel",
        .configuration_set_name = "configurationSetName",
        .context = "context",
        .destination_identity = "destinationIdentity",
        .notify_code_configuration = "notifyCodeConfiguration",
        .origination_identity = "originationIdentity",
        .override_channel_parameters = "overrideChannelParameters",
        .override_code_configuration_parameters = "overrideCodeConfigurationParameters",
        .reference_id = "referenceId",
    };
};

pub const SendNotifyCodeVerificationOutput = struct {
    /// The service-generated identifier for the message that delivers the one-time
    /// passcode.
    message_id: []const u8,

    /// The service-generated identifier for the verification.
    verification_id: []const u8,

    pub const json_field_names = .{
        .message_id = "messageId",
        .verification_id = "verificationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendNotifyCodeVerificationInput, options: CallOptions) !SendNotifyCodeVerificationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SendNotifyCodeVerificationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("end-user-messaging", "EndUserMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/notify-code-verifications/send";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"channel\":");
    try aws.json.writeValue(@TypeOf(input.channel), input.channel, allocator, &body_buf);
    has_prev = true;
    if (input.configuration_set_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"configurationSetName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.context) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"context\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"destinationIdentity\":");
    try aws.json.writeValue(@TypeOf(input.destination_identity), input.destination_identity, allocator, &body_buf);
    has_prev = true;
    if (input.notify_code_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"notifyCodeConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"originationIdentity\":");
    try aws.json.writeValue(@TypeOf(input.origination_identity), input.origination_identity, allocator, &body_buf);
    has_prev = true;
    if (input.override_channel_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"overrideChannelParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.override_code_configuration_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"overrideCodeConfigurationParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.reference_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"referenceId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendNotifyCodeVerificationOutput {
    const result: SendNotifyCodeVerificationOutput = try aws.json.parseJsonObject(
        SendNotifyCodeVerificationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
