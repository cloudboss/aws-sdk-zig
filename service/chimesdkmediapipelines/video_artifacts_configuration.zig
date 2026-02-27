const VideoMuxType = @import("video_mux_type.zig").VideoMuxType;
const ArtifactsState = @import("artifacts_state.zig").ArtifactsState;

/// The video artifact configuration object.
pub const VideoArtifactsConfiguration = struct {
    /// The MUX type of the video artifact configuration object.
    mux_type: ?VideoMuxType,

    /// Indicates whether the video artifact is enabled or disabled.
    state: ArtifactsState,

    pub const json_field_names = .{
        .mux_type = "MuxType",
        .state = "State",
    };
};
