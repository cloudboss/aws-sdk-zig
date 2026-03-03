const CommitMode = @import("commit_mode.zig").CommitMode;
const RelativeDateTimeControlDisplayOptions = @import("relative_date_time_control_display_options.zig").RelativeDateTimeControlDisplayOptions;

/// A control from a date filter that is used to specify the relative date.
pub const FilterRelativeDateTimeControl = struct {
    /// The visibility configuration of the Apply button on a
    /// `FilterRelativeDateTimeControl`.
    commit_mode: ?CommitMode = null,

    /// The display options of a control.
    display_options: ?RelativeDateTimeControlDisplayOptions = null,

    /// The ID of the `FilterTextAreaControl`.
    filter_control_id: []const u8,

    /// The source filter ID of the `FilterTextAreaControl`.
    source_filter_id: []const u8,

    /// The title of the `FilterTextAreaControl`.
    title: []const u8,

    pub const json_field_names = .{
        .commit_mode = "CommitMode",
        .display_options = "DisplayOptions",
        .filter_control_id = "FilterControlId",
        .source_filter_id = "SourceFilterId",
        .title = "Title",
    };
};
