const SheetControlInfoIconLabelOptions = @import("sheet_control_info_icon_label_options.zig").SheetControlInfoIconLabelOptions;
const LabelOptions = @import("label_options.zig").LabelOptions;

/// The display options of a control.
pub const SliderControlDisplayOptions = struct {
    /// The configuration of info icon label options.
    info_icon_label_options: ?SheetControlInfoIconLabelOptions,

    /// The options to configure the title visibility, name, and font size.
    title_options: ?LabelOptions,

    pub const json_field_names = .{
        .info_icon_label_options = "InfoIconLabelOptions",
        .title_options = "TitleOptions",
    };
};
