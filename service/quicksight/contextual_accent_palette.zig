const Palette = @import("palette.zig").Palette;

/// The contextual accent palette.
pub const ContextualAccentPalette = struct {
    automation: ?Palette = null,

    connection: ?Palette = null,

    insight: ?Palette = null,

    visualization: ?Palette = null,

    pub const json_field_names = .{
        .automation = "Automation",
        .connection = "Connection",
        .insight = "Insight",
        .visualization = "Visualization",
    };
};
