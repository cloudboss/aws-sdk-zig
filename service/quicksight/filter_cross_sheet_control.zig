const CascadingControlConfiguration = @import("cascading_control_configuration.zig").CascadingControlConfiguration;

/// A control from a filter that is scoped across more than one sheet. This
/// represents your filter control on a sheet
pub const FilterCrossSheetControl = struct {
    /// The values that are displayed in a control can be configured to only show
    /// values that are valid based on what's selected in other controls.
    cascading_control_configuration: ?CascadingControlConfiguration = null,

    /// The ID of the `FilterCrossSheetControl`.
    filter_control_id: []const u8,

    /// The source filter ID of the `FilterCrossSheetControl`.
    source_filter_id: []const u8,

    pub const json_field_names = .{
        .cascading_control_configuration = "CascadingControlConfiguration",
        .filter_control_id = "FilterControlId",
        .source_filter_id = "SourceFilterId",
    };
};
