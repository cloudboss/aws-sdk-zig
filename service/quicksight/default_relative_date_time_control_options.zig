const CommitMode = @import("commit_mode.zig").CommitMode;
const RelativeDateTimeControlDisplayOptions = @import("relative_date_time_control_display_options.zig").RelativeDateTimeControlDisplayOptions;

/// The default options that correspond to the `RelativeDateTime` filter control
/// type.
pub const DefaultRelativeDateTimeControlOptions = struct {
    /// The visibility configuration of the Apply button on a
    /// `RelativeDateTimeControl`.
    commit_mode: ?CommitMode,

    /// The display options of a control.
    display_options: ?RelativeDateTimeControlDisplayOptions,

    pub const json_field_names = .{
        .commit_mode = "CommitMode",
        .display_options = "DisplayOptions",
    };
};
