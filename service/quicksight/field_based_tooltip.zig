const Visibility = @import("visibility.zig").Visibility;
const TooltipItem = @import("tooltip_item.zig").TooltipItem;
const TooltipTitleType = @import("tooltip_title_type.zig").TooltipTitleType;

/// The setup for the detailed tooltip.
pub const FieldBasedTooltip = struct {
    /// The visibility of `Show aggregations`.
    aggregation_visibility: ?Visibility = null,

    /// The fields configuration in the
    /// tooltip.
    tooltip_fields: ?[]const TooltipItem = null,

    /// The type for the >tooltip title. Choose one of the following options:
    ///
    /// * `NONE`: Doesn't use the primary value as the title.
    ///
    /// * `PRIMARY_VALUE`: Uses primary value as the title.
    tooltip_title_type: ?TooltipTitleType = null,

    pub const json_field_names = .{
        .aggregation_visibility = "AggregationVisibility",
        .tooltip_fields = "TooltipFields",
        .tooltip_title_type = "TooltipTitleType",
    };
};
