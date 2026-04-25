const CascadingControlConfiguration = @import("cascading_control_configuration.zig").CascadingControlConfiguration;
const ControlSortConfiguration = @import("control_sort_configuration.zig").ControlSortConfiguration;
const ListControlDisplayOptions = @import("list_control_display_options.zig").ListControlDisplayOptions;
const FilterSelectableValues = @import("filter_selectable_values.zig").FilterSelectableValues;
const SheetControlListType = @import("sheet_control_list_type.zig").SheetControlListType;

/// A control to display a list of buttons or boxes. This is used to select
/// either a single value or multiple values.
pub const FilterListControl = struct {
    /// The values that are displayed in a control can be configured to only show
    /// values that are valid based on what's selected in other controls.
    cascading_control_configuration: ?CascadingControlConfiguration = null,

    /// The sort configuration for the values displayed in the control. Only one
    /// sort configuration can be applied per control.
    control_sort_configurations: ?[]const ControlSortConfiguration = null,

    /// The display options of a control.
    display_options: ?ListControlDisplayOptions = null,

    /// The ID of the `FilterListControl`.
    filter_control_id: []const u8,

    /// A list of selectable values that are used in a control.
    selectable_values: ?FilterSelectableValues = null,

    /// The source filter ID of the `FilterListControl`.
    source_filter_id: []const u8,

    /// The title of the `FilterListControl`.
    title: []const u8,

    /// The type of the `FilterListControl`. Choose one of the following options:
    ///
    /// * `MULTI_SELECT`: The user can select multiple entries from the list.
    ///
    /// * `SINGLE_SELECT`: The user can select a single entry from the list.
    @"type": ?SheetControlListType = null,

    pub const json_field_names = .{
        .cascading_control_configuration = "CascadingControlConfiguration",
        .control_sort_configurations = "ControlSortConfigurations",
        .display_options = "DisplayOptions",
        .filter_control_id = "FilterControlId",
        .selectable_values = "SelectableValues",
        .source_filter_id = "SourceFilterId",
        .title = "Title",
        .@"type" = "Type",
    };
};
