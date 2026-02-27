const SheetControlInfoIconLabelOptions = @import("sheet_control_info_icon_label_options.zig").SheetControlInfoIconLabelOptions;
const ListControlSelectAllOptions = @import("list_control_select_all_options.zig").ListControlSelectAllOptions;
const LabelOptions = @import("label_options.zig").LabelOptions;

/// The display options of a control.
pub const DropDownControlDisplayOptions = struct {
    /// The configuration of info icon label options.
    info_icon_label_options: ?SheetControlInfoIconLabelOptions,

    /// The configuration of the `Select all` options in a
    /// dropdown control.
    select_all_options: ?ListControlSelectAllOptions,

    /// The options to configure the title visibility, name, and font size.
    title_options: ?LabelOptions,

    pub const json_field_names = .{
        .info_icon_label_options = "InfoIconLabelOptions",
        .select_all_options = "SelectAllOptions",
        .title_options = "TitleOptions",
    };
};
