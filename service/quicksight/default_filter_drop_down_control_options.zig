const CommitMode = @import("commit_mode.zig").CommitMode;
const ControlSortConfiguration = @import("control_sort_configuration.zig").ControlSortConfiguration;
const DropDownControlDisplayOptions = @import("drop_down_control_display_options.zig").DropDownControlDisplayOptions;
const FilterSelectableValues = @import("filter_selectable_values.zig").FilterSelectableValues;
const SheetControlListType = @import("sheet_control_list_type.zig").SheetControlListType;

/// The default options that correspond to the `Dropdown` filter control type.
pub const DefaultFilterDropDownControlOptions = struct {
    /// The visibility configuration of the Apply button on a
    /// `FilterDropDownControl`.
    commit_mode: ?CommitMode = null,

    /// The sort configuration for the values displayed in the control. Only one
    /// sort configuration can be applied per control.
    control_sort_configurations: ?[]const ControlSortConfiguration = null,

    /// The display options of a control.
    display_options: ?DropDownControlDisplayOptions = null,

    /// A list of selectable values that are used in a control.
    selectable_values: ?FilterSelectableValues = null,

    /// The type of the `FilterDropDownControl`. Choose one of the following
    /// options:
    ///
    /// * `MULTI_SELECT`: The user can select multiple entries from a dropdown menu.
    ///
    /// * `SINGLE_SELECT`: The user can select a single entry from a dropdown menu.
    @"type": ?SheetControlListType = null,

    pub const json_field_names = .{
        .commit_mode = "CommitMode",
        .control_sort_configurations = "ControlSortConfigurations",
        .display_options = "DisplayOptions",
        .selectable_values = "SelectableValues",
        .@"type" = "Type",
    };
};
