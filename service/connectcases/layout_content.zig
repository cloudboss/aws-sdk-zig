const BasicLayout = @import("basic_layout.zig").BasicLayout;

/// Object to store union of different versions of layout content.
pub const LayoutContent = union(enum) {
    /// Content specific to `BasicLayout` type. It configures fields in the top
    /// panel and More Info tab of Cases user interface.
    basic: ?BasicLayout,

    pub const json_field_names = .{
        .basic = "basic",
    };
};
