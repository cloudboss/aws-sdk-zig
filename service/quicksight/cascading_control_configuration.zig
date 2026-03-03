const CascadingControlSource = @import("cascading_control_source.zig").CascadingControlSource;

/// The values that are displayed in a control can be configured to only show
/// values that are valid based on what's selected in other controls.
pub const CascadingControlConfiguration = struct {
    /// A list of source controls that determine the values that are used in the
    /// current control.
    source_controls: ?[]const CascadingControlSource = null,

    pub const json_field_names = .{
        .source_controls = "SourceControls",
    };
};
