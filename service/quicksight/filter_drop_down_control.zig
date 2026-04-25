const CascadingControlConfiguration = @import("cascading_control_configuration.zig").CascadingControlConfiguration;
const CommitMode = @import("commit_mode.zig").CommitMode;
const ControlSortConfiguration = @import("control_sort_configuration.zig").ControlSortConfiguration;
const DropDownControlDisplayOptions = @import("drop_down_control_display_options.zig").DropDownControlDisplayOptions;
const FilterSelectableValues = @import("filter_selectable_values.zig").FilterSelectableValues;
const SheetControlListType = @import("sheet_control_list_type.zig").SheetControlListType;

/// A control to display a dropdown list with buttons that are used to select a
/// single value.
pub const FilterDropDownControl = struct {
    /// The values that are displayed in a control can be configured to only show
    /// values that are valid based on what's selected in other controls.
    cascading_control_configuration: ?CascadingControlConfiguration = null,

    /// The visibility configuration of the Apply button on a
    /// `FilterDropDownControl`.
    commit_mode: ?CommitMode = null,

    /// The sort configuration for the values displayed in the control. Only one
    /// sort configuration can be applied per control.
    control_sort_configurations: ?[]const ControlSortConfiguration = null,

    /// The display options of the `FilterDropDownControl`.
    display_options: ?DropDownControlDisplayOptions = null,

    /// The ID of the `FilterDropDownControl`.
    filter_control_id: []const u8,

    /// A list of selectable values that are used in a control.
    selectable_values: ?FilterSelectableValues = null,

    /// The source filter ID of the `FilterDropDownControl`.
    source_filter_id: []const u8,

    /// The title of the `FilterDropDownControl`.
    title: []const u8,

    /// The type of the `FilterDropDownControl`. Choose one of the following
    /// options:
    ///
    /// * `MULTI_SELECT`: The user can select multiple entries from a dropdown menu.
    ///
    /// * `SINGLE_SELECT`: The user can select a single entry from a dropdown menu.
    @"type": ?SheetControlListType = null,

    pub const json_field_names = .{
        .cascading_control_configuration = "CascadingControlConfiguration",
        .commit_mode = "CommitMode",
        .control_sort_configurations = "ControlSortConfigurations",
        .display_options = "DisplayOptions",
        .filter_control_id = "FilterControlId",
        .selectable_values = "SelectableValues",
        .source_filter_id = "SourceFilterId",
        .title = "Title",
        .@"type" = "Type",
    };
};
