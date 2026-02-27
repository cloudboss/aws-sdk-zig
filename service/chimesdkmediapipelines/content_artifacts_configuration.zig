const ContentMuxType = @import("content_mux_type.zig").ContentMuxType;
const ArtifactsState = @import("artifacts_state.zig").ArtifactsState;

/// The content artifact object.
pub const ContentArtifactsConfiguration = struct {
    /// The MUX type of the artifact configuration.
    mux_type: ?ContentMuxType,

    /// Indicates whether the content artifact is enabled or disabled.
    state: ArtifactsState,

    pub const json_field_names = .{
        .mux_type = "MuxType",
        .state = "State",
    };
};
