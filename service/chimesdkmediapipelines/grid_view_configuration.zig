const ActiveSpeakerOnlyConfiguration = @import("active_speaker_only_configuration.zig").ActiveSpeakerOnlyConfiguration;
const CanvasOrientation = @import("canvas_orientation.zig").CanvasOrientation;
const ContentShareLayoutOption = @import("content_share_layout_option.zig").ContentShareLayoutOption;
const HorizontalLayoutConfiguration = @import("horizontal_layout_configuration.zig").HorizontalLayoutConfiguration;
const PresenterOnlyConfiguration = @import("presenter_only_configuration.zig").PresenterOnlyConfiguration;
const VerticalLayoutConfiguration = @import("vertical_layout_configuration.zig").VerticalLayoutConfiguration;
const VideoAttribute = @import("video_attribute.zig").VideoAttribute;

/// Specifies the type of grid layout.
pub const GridViewConfiguration = struct {
    /// The configuration settings for an `ActiveSpeakerOnly` video tile.
    active_speaker_only_configuration: ?ActiveSpeakerOnlyConfiguration = null,

    /// The orientation setting, horizontal or vertical.
    canvas_orientation: ?CanvasOrientation = null,

    /// Defines the layout of the video tiles when content sharing is enabled.
    content_share_layout: ContentShareLayoutOption,

    /// The configuration settings for a horizontal layout.
    horizontal_layout_configuration: ?HorizontalLayoutConfiguration = null,

    /// Defines the configuration options for a presenter only video tile.
    presenter_only_configuration: ?PresenterOnlyConfiguration = null,

    /// The configuration settings for a vertical layout.
    vertical_layout_configuration: ?VerticalLayoutConfiguration = null,

    /// The attribute settings for the video tiles.
    video_attribute: ?VideoAttribute = null,

    pub const json_field_names = .{
        .active_speaker_only_configuration = "ActiveSpeakerOnlyConfiguration",
        .canvas_orientation = "CanvasOrientation",
        .content_share_layout = "ContentShareLayout",
        .horizontal_layout_configuration = "HorizontalLayoutConfiguration",
        .presenter_only_configuration = "PresenterOnlyConfiguration",
        .vertical_layout_configuration = "VerticalLayoutConfiguration",
        .video_attribute = "VideoAttribute",
    };
};
