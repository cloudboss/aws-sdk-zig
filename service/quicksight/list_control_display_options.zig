const SheetControlInfoIconLabelOptions = @import("sheet_control_info_icon_label_options.zig").SheetControlInfoIconLabelOptions;
const ListControlSearchOptions = @import("list_control_search_options.zig").ListControlSearchOptions;
const ListControlSelectAllOptions = @import("list_control_select_all_options.zig").ListControlSelectAllOptions;
const LabelOptions = @import("label_options.zig").LabelOptions;

/// The display options of a control.
pub const ListControlDisplayOptions = struct {
    /// The configuration of info icon label options.
    info_icon_label_options: ?SheetControlInfoIconLabelOptions = null,

    /// The configuration of the search options in a list control.
    search_options: ?ListControlSearchOptions = null,

    /// The configuration of the `Select all` options in a list control.
    select_all_options: ?ListControlSelectAllOptions = null,

    /// The options to configure the title visibility, name, and font size.
    title_options: ?LabelOptions = null,

    pub const json_field_names = .{
        .info_icon_label_options = "InfoIconLabelOptions",
        .search_options = "SearchOptions",
        .select_all_options = "SelectAllOptions",
        .title_options = "TitleOptions",
    };
};
