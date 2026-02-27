const Visibility = @import("visibility.zig").Visibility;
const KPISparklineType = @import("kpi_sparkline_type.zig").KPISparklineType;

/// The options that determine the visibility, color, type, and tooltip
/// visibility of the sparkline of a KPI visual.
pub const KPISparklineOptions = struct {
    /// The color of the sparkline.
    color: ?[]const u8,

    /// The tooltip visibility of the sparkline.
    tooltip_visibility: ?Visibility,

    /// The type of the sparkline.
    type: KPISparklineType,

    /// The visibility of the sparkline.
    visibility: ?Visibility,

    pub const json_field_names = .{
        .color = "Color",
        .tooltip_visibility = "TooltipVisibility",
        .type = "Type",
        .visibility = "Visibility",
    };
};
