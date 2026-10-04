const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DisplayConfiguration = @import("display_configuration.zig").DisplayConfiguration;
const Protocol = @import("protocol.zig").Protocol;
const StreamUrlStatus = @import("stream_url_status.zig").StreamUrlStatus;
const StreamUrlStatusReason = @import("stream_url_status_reason.zig").StreamUrlStatusReason;
const StreamSessionSummary = @import("stream_session_summary.zig").StreamSessionSummary;

pub const GetStreamUrlInput = struct {
    /// An [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// or ID that uniquely identifies the stream group resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:streamgroup/sg-1AB2C3De4`.
    /// Example ID: `sg-1AB2C3De4`.
    ///
    /// This is the stream group that owns the stream URL.
    identifier: []const u8,

    /// The unique identifier of the stream URL. Specify a stream URL ID or Amazon
    /// Resource Name (ARN). Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:streamurl/sg-1AB2C3De4/su-1AB2C3De4`. Example ID: `su-1AB2C3De4`.
    stream_url_identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .stream_url_identifier = "StreamUrlIdentifier",
    };
};

pub const GetStreamUrlOutput = struct {
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

    /// A list of the stream sessions that have been started through this stream
    /// URL.
    stream_sessions: ?[]const StreamSessionSummary = null,

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
        .stream_sessions = "StreamSessions",
        .stream_url = "StreamUrl",
        .stream_url_id = "StreamUrlId",
        .usage_limit = "UsageLimit",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetStreamUrlInput, options: CallOptions) !GetStreamUrlOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetStreamUrlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gameliftstreams", "GameLiftStreams", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/streamgroups/");
    try path_buf.appendSlice(allocator, input.identifier);
    try path_buf.appendSlice(allocator, "/streamurls/");
    try path_buf.appendSlice(allocator, input.stream_url_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetStreamUrlOutput {
    const result: GetStreamUrlOutput = try aws.json.parseJsonObject(
        GetStreamUrlOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
