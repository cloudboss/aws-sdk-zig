const CommitMode = @import("commit_mode.zig").CommitMode;
const DateTimePickerControlDisplayOptions = @import("date_time_picker_control_display_options.zig").DateTimePickerControlDisplayOptions;
const SheetControlDateTimePickerType = @import("sheet_control_date_time_picker_type.zig").SheetControlDateTimePickerType;

/// A control from a date filter that is used to specify date and time.
pub const FilterDateTimePickerControl = struct {
    /// The visibility configurationof the Apply button on a
    /// `DateTimePickerControl`.
    commit_mode: ?CommitMode,

    /// The display options of a control.
    display_options: ?DateTimePickerControlDisplayOptions,

    /// The ID of the `FilterDateTimePickerControl`.
    filter_control_id: []const u8,

    /// The source filter ID of the `FilterDateTimePickerControl`.
    source_filter_id: []const u8,

    /// The title of the `FilterDateTimePickerControl`.
    title: []const u8,

    /// The type of the `FilterDropDownControl`. Choose one of the following
    /// options:
    ///
    /// * `MULTI_SELECT`: The user can select multiple entries from a dropdown menu.
    ///
    /// * `SINGLE_SELECT`: The user can select a single entry from a dropdown menu.
    @"type": ?SheetControlDateTimePickerType,

    pub const json_field_names = .{
        .commit_mode = "CommitMode",
        .display_options = "DisplayOptions",
        .filter_control_id = "FilterControlId",
        .source_filter_id = "SourceFilterId",
        .title = "Title",
        .@"type" = "Type",
    };
};
