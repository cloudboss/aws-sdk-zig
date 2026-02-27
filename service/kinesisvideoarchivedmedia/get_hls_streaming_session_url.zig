const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ContainerFormat = @import("container_format.zig").ContainerFormat;
const HLSDiscontinuityMode = @import("hls_discontinuity_mode.zig").HLSDiscontinuityMode;
const HLSDisplayFragmentTimestamp = @import("hls_display_fragment_timestamp.zig").HLSDisplayFragmentTimestamp;
const HLSFragmentSelector = @import("hls_fragment_selector.zig").HLSFragmentSelector;
const HLSPlaybackMode = @import("hls_playback_mode.zig").HLSPlaybackMode;

pub const GetHLSStreamingSessionURLInput = struct {
    /// Specifies which format should be used for packaging the media. Specifying
    /// the
    /// `FRAGMENTED_MP4` container format packages the media into MP4 fragments
    /// (fMP4 or CMAF). This is the recommended packaging because there is minimal
    /// packaging
    /// overhead. The other container format option is `MPEG_TS`. HLS has supported
    /// MPEG TS chunks since it was released and is sometimes the only supported
    /// packaging on
    /// older HLS players. MPEG TS typically has a 5-25 percent packaging overhead.
    /// This means
    /// MPEG TS typically requires 5-25 percent more bandwidth and cost than fMP4.
    ///
    /// The default is `FRAGMENTED_MP4`.
    container_format: ?ContainerFormat = null,

    /// Specifies when flags marking discontinuities between fragments are added to
    /// the media
    /// playlists.
    ///
    /// Media players typically build a timeline of media content to play, based on
    /// the
    /// timestamps of each fragment. This means that if there is any overlap or gap
    /// between
    /// fragments (as is typical if HLSFragmentSelector is set to
    /// `SERVER_TIMESTAMP`), the media player timeline will also have small gaps
    /// between fragments in some places, and will overwrite frames in other places.
    /// Gaps in the
    /// media player timeline can cause playback to stall and overlaps can cause
    /// playback to be
    /// jittery. When there are discontinuity flags between fragments, the media
    /// player is
    /// expected to reset the timeline, resulting in the next fragment being played
    /// immediately
    /// after the previous fragment.
    ///
    /// The following modes are supported:
    ///
    /// * `ALWAYS`: a discontinuity marker is placed between every fragment in
    /// the HLS media playlist. It is recommended to use a value of `ALWAYS`
    /// if the fragment timestamps are not accurate.
    ///
    /// * `NEVER`: no discontinuity markers are placed anywhere. It is
    /// recommended to use a value of `NEVER` to ensure the media player
    /// timeline most accurately maps to the producer timestamps.
    ///
    /// * `ON_DISCONTINUITY`: a discontinuity marker is placed between
    /// fragments that have a gap or overlap of more than 50 milliseconds. For most
    /// playback scenarios, it is recommended to use a value of
    /// `ON_DISCONTINUITY` so that the media player timeline is only
    /// reset when there is a significant issue with the media timeline (e.g. a
    /// missing
    /// fragment).
    ///
    /// The default is `ALWAYS` when HLSFragmentSelector is set
    /// to `SERVER_TIMESTAMP`, and `NEVER` when it is set to
    /// `PRODUCER_TIMESTAMP`.
    discontinuity_mode: ?HLSDiscontinuityMode = null,

    /// Specifies when the fragment start timestamps should be included in the HLS
    /// media
    /// playlist. Typically, media players report the playhead position as a time
    /// relative to
    /// the start of the first fragment in the playback session. However, when the
    /// start
    /// timestamps are included in the HLS media playlist, some media players might
    /// report the
    /// current playhead as an absolute time based on the fragment timestamps. This
    /// can be
    /// useful for creating a playback experience that shows viewers the wall-clock
    /// time of the
    /// media.
    ///
    /// The default is `NEVER`. When HLSFragmentSelector is
    /// `SERVER_TIMESTAMP`, the timestamps will be the server start timestamps.
    /// Similarly, when HLSFragmentSelector is
    /// `PRODUCER_TIMESTAMP`, the timestamps will be the producer start timestamps.
    display_fragment_timestamp: ?HLSDisplayFragmentTimestamp = null,

    /// The time in seconds until the requested session expires. This value can be
    /// between 300
    /// (5 minutes) and 43200 (12 hours).
    ///
    /// When a session expires, no new calls to `GetHLSMasterPlaylist`,
    /// `GetHLSMediaPlaylist`, `GetMP4InitFragment`,
    /// `GetMP4MediaFragment`, or `GetTSFragment` can be made for that
    /// session.
    ///
    /// The default is 300 (5 minutes).
    expires: ?i32 = null,

    /// The time range of the requested fragment and the source of the timestamps.
    ///
    /// This parameter is required if `PlaybackMode` is `ON_DEMAND` or
    /// `LIVE_REPLAY`. This parameter is optional if PlaybackMode is``
    /// `LIVE`. If `PlaybackMode` is `LIVE`, the
    /// `FragmentSelectorType` can be set, but the `TimestampRange`
    /// should not be set. If `PlaybackMode` is `ON_DEMAND` or
    /// `LIVE_REPLAY`, both `FragmentSelectorType` and
    /// `TimestampRange` must be set.
    hls_fragment_selector: ?HLSFragmentSelector = null,

    /// The maximum number of fragments that are returned in the HLS media
    /// playlists.
    ///
    /// When the `PlaybackMode` is `LIVE`, the most recent fragments are
    /// returned up to this value. When the `PlaybackMode` is `ON_DEMAND`,
    /// the oldest fragments are returned, up to this maximum number.
    ///
    /// When there are a higher number of fragments available in a live HLS media
    /// playlist,
    /// video players often buffer content before starting playback. Increasing the
    /// buffer size
    /// increases the playback latency, but it decreases the likelihood that
    /// rebuffering will
    /// occur during playback. We recommend that a live HLS media playlist have a
    /// minimum of 3
    /// fragments and a maximum of 10 fragments.
    ///
    /// The default is 5 fragments if `PlaybackMode` is `LIVE` or
    /// `LIVE_REPLAY`, and 1,000 if `PlaybackMode` is
    /// `ON_DEMAND`.
    ///
    /// The maximum value of 5,000 fragments corresponds to more than 80 minutes of
    /// video on
    /// streams with 1-second fragments, and more than 13 hours of video on streams
    /// with
    /// 10-second fragments.
    max_media_playlist_fragment_results: ?i64 = null,

    /// Whether to retrieve live, live replay, or archived, on-demand data.
    ///
    /// Features of the three types of sessions include the following:
    ///
    /// * **
    /// `LIVE`
    /// **: For sessions of this type, the HLS media playlist is continually
    /// updated with the latest fragments as they become available. We recommend
    /// that
    /// the media player retrieve a new playlist on a one-second interval. When this
    /// type of session is played in a media player, the user interface typically
    /// displays a "live" notification, with no scrubber control for choosing the
    /// position in the playback window to display.
    ///
    /// In `LIVE` mode, the newest available fragments are included in
    /// an HLS media playlist, even if there is a gap between fragments (that is, if
    /// a fragment is missing). A gap like this might cause a media player to halt
    /// or cause a jump in playback. In this mode, fragments are not added to the
    /// HLS media playlist if they are older than the newest fragment in the
    /// playlist. If the missing fragment becomes available after a subsequent
    /// fragment is added to the playlist, the older fragment is not added, and the
    /// gap is not filled.
    ///
    /// * **
    /// `LIVE_REPLAY`
    /// **: For sessions of this type, the HLS media playlist is updated
    /// similarly to how it is updated for `LIVE` mode except that it starts
    /// by including fragments from a given start time. Instead of fragments being
    /// added
    /// as they are ingested, fragments are added as the duration of the next
    /// fragment
    /// elapses. For example, if the fragments in the session are two seconds long,
    /// then
    /// a new fragment is added to the media playlist every two seconds. This mode
    /// is
    /// useful to be able to start playback from when an event is detected and
    /// continue
    /// live streaming media that has not yet been ingested as of the time of the
    /// session creation. This mode is also useful to stream previously archived
    /// media
    /// without being limited by the 1,000 fragment limit in the `ON_DEMAND`
    /// mode.
    ///
    /// * **
    /// `ON_DEMAND`
    /// **: For sessions of this type, the HLS media playlist contains all the
    /// fragments for the session, up to the number that is specified in
    /// `MaxMediaPlaylistFragmentResults`. The playlist must be retrieved
    /// only once for each session. When this type of session is played in a media
    /// player, the user interface typically displays a scrubber control for
    /// choosing
    /// the position in the playback window to display.
    ///
    /// In all playback modes, if `FragmentSelectorType` is
    /// `PRODUCER_TIMESTAMP`, and if there are multiple fragments with the same
    /// start timestamp, the fragment that has the largest fragment number (that is,
    /// the newest
    /// fragment) is included in the HLS media playlist. The other fragments are not
    /// included.
    /// Fragments that have different timestamps but have overlapping durations are
    /// still
    /// included in the HLS media playlist. This can lead to unexpected behavior in
    /// the media
    /// player.
    ///
    /// The default is `LIVE`.
    playback_mode: ?HLSPlaybackMode = null,

    /// The Amazon Resource Name (ARN) of the stream for which to retrieve the HLS
    /// master
    /// playlist URL.
    ///
    /// You must specify either the `StreamName` or the
    /// `StreamARN`.
    stream_arn: ?[]const u8 = null,

    /// The name of the stream for which to retrieve the HLS master playlist URL.
    ///
    /// You must specify either the `StreamName` or the
    /// `StreamARN`.
    stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .container_format = "ContainerFormat",
        .discontinuity_mode = "DiscontinuityMode",
        .display_fragment_timestamp = "DisplayFragmentTimestamp",
        .expires = "Expires",
        .hls_fragment_selector = "HLSFragmentSelector",
        .max_media_playlist_fragment_results = "MaxMediaPlaylistFragmentResults",
        .playback_mode = "PlaybackMode",
        .stream_arn = "StreamARN",
        .stream_name = "StreamName",
    };
};

pub const GetHLSStreamingSessionURLOutput = struct {
    /// The URL (containing the session token) that a media player can use to
    /// retrieve the HLS
    /// master playlist.
    hls_streaming_session_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .hls_streaming_session_url = "HLSStreamingSessionURL",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetHLSStreamingSessionURLInput, options: Options) !GetHLSStreamingSessionURLOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "kinesisvideoarchivedmedia");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetHLSStreamingSessionURLInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisvideoarchivedmedia", "Kinesis Video Archived Media", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/getHLSStreamingSessionURL";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.container_format) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ContainerFormat\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.discontinuity_mode) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DiscontinuityMode\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.display_fragment_timestamp) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DisplayFragmentTimestamp\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.expires) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Expires\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.hls_fragment_selector) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"HLSFragmentSelector\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.max_media_playlist_fragment_results) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"MaxMediaPlaylistFragmentResults\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.playback_mode) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"PlaybackMode\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.stream_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"StreamARN\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.stream_name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"StreamName\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetHLSStreamingSessionURLOutput {
    var result: GetHLSStreamingSessionURLOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetHLSStreamingSessionURLOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
