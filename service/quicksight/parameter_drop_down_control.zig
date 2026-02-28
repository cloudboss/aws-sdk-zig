const CascadingControlConfiguration = @import("cascading_control_configuration.zig").CascadingControlConfiguration;
const CommitMode = @import("commit_mode.zig").CommitMode;
const DropDownControlDisplayOptions = @import("drop_down_control_display_options.zig").DropDownControlDisplayOptions;
const ParameterSelectableValues = @import("parameter_selectable_values.zig").ParameterSelectableValues;
const SheetControlListType = @import("sheet_control_list_type.zig").SheetControlListType;

/// A control to display a dropdown list with buttons that are used to select a
/// single value.
pub const ParameterDropDownControl = struct {
    /// The values that are displayed in a control can be configured to only show
    /// values that are valid based on what's selected in other controls.
    cascading_control_configuration: ?CascadingControlConfiguration,

    /// The visibility configuration of the Apply button on a
    /// `ParameterDropDownControl`.
    commit_mode: ?CommitMode,

    /// The display options of a control.
    display_options: ?DropDownControlDisplayOptions,

    /// The ID of the `ParameterDropDownControl`.
    parameter_control_id: []const u8,

    /// A list of selectable values that are used in a control.
    selectable_values: ?ParameterSelectableValues,

    /// The source parameter name of the `ParameterDropDownControl`.
    source_parameter_name: []const u8,

    /// The title of the `ParameterDropDownControl`.
    title: []const u8,

    /// The type parameter name of the `ParameterDropDownControl`.
    @"type": ?SheetControlListType,

    pub const json_field_names = .{
        .cascading_control_configuration = "CascadingControlConfiguration",
        .commit_mode = "CommitMode",
        .display_options = "DisplayOptions",
        .parameter_control_id = "ParameterControlId",
        .selectable_values = "SelectableValues",
        .source_parameter_name = "SourceParameterName",
        .title = "Title",
        .@"type" = "Type",
    };
};
