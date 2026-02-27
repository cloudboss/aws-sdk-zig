const TooltipTarget = @import("tooltip_target.zig").TooltipTarget;
const Visibility = @import("visibility.zig").Visibility;

/// The tooltip item for the fields.
pub const FieldTooltipItem = struct {
    /// The unique ID of the field that is targeted by the tooltip.
    field_id: []const u8,

    /// The label of the tooltip item.
    label: ?[]const u8,

    /// Determines the target of the field tooltip item in a combo chart visual.
    tooltip_target: ?TooltipTarget,

    /// The visibility of the tooltip item.
    visibility: ?Visibility,

    pub const json_field_names = .{
        .field_id = "FieldId",
        .label = "Label",
        .tooltip_target = "TooltipTarget",
        .visibility = "Visibility",
    };
};
