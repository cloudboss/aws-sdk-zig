const MultiviewLayoutType = @import("multiview_layout_type.zig").MultiviewLayoutType;

/// The multiview combination for a pinned manifest. MediaPackage serves the
/// manifest with this layout and these sources, so players request it without
/// an `aws.multiview` query parameter.
///
/// If a request for a pinned manifest also includes an `aws.multiview` query
/// parameter, MediaPackage rejects the request, even when that parameter
/// requests the same combination.
pub const MultiviewFilterConfiguration = struct {
    /// The layout that MediaPackage uses to composite the tiles into a single
    /// output. This layout must be one of the `AvailableLayouts` of the channel
    /// that this origin endpoint is on.
    layout: MultiviewLayoutType,

    /// The source channels to composite, in tile order. Each channel must be one of
    /// the `AvailableSources` of the channel that this origin endpoint is on, and
    /// the number of channels must equal the number of tiles in `Layout`.
    sources: []const []const u8,

    pub const json_field_names = .{
        .layout = "Layout",
        .sources = "Sources",
    };
};
