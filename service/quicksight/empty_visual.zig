const VisualCustomAction = @import("visual_custom_action.zig").VisualCustomAction;

/// An empty visual.
///
/// Empty visuals are used in layouts but have not been configured to show any
/// data. A new visual created in the Quick Sight console is considered an
/// `EmptyVisual` until a visual type is selected.
pub const EmptyVisual = struct {
    /// The list of custom actions that are configured for a visual.
    actions: ?[]const VisualCustomAction,

    /// The data set that is used in the empty visual. Every visual requires a
    /// dataset to render.
    data_set_identifier: []const u8,

    /// The unique identifier of a visual. This identifier must be unique within the
    /// context of a dashboard, template, or analysis. Two dashboards, analyses, or
    /// templates can have visuals with the same identifiers.
    visual_id: []const u8,

    pub const json_field_names = .{
        .actions = "Actions",
        .data_set_identifier = "DataSetIdentifier",
        .visual_id = "VisualId",
    };
};
