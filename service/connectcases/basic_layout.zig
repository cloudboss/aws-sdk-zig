const LayoutSections = @import("layout_sections.zig").LayoutSections;

/// Content specific to `BasicLayout` type. It configures fields in the top
/// panel and More Info tab of agent application.
pub const BasicLayout = struct {
    /// This represents sections in a tab of the page layout.
    more_info: ?LayoutSections = null,

    /// This represents sections in a panel of the page layout.
    top_panel: ?LayoutSections = null,

    pub const json_field_names = .{
        .more_info = "moreInfo",
        .top_panel = "topPanel",
    };
};
