const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DASHFragmentSelector = @import("dash_fragment_selector.zig").DASHFragmentSelector;
const DASHDisplayFragmentNumber = @import("dash_display_fragment_number.zig").DASHDisplayFragmentNumber;
const DASHDisplayFragmentTimestamp = @import("dash_display_fragment_timestamp.zig").DASHDisplayFragmentTimestamp;
const DASHPlaybackMode = @import("dash_playback_mode.zig").DASHPlaybackMode;

pub const GetDASHStreamingSessionURLInput = struct {
    /// The time range of the requested fragment and the source of the timestamps.
    ///
    /// This parameter is required if `PlaybackMode` is `ON_DEMAND` or
    /// `LIVE_REPLAY`. This parameter is optional if PlaybackMode is``
    /// `LIVE`. If `PlaybackMode` is `LIVE`, the
    /// `FragmentSelectorType` can be set, but the `TimestampRange`
    /// should not be set. If `PlaybackMode` is `ON_DEMAND` or
    /// `LIVE_REPLAY`, both `FragmentSelectorType` and
    /// `TimestampRange` must be set.
    dash_fragment_selector: ?DASHFragmentSelector = null,

    /// Fragments are identified in the manifest file based on their sequence number
    /// in the
    /// session. If DisplayFragmentNumber is set to `ALWAYS`, the Kinesis Video
    /// Streams fragment number is added to each S element in the manifest file with
    /// the
    /// attribute name “kvs:fn”. These fragment numbers can be used for logging or
    /// for use with
    /// other APIs (e.g. `GetMedia` and `GetMediaForFragmentList`). A
    /// custom MPEG-DASH media player is necessary to leverage these this custom
    /// attribute.
    ///
    /// The default value is `NEVER`.
    display_fragment_number: ?DASHDisplayFragmentNumber = null,

    /// Per the MPEG-DASH specification, the wall-clock time of fragments in the
    /// manifest file
    /// can be derived using attributes in the manifest itself. However, typically,
    /// MPEG-DASH
    /// compatible media players do not properly handle gaps in the media timeline.
    /// Kinesis
    /// Video Streams adjusts the media timeline in the manifest file to enable
    /// playback of
    /// media with discontinuities. Therefore, the wall-clock time derived from the
    /// manifest
    /// file may be inaccurate. If DisplayFragmentTimestamp is set to `ALWAYS`, the
    /// accurate fragment timestamp is added to each S element in the manifest file
    /// with the
    /// attribute name “kvs:ts”. A custom MPEG-DASH media player is necessary to
    /// leverage this
    /// custom attribute.
    ///
    /// The default value is `NEVER`. When DASHFragmentSelector
    /// is `SERVER_TIMESTAMP`, the timestamps will be the server start timestamps.
    /// Similarly, when DASHFragmentSelector is
    /// `PRODUCER_TIMESTAMP`, the timestamps will be the producer start
    /// timestamps.
    display_fragment_timestamp: ?DASHDisplayFragmentTimestamp = null,

    /// The time in seconds until the requested session expires. This value can be
    /// between 300
    /// (5 minutes) and 43200 (12 hours).
    ///
    /// When a session expires, no new calls to `GetDashManifest`,
    /// `GetMP4InitFragment`, or `GetMP4MediaFragment` can be made for
    /// that session.
    ///
    /// The default is 300 (5 minutes).
    expires: ?i32 = null,

    /// The maximum number of fragments that are returned in the MPEG-DASH manifest.
    ///
    /// When the `PlaybackMode` is `LIVE`, the most recent fragments are
    /// returned up to this value. When the `PlaybackMode` is `ON_DEMAND`,
    /// the oldest fragments are returned, up to this maximum number.
    ///
    /// When there are a higher number of fragments available in a live MPEG-DASH
    /// manifest,
    /// video players often buffer content before starting playback. Increasing the
    /// buffer size
    /// increases the playback latency, but it decreases the likelihood that
    /// rebuffering will
    /// occur during playback. We recommend that a live MPEG-DASH manifest have a
    /// minimum of 3
    /// fragments and a maximum of 10 fragments.
    ///
    /// The default is 5 fragments if `PlaybackMode` is `LIVE` or
    /// `LIVE_REPLAY`, and 1,000 if `PlaybackMode` is
    /// `ON_DEMAND`.
    ///
    /// The maximum value of 1,000 fragments corresponds to more than 16 minutes of
    /// video on
    /// streams with 1-second fragments, and more than 2 1/2 hours of video on
    /// streams with
    /// 10-second fragments.
    max_manifest_fragment_results: ?i64 = null,

    /// Whether to retrieve live, live replay, or archived, on-demand data.
    ///
    /// Features of the three types of sessions include the following:
    ///
    /// * **
    /// `LIVE`
    /// **: For sessions of this type, the MPEG-DASH manifest is continually
    /// updated with the latest fragments as they become available. We recommend
    /// that
    /// the media player retrieve a new manifest on a one-second interval. When this
    /// type of session is played in a media player, the user interface typically
    /// displays a "live" notification, with no scrubber control for choosing the
    /// position in the playback window to display.
    ///
    /// In `LIVE` mode, the newest available fragments are included in
    /// an MPEG-DASH manifest, even if there is a gap between fragments (that is, if
    /// a fragment is missing). A gap like this might cause a media player to halt
    /// or cause a jump in playback. In this mode, fragments are not added to the
    /// MPEG-DASH manifest if they are older than the newest fragment in the
    /// playlist. If the missing fragment becomes available after a subsequent
    /// fragment is added to the manifest, the older fragment is not added, and the
    /// gap is not filled.
    ///
    /// * **
    /// `LIVE_REPLAY`
    /// **: For sessions of this type, the MPEG-DASH manifest is updated
    /// similarly to how it is updated for `LIVE` mode except that it starts
    /// by including fragments from a given start time. Instead of fragments being
    /// added
    /// as they are ingested, fragments are added as the duration of the next
    /// fragment
    /// elapses. For example, if the fragments in the session are two seconds long,
    /// then
    /// a new fragment is added to the manifest every two seconds. This mode is
    /// useful
    /// to be able to start playback from when an event is detected and continue
    /// live
    /// streaming media that has not yet been ingested as of the time of the session
    /// creation. This mode is also useful to stream previously archived media
    /// without
    /// being limited by the 1,000 fragment limit in the `ON_DEMAND` mode.
    ///
    /// * **
    /// `ON_DEMAND`
    /// **: For sessions of this type, the MPEG-DASH manifest contains all the
    /// fragments for the session, up to the number that is specified in
    /// `MaxManifestFragmentResults`. The manifest must be retrieved only
    /// once for each session. When this type of session is played in a media
    /// player,
    /// the user interface typically displays a scrubber control for choosing the
    /// position in the playback window to display.
    ///
    /// In all playback modes, if `FragmentSelectorType` is
    /// `PRODUCER_TIMESTAMP`, and if there are multiple fragments with the same
    /// start timestamp, the fragment that has the larger fragment number (that is,
    /// the newer
    /// fragment) is included in the MPEG-DASH manifest. The other fragments are not
    /// included.
    /// Fragments that have different timestamps but have overlapping durations are
    /// still
    /// included in the MPEG-DASH manifest. This can lead to unexpected behavior in
    /// the media
    /// player.
    ///
    /// The default is `LIVE`.
    playback_mode: ?DASHPlaybackMode = null,

    /// The Amazon Resource Name (ARN) of the stream for which to retrieve the
    /// MPEG-DASH
    /// manifest URL.
    ///
    /// You must specify either the `StreamName` or the
    /// `StreamARN`.
    stream_arn: ?[]const u8 = null,

    /// The name of the stream for which to retrieve the MPEG-DASH manifest URL.
    ///
    /// You must specify either the `StreamName` or the
    /// `StreamARN`.
    stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .dash_fragment_selector = "DASHFragmentSelector",
        .display_fragment_number = "DisplayFragmentNumber",
        .display_fragment_timestamp = "DisplayFragmentTimestamp",
        .expires = "Expires",
        .max_manifest_fragment_results = "MaxManifestFragmentResults",
        .playback_mode = "PlaybackMode",
        .stream_arn = "StreamARN",
        .stream_name = "StreamName",
    };
};

pub const GetDASHStreamingSessionURLOutput = struct {
    /// The URL (containing the session token) that a media player can use to
    /// retrieve the
    /// MPEG-DASH manifest.
    dash_streaming_session_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .dash_streaming_session_url = "DASHStreamingSessionURL",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDASHStreamingSessionURLInput, options: CallOptions) !GetDASHStreamingSessionURLOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "kinesisvideo");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDASHStreamingSessionURLInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisvideo", "Kinesis Video Archived Media", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/getDASHStreamingSessionURL";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.dash_fragment_selector) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DASHFragmentSelector\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.display_fragment_number) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DisplayFragmentNumber\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.display_fragment_timestamp) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DisplayFragmentTimestamp\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.expires) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Expires\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_manifest_fragment_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxManifestFragmentResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.playback_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PlaybackMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.stream_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StreamARN\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.stream_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StreamName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDASHStreamingSessionURLOutput {
    var result: GetDASHStreamingSessionURLOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDASHStreamingSessionURLOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ClientLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .client_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidArgumentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_argument_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCodecPrivateDataException")) {
        return .{ .arena = arena, .kind = .{ .invalid_codec_private_data_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidMediaFrameException")) {
        return .{ .arena = arena, .kind = .{ .invalid_media_frame_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingCodecPrivateDataException")) {
        return .{ .arena = arena, .kind = .{ .missing_codec_private_data_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoDataRetentionException")) {
        return .{ .arena = arena, .kind = .{ .no_data_retention_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotAuthorizedException")) {
        return .{ .arena = arena, .kind = .{ .not_authorized_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnsupportedStreamMediaTypeException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_stream_media_type_exception = .{
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
