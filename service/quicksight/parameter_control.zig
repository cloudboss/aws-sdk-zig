const ParameterDateTimePickerControl = @import("parameter_date_time_picker_control.zig").ParameterDateTimePickerControl;
const ParameterDropDownControl = @import("parameter_drop_down_control.zig").ParameterDropDownControl;
const ParameterListControl = @import("parameter_list_control.zig").ParameterListControl;
const ParameterSliderControl = @import("parameter_slider_control.zig").ParameterSliderControl;
const ParameterTextAreaControl = @import("parameter_text_area_control.zig").ParameterTextAreaControl;
const ParameterTextFieldControl = @import("parameter_text_field_control.zig").ParameterTextFieldControl;

/// The control of a parameter that users can interact with in a dashboard or an
/// analysis.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const ParameterControl = struct {
    /// A control from a date parameter that specifies date and time.
    date_time_picker: ?ParameterDateTimePickerControl,

    /// A control to display a dropdown list with buttons that are used to select a
    /// single value.
    dropdown: ?ParameterDropDownControl,

    /// A control to display a list with buttons or boxes that are used to select
    /// either a single value or multiple values.
    list: ?ParameterListControl,

    /// A control to display a horizontal toggle bar. This is used to change a value
    /// by sliding the toggle.
    slider: ?ParameterSliderControl,

    /// A control to display a text box that is used to enter multiple entries.
    text_area: ?ParameterTextAreaControl,

    /// A control to display a text box that is used to enter a single entry.
    text_field: ?ParameterTextFieldControl,

    pub const json_field_names = .{
        .date_time_picker = "DateTimePicker",
        .dropdown = "Dropdown",
        .list = "List",
        .slider = "Slider",
        .text_area = "TextArea",
        .text_field = "TextField",
    };
};
