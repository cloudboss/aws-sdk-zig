const CommitMode = @import("commit_mode.zig").CommitMode;
const DateTimePickerControlDisplayOptions = @import("date_time_picker_control_display_options.zig").DateTimePickerControlDisplayOptions;
const SheetControlDateTimePickerType = @import("sheet_control_date_time_picker_type.zig").SheetControlDateTimePickerType;

/// The default options that correspond to the filter control type of a
/// `DateTimePicker`.
pub const DefaultDateTimePickerControlOptions = struct {
    /// The visibility configuration of the Apply button on a
    /// `DateTimePickerControl`.
    commit_mode: ?CommitMode,

    /// The display options of a control.
    display_options: ?DateTimePickerControlDisplayOptions,

    /// The date time picker type of the `DefaultDateTimePickerControlOptions`.
    /// Choose one of the following options:
    ///
    /// * `SINGLE_VALUED`: The filter condition is a fixed date.
    ///
    /// * `DATE_RANGE`: The filter condition is a date time range.
    type: ?SheetControlDateTimePickerType,

    pub const json_field_names = .{
        .commit_mode = "CommitMode",
        .display_options = "DisplayOptions",
        .type = "Type",
    };
};
