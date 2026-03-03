const SheetControlInfoIconLabelOptions = @import("sheet_control_info_icon_label_options.zig").SheetControlInfoIconLabelOptions;
const LabelOptions = @import("label_options.zig").LabelOptions;

/// The display options of a control.
pub const RelativeDateTimeControlDisplayOptions = struct {
    /// Customize how dates are formatted in controls.
    date_time_format: ?[]const u8 = null,

    /// The configuration of info icon label options.
    info_icon_label_options: ?SheetControlInfoIconLabelOptions = null,

    /// The options to configure the title visibility, name, and font size.
    title_options: ?LabelOptions = null,

    pub const json_field_names = .{
        .date_time_format = "DateTimeFormat",
        .info_icon_label_options = "InfoIconLabelOptions",
        .title_options = "TitleOptions",
    };
};
