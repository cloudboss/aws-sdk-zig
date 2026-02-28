const CascadingControlConfiguration = @import("cascading_control_configuration.zig").CascadingControlConfiguration;
const ListControlDisplayOptions = @import("list_control_display_options.zig").ListControlDisplayOptions;
const ParameterSelectableValues = @import("parameter_selectable_values.zig").ParameterSelectableValues;
const SheetControlListType = @import("sheet_control_list_type.zig").SheetControlListType;

/// A control to display a list with buttons or boxes that are used to select
/// either a single value or multiple values.
pub const ParameterListControl = struct {
    /// The values that are displayed in a control can be configured to only show
    /// values that are valid based on what's selected in other controls.
    cascading_control_configuration: ?CascadingControlConfiguration,

    /// The display options of a control.
    display_options: ?ListControlDisplayOptions,

    /// The ID of the `ParameterListControl`.
    parameter_control_id: []const u8,

    /// A list of selectable values that are used in a control.
    selectable_values: ?ParameterSelectableValues,

    /// The source parameter name of the `ParameterListControl`.
    source_parameter_name: []const u8,

    /// The title of the `ParameterListControl`.
    title: []const u8,

    /// The type of `ParameterListControl`.
    @"type": ?SheetControlListType,

    pub const json_field_names = .{
        .cascading_control_configuration = "CascadingControlConfiguration",
        .display_options = "DisplayOptions",
        .parameter_control_id = "ParameterControlId",
        .selectable_values = "SelectableValues",
        .source_parameter_name = "SourceParameterName",
        .title = "Title",
        .@"type" = "Type",
    };
};
