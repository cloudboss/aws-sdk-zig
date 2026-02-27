const SmallMultiplesAxisPlacement = @import("small_multiples_axis_placement.zig").SmallMultiplesAxisPlacement;
const SmallMultiplesAxisScale = @import("small_multiples_axis_scale.zig").SmallMultiplesAxisScale;

/// Configures the properties of a chart's axes that are used by small multiples
/// panels.
pub const SmallMultiplesAxisProperties = struct {
    /// Defines the placement of the axis. By default, axes are rendered `OUTSIDE`
    /// of the panels. Axes with `INDEPENDENT` scale are rendered `INSIDE` the
    /// panels.
    placement: ?SmallMultiplesAxisPlacement,

    /// Determines whether scale of the axes are shared or independent. The default
    /// value is `SHARED`.
    scale: ?SmallMultiplesAxisScale,

    pub const json_field_names = .{
        .placement = "Placement",
        .scale = "Scale",
    };
};
