const DefaultDateTimePickerControlOptions = @import("default_date_time_picker_control_options.zig").DefaultDateTimePickerControlOptions;
const DefaultFilterDropDownControlOptions = @import("default_filter_drop_down_control_options.zig").DefaultFilterDropDownControlOptions;
const DefaultFilterListControlOptions = @import("default_filter_list_control_options.zig").DefaultFilterListControlOptions;
const DefaultRelativeDateTimeControlOptions = @import("default_relative_date_time_control_options.zig").DefaultRelativeDateTimeControlOptions;
const DefaultSliderControlOptions = @import("default_slider_control_options.zig").DefaultSliderControlOptions;
const DefaultTextAreaControlOptions = @import("default_text_area_control_options.zig").DefaultTextAreaControlOptions;
const DefaultTextFieldControlOptions = @import("default_text_field_control_options.zig").DefaultTextFieldControlOptions;

/// The option that corresponds to the control type of the filter.
pub const DefaultFilterControlOptions = struct {
    /// The default options that correspond to the filter control type of a
    /// `DateTimePicker`.
    default_date_time_picker_options: ?DefaultDateTimePickerControlOptions,

    /// The default options that correspond to the `Dropdown` filter control type.
    default_dropdown_options: ?DefaultFilterDropDownControlOptions,

    /// The default options that correspond to the `List` filter control type.
    default_list_options: ?DefaultFilterListControlOptions,

    /// The default options that correspond to the `RelativeDateTime` filter control
    /// type.
    default_relative_date_time_options: ?DefaultRelativeDateTimeControlOptions,

    /// The default options that correspond to the `Slider` filter control type.
    default_slider_options: ?DefaultSliderControlOptions,

    /// The default options that correspond to the `TextArea` filter control type.
    default_text_area_options: ?DefaultTextAreaControlOptions,

    /// The default options that correspond to the `TextField` filter control type.
    default_text_field_options: ?DefaultTextFieldControlOptions,

    pub const json_field_names = .{
        .default_date_time_picker_options = "DefaultDateTimePickerOptions",
        .default_dropdown_options = "DefaultDropdownOptions",
        .default_list_options = "DefaultListOptions",
        .default_relative_date_time_options = "DefaultRelativeDateTimeOptions",
        .default_slider_options = "DefaultSliderOptions",
        .default_text_area_options = "DefaultTextAreaOptions",
        .default_text_field_options = "DefaultTextFieldOptions",
    };
};
