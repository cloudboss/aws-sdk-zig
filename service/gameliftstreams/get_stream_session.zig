const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ExportFilesMetadata = @import("export_files_metadata.zig").ExportFilesMetadata;
const PerformanceStatsConfiguration = @import("performance_stats_configuration.zig").PerformanceStatsConfiguration;
const Protocol = @import("protocol.zig").Protocol;
const StreamSessionStatus = @import("stream_session_status.zig").StreamSessionStatus;
const StreamSessionStatusReason = @import("stream_session_status_reason.zig").StreamSessionStatusReason;

pub const GetStreamSessionInput = struct {
    /// The stream group that runs this stream session.
    ///
    /// This value is an [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// or ID that uniquely identifies the stream group resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:streamgroup/sg-1AB2C3De4`.
    /// Example ID: `sg-1AB2C3De4`.
    identifier: []const u8,

    /// An [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// or ID that uniquely identifies the stream session resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:streamsession/sg-1AB2C3De4/ABC123def4567`. Example ID: `ABC123def4567`.
    stream_session_identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .stream_session_identifier = "StreamSessionIdentifier",
    };
};

pub const GetStreamSessionOutput = struct {
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

    /// The application streaming in this session.
    ///
    /// This value is an [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// that uniquely identifies the application resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:application/a-9ZY8X7Wv6`.
    application_arn: ?[]const u8 = null,

    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// that's assigned to a stream session resource. When combined with the stream
    /// group resource ID, this value uniquely identifies the stream session across
    /// all Amazon Web Services Regions. Format is `arn:aws:gameliftstreams:[AWS
    /// Region]:[AWS account]:streamsession/[stream group resource ID]/[stream
    /// session resource ID]`.
    arn: ?[]const u8 = null,

    /// The length of time that Amazon GameLift Streams should wait for a client to
    /// connect or reconnect to the stream session. This time span starts when the
    /// stream session reaches `ACTIVE` or `PENDING_CLIENT_RECONNECTION` state. If
    /// no client connects (or reconnects) before the timeout, Amazon GameLift
    /// Streams terminates the stream session.
    connection_timeout_seconds: ?i32 = null,

    /// A timestamp that indicates when this resource was created. Timestamps are
    /// expressed using in ISO8601 format, such as: `2022-12-27T22:29:40+00:00`
    /// (UTC).
    created_at: ?i64 = null,

    /// A human-readable label for the stream session. You can update this value at
    /// any time.
    description: ?[]const u8 = null,

    /// Provides details about the stream session's exported files.
    export_files_metadata: ?ExportFilesMetadata = null,

    /// A timestamp that indicates when this resource was last updated. Timestamps
    /// are expressed using in ISO8601 format, such as: `2022-12-27T22:29:40+00:00`
    /// (UTC).
    last_updated_at: ?i64 = null,

    /// The location where Amazon GameLift Streams hosts and streams your
    /// application. For example, `us-east-1`. For a complete list of locations that
    /// Amazon GameLift Streams supports, refer to [Regions, quotas, and
    /// limitations](https://docs.aws.amazon.com/gameliftstreams/latest/developerguide/regions-quotas.html) in the *Amazon GameLift Streams Developer Guide*.
    location: ?[]const u8 = null,

    /// Access location for log files that your content generates during a stream
    /// session. These log files are uploaded to cloud storage location at the end
    /// of a stream session. The Amazon GameLift Streams application resource
    /// defines which log files to upload.
    log_file_location_uri: ?[]const u8 = null,

    /// The performance stats configuration for the stream session
    performance_stats_configuration: ?PerformanceStatsConfiguration = null,

    /// The data transfer protocol in use with the stream session.
    protocol: ?Protocol = null,

    /// The maximum duration of a session. Amazon GameLift Streams will
    /// automatically terminate a session after this amount of time has elapsed,
    /// regardless of any existing client connections.
    session_length_seconds: ?i32 = null,

    /// The WebRTC ICE offer string that a client generates to initiate a connection
    /// to the stream session.
    signal_request: ?[]const u8 = null,

    /// The WebRTC answer string that the stream server generates in response to the
    /// `SignalRequest`.
    signal_response: ?[]const u8 = null,

    /// The current status of the stream session. A stream session is ready for a
    /// client to connect when in `ACTIVE` status.
    ///
    /// * `ACTIVATING`: The stream session is starting and preparing to stream.
    /// * `ACTIVE`: The stream session is ready and waiting for a client connection.
    ///   A client has `ConnectionTimeoutSeconds` (specified in
    ///   `StartStreamSession`) from when the session reaches `ACTIVE` state to
    ///   establish a connection. If no client connects within this timeframe, the
    ///   session automatically terminates.
    /// * `CONNECTED`: The stream session has a connected client. A session will
    ///   automatically terminate if there is no user input for 60 minutes, or if
    ///   the maximum length of a session specified by `SessionLengthSeconds` in
    ///   `StartStreamSession` is exceeded.
    /// * `ERROR`: The stream session failed to activate. See `StatusReason`
    ///   (returned by `GetStreamSession` and `StartStreamSession`) for more
    ///   information.
    /// * `PENDING_CLIENT_RECONNECTION`: A client has recently disconnected and the
    ///   stream session is waiting for the client to reconnect. A client has
    ///   `ConnectionTimeoutSeconds` (specified in `StartStreamSession`) from when
    ///   the session reaches `PENDING_CLIENT_RECONNECTION` state to re-establish a
    ///   connection. If no client connects within this timeframe, the session
    ///   automatically terminates.
    /// * `RECONNECTING`: A client has initiated a reconnect to a session that was
    ///   in `PENDING_CLIENT_RECONNECTION` state.
    /// * `TERMINATING`: The stream session is ending.
    /// * `TERMINATED`: The stream session has ended.
    status: ?StreamSessionStatus = null,

    /// A short description of the reason the stream session is in `ERROR` status or
    /// `TERMINATED` status.
    ///
    /// `ERROR` status reasons:
    ///
    /// * `applicationLogS3DestinationError`: Could not write the application log to
    ///   the Amazon S3 bucket that is configured for the streaming application.
    ///   Make sure the bucket still exists.
    /// * `internalError`: An internal service error occurred. Start a new stream
    ///   session to continue streaming.
    /// * `invalidSignalRequest`: The WebRTC signal request that was sent is not
    ///   valid. When starting or reconnecting to a stream session, use
    ///   `generateSignalRequest` in the Amazon GameLift Streams Web SDK to generate
    ///   a new signal request.
    /// * `placementTimeout`: Amazon GameLift Streams could not find available
    ///   stream capacity to start a stream session. Increase the stream capacity in
    ///   the stream group or wait until capacity becomes available.
    ///
    /// `TERMINATED` status reasons:
    ///
    /// * `apiTerminated`: The stream session was terminated by an API call to
    ///   [TerminateStreamSession](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_TerminateStreamSession.html).
    /// * `applicationExit`: The streaming application exited or crashed. The stream
    ///   session was terminated because the application is no longer running.
    /// * `connectionTimeout`: The stream session was terminated because the client
    ///   failed to connect within the connection timeout period specified by
    ///   `ConnectionTimeoutSeconds`.
    /// * `idleTimeout`: The stream session was terminated because it exceeded the
    ///   idle timeout period of 60 minutes with no user input activity.
    /// * `maxSessionLengthTimeout`: The stream session was terminated because it
    ///   exceeded the maximum session length timeout period specified by
    ///   `SessionLengthSeconds`.
    /// * `reconnectionTimeout`: The stream session was terminated because the
    ///   client failed to reconnect within the reconnection timeout period
    ///   specified by `ConnectionTimeoutSeconds` after losing connection.
    status_reason: ?StreamSessionStatusReason = null,

    /// The unique identifier for the Amazon GameLift Streams stream group that is
    /// hosting the stream session. Format example: `sg-1AB2C3De4`.
    stream_group_id: ?[]const u8 = null,

    /// An opaque, unique identifier for an end-user, defined by the developer.
    user_id: ?[]const u8 = null,

    /// The URL of an S3 bucket that stores Amazon GameLift Streams WebSDK files.
    /// The URL is used to establish connection with the client.
    web_sdk_protocol_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_environment_variables = "AdditionalEnvironmentVariables",
        .additional_launch_args = "AdditionalLaunchArgs",
        .application_arn = "ApplicationArn",
        .arn = "Arn",
        .connection_timeout_seconds = "ConnectionTimeoutSeconds",
        .created_at = "CreatedAt",
        .description = "Description",
        .export_files_metadata = "ExportFilesMetadata",
        .last_updated_at = "LastUpdatedAt",
        .location = "Location",
        .log_file_location_uri = "LogFileLocationUri",
        .performance_stats_configuration = "PerformanceStatsConfiguration",
        .protocol = "Protocol",
        .session_length_seconds = "SessionLengthSeconds",
        .signal_request = "SignalRequest",
        .signal_response = "SignalResponse",
        .status = "Status",
        .status_reason = "StatusReason",
        .stream_group_id = "StreamGroupId",
        .user_id = "UserId",
        .web_sdk_protocol_url = "WebSdkProtocolUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetStreamSessionInput, options: CallOptions) !GetStreamSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "gameliftstreams");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetStreamSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gameliftstreams", "GameLiftStreams", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/streamgroups/");
    try path_buf.appendSlice(allocator, input.identifier);
    try path_buf.appendSlice(allocator, "/streamsessions/");
    try path_buf.appendSlice(allocator, input.stream_session_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetStreamSessionOutput {
    var result: GetStreamSessionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetStreamSessionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
