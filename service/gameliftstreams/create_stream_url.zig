const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DisplayConfiguration = @import("display_configuration.zig").DisplayConfiguration;
const Protocol = @import("protocol.zig").Protocol;
const StreamUrlStatus = @import("stream_url_status.zig").StreamUrlStatus;
const StreamUrlStatusReason = @import("stream_url_status_reason.zig").StreamUrlStatusReason;

pub const CreateStreamUrlInput = struct {
    /// A set of options that you can use to control the stream session runtime
    /// environment, expressed as a set of key-value pairs. You can use this to
    /// configure the application or stream session details. You can also provide
    /// custom environment variables that Amazon GameLift Streams passes to your
    /// game client.
    ///
    /// If you want to debug your application with environment variables, we
    /// recommend that you do so in a local environment outside of Amazon GameLift
    /// Streams. For more information, refer to the Compatibility Guidance in the
    /// troubleshooting section of the Developer Guide.
    ///
    /// `AdditionalEnvironmentVariables` and `AdditionalLaunchArgs` have similar
    /// purposes. `AdditionalEnvironmentVariables` passes data using environment
    /// variables; while `AdditionalLaunchArgs` passes data using command-line
    /// arguments.
    additional_environment_variables: ?[]const aws.map.StringMapEntry = null,

    /// A list of CLI arguments that are sent to the streaming server when a stream
    /// session launches. You can use this to configure the application or stream
    /// session details. You can also provide custom arguments that Amazon GameLift
    /// Streams passes to your game client.
    ///
    /// `AdditionalEnvironmentVariables` and `AdditionalLaunchArgs` have similar
    /// purposes. `AdditionalEnvironmentVariables` passes data using environment
    /// variables; while `AdditionalLaunchArgs` passes data using command-line
    /// arguments.
    additional_launch_args: ?[]const []const u8 = null,

    /// An [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// or ID that uniquely identifies the application resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:application/a-9ZY8X7Wv6`.
    /// Example ID: `a-9ZY8X7Wv6`.
    ///
    /// This application must be associated with the stream group.
    application_identifier: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure this request
    /// is idempotent. If you retry a request with the same `ClientToken`, Amazon
    /// GameLift Streams returns the original response without performing the
    /// operation again.
    client_token: ?[]const u8 = null,

    /// A descriptive label for the stream URL.
    description: ?[]const u8 = null,

    /// The display settings, such as resolution, for stream sessions started from
    /// this stream URL.
    display_configuration: ?DisplayConfiguration = null,

    /// An [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// or ID that uniquely identifies the stream group resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:streamgroup/sg-1AB2C3De4`.
    /// Example ID: `sg-1AB2C3De4`.
    ///
    /// The stream session runs in this stream group.
    identifier: []const u8,

    /// A list of locations, in order of preference, where Amazon GameLift Streams
    /// can place the stream session. Specify each location by its Amazon Web
    /// Services Region code, for example `us-east-1`. For a complete list of
    /// locations that Amazon GameLift Streams supports, refer to [Regions, quotas,
    /// and
    /// limitations](https://docs.aws.amazon.com/gameliftstreams/latest/developerguide/regions-quotas.html) in the *Amazon GameLift Streams Developer Guide*.
    locations: []const []const u8,

    /// The data transport protocol for the stream session. Amazon GameLift Streams
    /// supports `WebRTC`.
    protocol: Protocol,

    /// The Amazon Resource Name (ARN) of the IAM role that Amazon GameLift Streams
    /// assumes during stream sessions started from this stream URL. For more
    /// information, see [Provide AWS credentials to your streaming
    /// application](https://docs.aws.amazon.com/gameliftstreams/latest/developerguide/session-credentials.html) in the *Amazon GameLift Streams Developer Guide*.
    role_arn: ?[]const u8 = null,

    /// The maximum length of time, in seconds, that a stream session started from
    /// this stream URL can run. Valid values are 1-86400 seconds (1 second to 24
    /// hours). The default is 43200 seconds (12 hours).
    session_length_seconds: ?i32 = null,

    /// The number of minutes after creation that the stream URL remains valid.
    /// After this period, the status of the stream URL changes to `EXPIRED` and it
    /// can no longer start stream sessions. The minimum is 1 minute. For the
    /// maximum, see [Regions, quotas, and
    /// limitations](https://docs.aws.amazon.com/gameliftstreams/latest/developerguide/regions-quotas.html) in the *Amazon GameLift Streams Developer Guide*.
    url_expires_after_minutes: i32,

    /// The maximum number of times the stream URL can start a stream session. Each
    /// successful use reduces the remaining uses by one. The minimum is 1, and the
    /// default is 1. For the maximum, see [Regions, quotas, and
    /// limitations](https://docs.aws.amazon.com/gameliftstreams/latest/developerguide/regions-quotas.html) in the *Amazon GameLift Streams Developer Guide*.
    usage_limit: ?i32 = null,

    pub const json_field_names = .{
        .additional_environment_variables = "AdditionalEnvironmentVariables",
        .additional_launch_args = "AdditionalLaunchArgs",
        .application_identifier = "ApplicationIdentifier",
        .client_token = "ClientToken",
        .description = "Description",
        .display_configuration = "DisplayConfiguration",
        .identifier = "Identifier",
        .locations = "Locations",
        .protocol = "Protocol",
        .role_arn = "RoleArn",
        .session_length_seconds = "SessionLengthSeconds",
        .url_expires_after_minutes = "UrlExpiresAfterMinutes",
        .usage_limit = "UsageLimit",
    };
};

pub const CreateStreamUrlOutput = struct {
    /// The environment variables made available to the application when a stream
    /// session starts.
    additional_environment_variables: ?[]const aws.map.StringMapEntry = null,

    /// The command-line arguments passed to the application when a stream session
    /// starts.
    additional_launch_args: ?[]const []const u8 = null,

    /// The application that runs in the stream sessions.
    ///
    /// This value is an [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// that uniquely identifies the application resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:application/a-9ZY8X7Wv6`.
    application_arn: ?[]const u8 = null,

    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// that uniquely identifies the stream URL across all Amazon Web Services
    /// Regions. Format is `arn:aws:gameliftstreams:[AWS Region]:[AWS
    /// account]:streamurl/[stream group resource ID]/[stream URL resource ID]`.
    arn: []const u8,

    /// A timestamp that indicates when this resource was created. Timestamps are
    /// expressed using in ISO8601 format, such as: `2022-12-27T22:29:40+00:00`
    /// (UTC).
    created_at: ?i64 = null,

    /// The descriptive label for the stream URL.
    description: ?[]const u8 = null,

    /// The display settings, such as resolution, for stream sessions started from
    /// this stream URL.
    display_configuration: ?DisplayConfiguration = null,

    /// The date and time when the stream URL expires and stops accepting new stream
    /// sessions. Timestamps are expressed using in ISO8601 format, such as:
    /// `2022-12-27T22:29:40+00:00` (UTC).
    expires_at: ?i64 = null,

    /// The list of locations, in order of preference, where Amazon GameLift Streams
    /// places the stream session. For a complete list of locations that Amazon
    /// GameLift Streams supports, refer to [Regions, quotas, and
    /// limitations](https://docs.aws.amazon.com/gameliftstreams/latest/developerguide/regions-quotas.html) in the *Amazon GameLift Streams Developer Guide*.
    locations: ?[]const []const u8 = null,

    /// The data transport protocol used for stream sessions started from this
    /// stream URL.
    protocol: ?Protocol = null,

    /// The number of times the stream URL can still be used to start a stream
    /// session.
    remaining_uses: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that Amazon GameLift Streams
    /// assumes during stream sessions started from this stream URL. For more
    /// information, see [Provide AWS credentials to your streaming
    /// application](https://docs.aws.amazon.com/gameliftstreams/latest/developerguide/session-credentials.html) in the *Amazon GameLift Streams Developer Guide*.
    role_arn: ?[]const u8 = null,

    /// The maximum length of time, in seconds, that a stream session started from
    /// this stream URL can run.
    session_length_seconds: ?i32 = null,

    /// The current status of the stream URL. Possible statuses include the
    /// following:
    ///
    /// * `ACTIVE`: The stream URL is valid and can start stream sessions.
    /// * `EXPIRED`: The stream URL has passed its expiration time and can no longer
    ///   start stream sessions.
    /// * `REVOKED`: The stream URL was revoked and can no longer start stream
    ///   sessions.
    /// * `LIMIT_REACHED`: The stream URL has been used the maximum number of times
    ///   and can no longer start stream sessions.
    status: ?StreamUrlStatus = null,

    /// Additional information about why the stream URL is in its current status.
    /// Amazon GameLift Streams populates this value when the status is `REVOKED`.
    /// Possible values include the following:
    ///
    /// * `userRevoked`: You revoked the stream URL.
    /// * `revokedAndTerminatingSessions`: You revoked the stream URL and Amazon
    ///   GameLift Streams is ending its running stream sessions.
    /// * `revokedAndSessionsTerminated`: You revoked the stream URL and its running
    ///   stream sessions have ended.
    /// * `streamGroupDeleted`: The stream group was deleted, which revoked the
    ///   stream URL.
    /// * `applicationDeleted`: The application was deleted, which revoked the
    ///   stream URL.
    status_reason: ?StreamUrlStatusReason = null,

    /// The stream group that runs the stream sessions.
    ///
    /// This value is an [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// that uniquely identifies the stream group resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:streamgroup/sg-1AB2C3De4`.
    stream_group_arn: ?[]const u8 = null,

    /// The shareable stream URL. Distribute this URL to end users so that they can
    /// start and play a stream session in a hosted web player. Treat the stream URL
    /// as a secret. Anyone who has it can start a stream session until the stream
    /// URL expires, is revoked, or reaches its usage limit.
    stream_url: ?[]const u8 = null,

    /// The unique identifier for the stream URL resource, for example
    /// `su-1AB2C3De4`.
    stream_url_id: ?[]const u8 = null,

    /// The maximum number of times the stream URL can start a stream session.
    usage_limit: ?i32 = null,

    pub const json_field_names = .{
        .additional_environment_variables = "AdditionalEnvironmentVariables",
        .additional_launch_args = "AdditionalLaunchArgs",
        .application_arn = "ApplicationArn",
        .arn = "Arn",
        .created_at = "CreatedAt",
        .description = "Description",
        .display_configuration = "DisplayConfiguration",
        .expires_at = "ExpiresAt",
        .locations = "Locations",
        .protocol = "Protocol",
        .remaining_uses = "RemainingUses",
        .role_arn = "RoleArn",
        .session_length_seconds = "SessionLengthSeconds",
        .status = "Status",
        .status_reason = "StatusReason",
        .stream_group_arn = "StreamGroupArn",
        .stream_url = "StreamUrl",
        .stream_url_id = "StreamUrlId",
        .usage_limit = "UsageLimit",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStreamUrlInput, options: CallOptions) !CreateStreamUrlOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gameliftstreams", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStreamUrlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gameliftstreams", "GameLiftStreams", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/streamgroups/");
    try path_buf.appendSlice(allocator, input.identifier);
    try path_buf.appendSlice(allocator, "/streamurls");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.additional_environment_variables) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AdditionalEnvironmentVariables\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.additional_launch_args) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AdditionalLaunchArgs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ApplicationIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.application_identifier), input.application_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.display_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DisplayConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Locations\":");
    try aws.json.writeValue(@TypeOf(input.locations), input.locations, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Protocol\":");
    try aws.json.writeValue(@TypeOf(input.protocol), input.protocol, allocator, &body_buf);
    has_prev = true;
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.session_length_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SessionLengthSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"UrlExpiresAfterMinutes\":");
    try aws.json.writeValue(@TypeOf(input.url_expires_after_minutes), input.url_expires_after_minutes, allocator, &body_buf);
    has_prev = true;
    if (input.usage_limit) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"UsageLimit\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStreamUrlOutput {
    const result: CreateStreamUrlOutput = try aws.json.parseJsonObject(
        CreateStreamUrlOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
