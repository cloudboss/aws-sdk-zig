const aws = @import("aws");
const std = @import("std");

const join_storage_session = @import("join_storage_session.zig");
const join_storage_session_as_viewer = @import("join_storage_session_as_viewer.zig");
const CallOptions = @import("call_options.zig").CallOptions;

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Kinesis Video WebRTC Storage";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Before using this API, you must call the `GetSignalingChannelEndpoint` API
    /// to request the WEBRTC endpoint. You then specify the endpoint and region in
    /// your `JoinStorageSession` API request.
    ///
    /// Join the ongoing one way-video and/or multi-way audio WebRTC session as a
    /// video producing
    /// device for an input channel. If there’s no existing session for the channel,
    /// a new streaming
    /// session needs to be created, and the Amazon Resource Name (ARN) of the
    /// signaling channel must
    /// be provided.
    ///
    /// Currently for the `SINGLE_MASTER` type, a video producing
    /// device is able to ingest both audio and video media into a stream. Only
    /// video producing devices can join the session and record media.
    ///
    /// Both audio and video tracks are currently required for WebRTC ingestion.
    ///
    /// Current requirements:
    ///
    /// * Video track: H.264
    ///
    /// * Audio track: Opus
    ///
    /// The resulting ingested video in the Kinesis video stream will have the
    /// following
    /// parameters: H.264 video and AAC audio.
    ///
    /// Once a master participant has negotiated a connection through WebRTC, the
    /// ingested media
    /// session will be stored in the Kinesis video stream. Multiple viewers are
    /// then able to play
    /// back real-time media through our Playback APIs.
    ///
    /// You can also use existing Kinesis Video Streams features like `HLS` or
    /// `DASH` playback, image generation via
    /// [GetImages](https://docs.aws.amazon.com/kinesisvideostreams/latest/dg/gs-getImages.html), and more
    /// with ingested WebRTC media.
    ///
    /// S3 image delivery and notifications are not currently supported.
    ///
    /// Assume that only one video producing device client
    /// can be associated with a session for the channel. If more than one
    /// client joins the session of a specific channel as a video producing device,
    /// the most recent client request takes precedence.
    ///
    /// **Additional information**
    ///
    /// * **Idempotent** - This API is not idempotent.
    ///
    /// * **Retry behavior** - This is counted as a new API call.
    ///
    /// * **Concurrent calls** - Concurrent calls are allowed. An offer is sent once
    ///   per each call.
    pub fn joinStorageSession(self: *Self, allocator: std.mem.Allocator, input: join_storage_session.JoinStorageSessionInput, options: CallOptions) !join_storage_session.JoinStorageSessionOutput {
        return join_storage_session.execute(self, allocator, input, options);
    }

    /// Join the ongoing one way-video and/or multi-way audio WebRTC session as
    /// a viewer for an input channel. If there’s
    /// no existing session for the channel, create a new streaming session and
    /// provide
    /// the Amazon Resource Name (ARN) of the signaling channel (`channelArn`)
    /// and client id (`clientId`).
    ///
    /// Currently for `SINGLE_MASTER` type, a video producing device
    /// is able to ingest both audio and video media into a stream, while viewers
    /// can only ingest audio. Both a video producing device and viewers can join
    /// a session first and wait for other participants. While participants are
    /// having peer to peer conversations through WebRTC,
    /// the ingested media session will be stored into the Kinesis Video Stream.
    /// Multiple viewers are able to playback real-time media.
    ///
    /// Customers can also use existing Kinesis Video Streams features like
    /// `HLS` or `DASH` playback, Image generation, and more
    /// with ingested WebRTC media. If there’s an existing session with the same
    /// `clientId` that's found in the join session request, the new request takes
    /// precedence.
    pub fn joinStorageSessionAsViewer(self: *Self, allocator: std.mem.Allocator, input: join_storage_session_as_viewer.JoinStorageSessionAsViewerInput, options: CallOptions) !join_storage_session_as_viewer.JoinStorageSessionAsViewerOutput {
        return join_storage_session_as_viewer.execute(self, allocator, input, options);
    }
};
