const DecalPatternType = @import("decal_pattern_type.zig").DecalPatternType;
const DecalStyleType = @import("decal_style_type.zig").DecalStyleType;
const Visibility = @import("visibility.zig").Visibility;

/// Decal settings for accessibility features that define visual patterns and
/// styling for data elements.
pub const DecalSettings = struct {
    /// Color configuration for the decal pattern.
    decal_color: ?[]const u8 = null,

    /// Type of pattern used for the decal, such as solid, diagonal, or circular
    /// patterns in various sizes.
    ///
    /// * `SOLID`: Solid fill pattern.
    ///
    /// * `DIAGONAL_SMALL`: Small diagonal stripes pattern.
    ///
    /// * `DIAGONAL_MEDIUM`: Medium diagonal stripes pattern.
    ///
    /// * `DIAGONAL_LARGE`: Large diagonal stripes pattern.
    ///
    /// * `DIAGONAL_OPPOSITE_SMALL`: Small cross-diagonal stripes pattern.
    ///
    /// * `DIAGONAL_OPPOSITE_MEDIUM`: Medium cross-diagonal stripes pattern.
    ///
    /// * `DIAGONAL_OPPOSITE_LARGE`: Large cross-diagonal stripes pattern.
    ///
    /// * `CIRCLE_SMALL`: Small circle pattern.
    ///
    /// * `CIRCLE_MEDIUM`: Medium circle pattern.
    ///
    /// * `CIRCLE_LARGE`: Large circle pattern.
    ///
    /// * `DIAMOND_SMALL`: Small diamonds pattern.
    ///
    /// * `DIAMOND_MEDIUM`: Medium diamonds pattern.
    ///
    /// * `DIAMOND_LARGE`: Large diamonds pattern.
    ///
    /// * `DIAMOND_GRID_SMALL`: Small diamond grid pattern.
    ///
    /// * `DIAMOND_GRID_MEDIUM`: Medium diamond grid pattern.
    ///
    /// * `DIAMOND_GRID_LARGE`: Large diamond grid pattern.
    ///
    /// * `CHECKERBOARD_SMALL`: Small checkerboard pattern.
    ///
    /// * `CHECKERBOARD_MEDIUM`: Medium checkerboard pattern.
    ///
    /// * `CHECKERBOARD_LARGE`: Large checkerboard pattern.
    ///
    /// * `TRIANGLE_SMALL`: Small triangles pattern.
    ///
    /// * `TRIANGLE_MEDIUM`: Medium triangles pattern.
    ///
    /// * `TRIANGLE_LARGE`: Large triangles pattern.
    decal_pattern_type: ?DecalPatternType = null,

    /// Style type for the decal, which can be either manual or automatic. This
    /// field is only applicable for line series.
    ///
    /// * `Manual`: Apply manual line and marker configuration for line series.
    ///
    /// * `Auto`: Apply automatic line and marker configuration for line series.
    decal_style_type: ?DecalStyleType = null,

    /// Visibility setting for the decal pattern.
    decal_visibility: ?Visibility = null,

    /// Field value of the field that you are setting the decal pattern to.
    /// Applicable only for field level settings.
    element_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .decal_color = "DecalColor",
        .decal_pattern_type = "DecalPatternType",
        .decal_style_type = "DecalStyleType",
        .decal_visibility = "DecalVisibility",
        .element_value = "ElementValue",
    };
};
