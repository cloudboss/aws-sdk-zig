const CommitMode = @import("commit_mode.zig").CommitMode;
const ControlSortConfiguration = @import("control_sort_configuration.zig").ControlSortConfiguration;
const ControlTitleFormatText = @import("control_title_format_text.zig").ControlTitleFormatText;
const HierarchyFilterListControlDisplayOptions = @import("hierarchy_filter_list_control_display_options.zig").HierarchyFilterListControlDisplayOptions;
const SheetControlListType = @import("sheet_control_list_type.zig").SheetControlListType;

/// The default options that correspond to the `HierarchyList` filter control
/// type.
pub const DefaultHierarchyFilterListControlOptions = struct {
    /// The visibility configuration of the Apply button on a
    /// `HierarchyFilterListControl`.
    commit_mode: ?CommitMode = null,

    /// The sort configuration for the values displayed in the control. Only one
    /// sort configuration can be applied per control.
    control_sort_configurations: ?[]const ControlSortConfiguration = null,

    /// The title text format configuration for the control.
    control_title_format_text: ?ControlTitleFormatText = null,

    /// The display options of a control.
    display_options: ?HierarchyFilterListControlDisplayOptions = null,

    /// The type of the `DefaultHierarchyFilterListControlOptions`. Choose one of
    /// the following options:
    ///
    /// * `MULTI_SELECT`: The user can select multiple entries from the list.
    ///
    /// * `SINGLE_SELECT`: The user can select a single entry from the list.
    @"type": ?SheetControlListType = null,

    pub const json_field_names = .{
        .commit_mode = "CommitMode",
        .control_sort_configurations = "ControlSortConfigurations",
        .control_title_format_text = "ControlTitleFormatText",
        .display_options = "DisplayOptions",
        .@"type" = "Type",
    };
};
