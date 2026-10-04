const SheetControlInfoIconLabelOptions = @import("sheet_control_info_icon_label_options.zig").SheetControlInfoIconLabelOptions;
const HierarchyFilterListControlSearchOptions = @import("hierarchy_filter_list_control_search_options.zig").HierarchyFilterListControlSearchOptions;
const LabelOptions = @import("label_options.zig").LabelOptions;

/// The display options of a control.
pub const HierarchyFilterListControlDisplayOptions = struct {
    /// The configuration of info icon label options.
    info_icon_label_options: ?SheetControlInfoIconLabelOptions = null,

    /// The configuration of the search options in a hierarchy list control.
    search_options: ?HierarchyFilterListControlSearchOptions = null,

    /// The options to configure the title visibility, name, and font size.
    title_options: ?LabelOptions = null,

    pub const json_field_names = .{
        .info_icon_label_options = "InfoIconLabelOptions",
        .search_options = "SearchOptions",
        .title_options = "TitleOptions",
    };
};
