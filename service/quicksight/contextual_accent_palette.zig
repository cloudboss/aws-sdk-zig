const Palette = @import("palette.zig").Palette;

/// The contextual accent palette.
pub const ContextualAccentPalette = struct {
    automation: ?Palette,

    connection: ?Palette,

    insight: ?Palette,

    visualization: ?Palette,

    pub const json_field_names = .{
        .automation = "Automation",
        .connection = "Connection",
        .insight = "Insight",
        .visualization = "Visualization",
    };
};
