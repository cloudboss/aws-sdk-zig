const FilterCrossSheetControl = @import("filter_cross_sheet_control.zig").FilterCrossSheetControl;
const FilterDateTimePickerControl = @import("filter_date_time_picker_control.zig").FilterDateTimePickerControl;
const FilterDropDownControl = @import("filter_drop_down_control.zig").FilterDropDownControl;
const FilterListControl = @import("filter_list_control.zig").FilterListControl;
const FilterRelativeDateTimeControl = @import("filter_relative_date_time_control.zig").FilterRelativeDateTimeControl;
const FilterSliderControl = @import("filter_slider_control.zig").FilterSliderControl;
const FilterTextAreaControl = @import("filter_text_area_control.zig").FilterTextAreaControl;
const FilterTextFieldControl = @import("filter_text_field_control.zig").FilterTextFieldControl;

/// The control of a filter that is used to interact with a dashboard or an
/// analysis.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const FilterControl = struct {
    /// A control from a filter that is scoped across more than one sheet. This
    /// represents your filter control on a sheet
    cross_sheet: ?FilterCrossSheetControl = null,

    /// A control from a date filter that is used to specify date and time.
    date_time_picker: ?FilterDateTimePickerControl = null,

    /// A control to display a dropdown list with buttons that are used to select a
    /// single value.
    dropdown: ?FilterDropDownControl = null,

    /// A control to display a list of buttons or boxes. This is used to select
    /// either a single value or multiple values.
    list: ?FilterListControl = null,

    /// A control from a date filter that is used to specify the relative date.
    relative_date_time: ?FilterRelativeDateTimeControl = null,

    /// A control to display a horizontal toggle bar. This is used to change a value
    /// by sliding the toggle.
    slider: ?FilterSliderControl = null,

    /// A control to display a text box that is used to enter multiple entries.
    text_area: ?FilterTextAreaControl = null,

    /// A control to display a text box that is used to enter a single entry.
    text_field: ?FilterTextFieldControl = null,

    pub const json_field_names = .{
        .cross_sheet = "CrossSheet",
        .date_time_picker = "DateTimePicker",
        .dropdown = "Dropdown",
        .list = "List",
        .relative_date_time = "RelativeDateTime",
        .slider = "Slider",
        .text_area = "TextArea",
        .text_field = "TextField",
    };
};
