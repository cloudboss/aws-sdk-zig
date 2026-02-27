const PipBehavior = @import("pip_behavior.zig").PipBehavior;
const PipPosition = @import("pip_position.zig").PipPosition;
const VideoFillMode = @import("video_fill_mode.zig").VideoFillMode;

/// Configuration information specific to Picture-in-Picture (PiP) layout, for
/// [server-side
/// composition](https://docs.aws.amazon.com/ivs/latest/RealTimeUserGuide/server-side-composition.html).
pub const PipConfiguration = struct {
    /// This attribute name identifies the featured slot. A participant with this
    /// attribute set
    /// to `"true"` (as a string value) in ParticipantTokenConfiguration is placed
    /// in the featured slot. Default: `""` (no featured
    /// participant).
    featured_participant_attribute: ?[]const u8,

    /// Specifies the spacing between participant tiles in pixels. Default:
    /// `0`.
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

    /// Defines PiP behavior when all participants have left: `STATIC` (maintains
    /// original position/size) or `DYNAMIC` (expands to full composition). Default:
    /// `STATIC`.
    pip_behavior: ?PipBehavior,

    /// Specifies the height of the PiP window in pixels. When this is not set
    /// explicitly,
    /// `pipHeight`’s value will be based on the size of the composition and the
    /// aspect ratio of the participant’s video.
    pip_height: ?i32,

    /// Sets the PiP window’s offset position in pixels from the closest edges
    /// determined by
    /// `PipPosition`. Default: `0`.
    pip_offset: i32 = 0,

    /// Specifies the participant for the PiP window. A participant with this
    /// attribute set to
    /// `"true"` (as a string value) in ParticipantTokenConfiguration is placed in
    /// the PiP slot. Default: `""` (no PiP participant).
    pip_participant_attribute: ?[]const u8,

    /// Determines the corner position of the PiP window. Default:
    /// `BOTTOM_RIGHT`.
    pip_position: ?PipPosition,

    /// Specifies the width of the PiP window in pixels. When this is not set
    /// explicitly,
    /// `pipWidth`’s value will be based on the size of the composition and the
    /// aspect ratio of the participant’s video.
    pip_width: ?i32,

    /// Defines how video content fits within the participant tile: `FILL`
    /// (stretched), `COVER` (cropped), or `CONTAIN` (letterboxed). Default:
    /// `COVER`.
    video_fill_mode: ?VideoFillMode,

    pub const json_field_names = .{
        .featured_participant_attribute = "featuredParticipantAttribute",
        .grid_gap = "gridGap",
        .omit_stopped_video = "omitStoppedVideo",
        .participant_order_attribute = "participantOrderAttribute",
        .pip_behavior = "pipBehavior",
        .pip_height = "pipHeight",
        .pip_offset = "pipOffset",
        .pip_participant_attribute = "pipParticipantAttribute",
        .pip_position = "pipPosition",
        .pip_width = "pipWidth",
        .video_fill_mode = "videoFillMode",
    };
};
