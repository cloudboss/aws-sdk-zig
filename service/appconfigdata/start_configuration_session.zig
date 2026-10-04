const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartConfigurationSessionInput = struct {
    /// The application ID or the application name.
    application_identifier: []const u8,

    /// The configuration profile ID or the configuration profile name.
    configuration_profile_identifier: []const u8,

    /// The environment ID or the environment name.
    environment_identifier: []const u8,

    /// Sets a constraint on a session. If you specify a value of, for example, 60
    /// seconds, then
    /// the client that established the session can't call GetLatestConfiguration
    /// more frequently than every 60 seconds.
    required_minimum_poll_interval_in_seconds: ?i32 = null,

    pub const json_field_names = .{
        .application_identifier = "ApplicationIdentifier",
        .configuration_profile_identifier = "ConfigurationProfileIdentifier",
        .environment_identifier = "EnvironmentIdentifier",
        .required_minimum_poll_interval_in_seconds = "RequiredMinimumPollIntervalInSeconds",
    };
};

pub const StartConfigurationSessionOutput = struct {
    /// Token encapsulating state about the configuration session. Provide this
    /// token to the
    /// `GetLatestConfiguration` API to retrieve configuration data.
    ///
    /// This token should only be used once in your first call to
    /// `GetLatestConfiguration`. You *must* use the new token
    /// in the `GetLatestConfiguration` response
    /// (`NextPollConfigurationToken`) in each subsequent call to
    /// `GetLatestConfiguration`.
    ///
    /// The `InitialConfigurationToken` and
    /// `NextPollConfigurationToken` should only be used once. To support long poll
    /// use cases, the tokens are valid for up to 24 hours. If a
    /// `GetLatestConfiguration` call uses an expired token, the system returns
    /// `BadRequestException`.
    initial_configuration_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .initial_configuration_token = "InitialConfigurationToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartConfigurationSessionInput, options: CallOptions) !StartConfigurationSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appconfigdata", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartConfigurationSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appconfigdata", "AppConfigData", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/configurationsessions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ApplicationIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.application_identifier), input.application_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ConfigurationProfileIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.configuration_profile_identifier), input.configuration_profile_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EnvironmentIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.environment_identifier), input.environment_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.required_minimum_poll_interval_in_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RequiredMinimumPollIntervalInSeconds\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartConfigurationSessionOutput {
    var result: StartConfigurationSessionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartConfigurationSessionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
