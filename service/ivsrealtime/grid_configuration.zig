const VideoAspectRatio = @import("video_aspect_ratio.zig").VideoAspectRatio;
const VideoFillMode = @import("video_fill_mode.zig").VideoFillMode;

/// Configuration information specific to Grid layout, for server-side
/// composition. See
/// "Layouts" in [Server-Side
/// Composition](https://docs.aws.amazon.com/ivs/latest/RealTimeUserGuide/server-side-composition.html).
pub const GridConfiguration = struct {
    /// This attribute name identifies the featured slot. A participant with this
    /// attribute set
    /// to `"true"` (as a string value) in ParticipantTokenConfiguration is placed
    /// in the featured slot. Default: `""` (no featured
    /// participant).
    featured_participant_attribute: ?[]const u8,

    /// Specifies the spacing between participant tiles in pixels. Default:
    /// `2`.
    grid_gap: i32 = 0,

    /// Determines whether to omit participants with stopped video in the
    /// composition. Default:
    /// `false`.
    omit_stopped_video: bool = false,

    /// Attribute name in ParticipantTokenConfiguration identifying the participant
    /// ordering key.
    /// Participants with `participantOrderAttribute` set to `""` or not specified
    /// are ordered based
    /// on their arrival time into the stage.
    participant_order_attribute: ?[]const u8,

    /// Sets the non-featured participant display mode, to control the aspect ratio
    /// of video
    /// tiles. `VIDEO` is 16:9, `SQUARE` is 1:1, and `PORTRAIT` is
    /// 3:4. Default: `VIDEO`.
    video_aspect_ratio: ?VideoAspectRatio,

    /// Defines how video content fits within the participant tile: `FILL`
    /// (stretched), `COVER` (cropped), or `CONTAIN` (letterboxed). When not
    /// set, `videoFillMode` defaults to `COVER` fill mode for participants
    /// in the grid and to `CONTAIN` fill mode for featured participants.
    video_fill_mode: ?VideoFillMode,

    pub const json_field_names = .{
        .featured_participant_attribute = "featuredParticipantAttribute",
        .grid_gap = "gridGap",
        .omit_stopped_video = "omitStoppedVideo",
        .participant_order_attribute = "participantOrderAttribute",
        .video_aspect_ratio = "videoAspectRatio",
        .video_fill_mode = "videoFillMode",
    };
};
