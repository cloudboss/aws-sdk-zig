const VisualHighlightOperation = @import("visual_highlight_operation.zig").VisualHighlightOperation;

/// A list of custom actions applied to visuals in an analysis or sheet.
pub const VisualCustomActionDefaults = struct {
    /// A list of highlight operations available for visuals in an analysis or
    /// sheet.
    highlight_operation: ?VisualHighlightOperation,

    pub const json_field_names = .{
        .highlight_operation = "highlightOperation",
    };
};
