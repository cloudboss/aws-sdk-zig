const SheetControlInfoIconLabelOptions = @import("sheet_control_info_icon_label_options.zig").SheetControlInfoIconLabelOptions;
const TextControlPlaceholderOptions = @import("text_control_placeholder_options.zig").TextControlPlaceholderOptions;
const LabelOptions = @import("label_options.zig").LabelOptions;

/// The display options of a control.
pub const TextFieldControlDisplayOptions = struct {
    /// The configuration of info icon label options.
    info_icon_label_options: ?SheetControlInfoIconLabelOptions,

    /// The configuration of the placeholder options in a text field control.
    placeholder_options: ?TextControlPlaceholderOptions,

    /// The options to configure the title visibility, name, and font size.
    title_options: ?LabelOptions,

    pub const json_field_names = .{
        .info_icon_label_options = "InfoIconLabelOptions",
        .placeholder_options = "PlaceholderOptions",
        .title_options = "TitleOptions",
    };
};
