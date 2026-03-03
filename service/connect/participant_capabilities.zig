const ScreenShareCapability = @import("screen_share_capability.zig").ScreenShareCapability;
const VideoCapability = @import("video_capability.zig").VideoCapability;

/// The configuration for the allowed video and screen sharing capabilities for
/// participants present over the call.
/// For more information, see [Set up
/// in-app, web, video calling, and screen sharing
/// capabilities](https://docs.aws.amazon.com/connect/latest/adminguide/inapp-calling.html) in the *Amazon Connect Administrator
/// Guide*.
pub const ParticipantCapabilities = struct {
    /// The screen sharing capability that is enabled for the participant. `SEND`
    /// indicates the participant
    /// can share their screen.
    screen_share: ?ScreenShareCapability = null,

    /// The configuration having the video and screen sharing capabilities for
    /// participants over the call.
    video: ?VideoCapability = null,

    pub const json_field_names = .{
        .screen_share = "ScreenShare",
        .video = "Video",
    };
};
