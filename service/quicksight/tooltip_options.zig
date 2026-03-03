const FieldBasedTooltip = @import("field_based_tooltip.zig").FieldBasedTooltip;
const SelectedTooltipType = @import("selected_tooltip_type.zig").SelectedTooltipType;
const Visibility = @import("visibility.zig").Visibility;

/// The display options for the visual tooltip.
pub const TooltipOptions = struct {
    /// The setup for the detailed tooltip. The tooltip setup is always saved. The
    /// display type is decided based on the tooltip type.
    field_based_tooltip: ?FieldBasedTooltip = null,

    /// The selected type for the tooltip. Choose one of the following options:
    ///
    /// * `BASIC`: A basic tooltip.
    ///
    /// * `DETAILED`: A detailed tooltip.
    selected_tooltip_type: ?SelectedTooltipType = null,

    /// Determines whether or not the tooltip is visible.
    tooltip_visibility: ?Visibility = null,

    pub const json_field_names = .{
        .field_based_tooltip = "FieldBasedTooltip",
        .selected_tooltip_type = "SelectedTooltipType",
        .tooltip_visibility = "TooltipVisibility",
    };
};
