const VisualHighlightTrigger = @import("visual_highlight_trigger.zig").VisualHighlightTrigger;

/// Defines what initiates a highlight operation on a visual, such as a click or
/// hover.
pub const VisualHighlightOperation = struct {
    /// Specifies whether a highlight operation is initiated by a click or hover, or
    /// whether it's disabled.
    trigger: VisualHighlightTrigger,

    pub const json_field_names = .{
        .trigger = "Trigger",
    };
};
