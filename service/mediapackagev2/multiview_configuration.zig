const MultiviewLayoutType = @import("multiview_layout_type.zig").MultiviewLayoutType;

/// The multiview configuration for a channel. A multiview channel composites
/// video from several source channels into a single tiled output stream.
/// Players receive one standard HLS or DASH stream instead of several separate
/// streams. This setting is required when `InputType` is `MULTIVIEW`, and can't
/// be set for any other input type.
pub const MultiviewConfiguration = struct {
    /// The tile layouts that players can request from this multiview channel's
    /// origin endpoints. Only the layouts that you list here are available. Each
    /// layout must appear at most once.
    available_layouts: []const MultiviewLayoutType,

    /// The channels that players can use as tiles in this multiview channel's
    /// output. Each source channel must be in the same channel group as the
    /// multiview channel, and must have an `InputType` of `CMAF`. Only the channels
    /// that you list here are available as tiles.
    available_sources: []const []const u8,

    pub const json_field_names = .{
        .available_layouts = "AvailableLayouts",
        .available_sources = "AvailableSources",
    };
};
