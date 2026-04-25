const ControlSortConfiguration = @import("control_sort_configuration.zig").ControlSortConfiguration;
const ListControlDisplayOptions = @import("list_control_display_options.zig").ListControlDisplayOptions;
const FilterSelectableValues = @import("filter_selectable_values.zig").FilterSelectableValues;
const SheetControlListType = @import("sheet_control_list_type.zig").SheetControlListType;

/// The default options that correspond to the `List` filter control type.
pub const DefaultFilterListControlOptions = struct {
    /// The sort configuration for the values displayed in the control. Only one
    /// sort configuration can be applied per control.
    control_sort_configurations: ?[]const ControlSortConfiguration = null,

    /// The display options of a control.
    display_options: ?ListControlDisplayOptions = null,

    /// A list of selectable values that are used in a control.
    selectable_values: ?FilterSelectableValues = null,

    /// The type of the `DefaultFilterListControlOptions`. Choose one of the
    /// following options:
    ///
    /// * `MULTI_SELECT`: The user can select multiple entries from the list.
    ///
    /// * `SINGLE_SELECT`: The user can select a single entry from the list.
    @"type": ?SheetControlListType = null,

    pub const json_field_names = .{
        .control_sort_configurations = "ControlSortConfigurations",
        .display_options = "DisplayOptions",
        .selectable_values = "SelectableValues",
        .@"type" = "Type",
    };
};
