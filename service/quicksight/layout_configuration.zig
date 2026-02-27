const FreeFormLayoutConfiguration = @import("free_form_layout_configuration.zig").FreeFormLayoutConfiguration;
const GridLayoutConfiguration = @import("grid_layout_configuration.zig").GridLayoutConfiguration;
const SectionBasedLayoutConfiguration = @import("section_based_layout_configuration.zig").SectionBasedLayoutConfiguration;

/// The configuration that determines what the type of layout will be used on a
/// sheet.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const LayoutConfiguration = struct {
    /// A free-form is optimized for a fixed width and has more control over the
    /// exact placement of layout elements.
    free_form_layout: ?FreeFormLayoutConfiguration,

    /// A type of layout that can be used on a sheet. In a grid layout, visuals snap
    /// to a grid with standard spacing and alignment. Dashboards are displayed as
    /// designed, with options to fit to screen or view at actual size. A grid
    /// layout can be configured to behave in one of two ways when the viewport is
    /// resized: `FIXED` or `RESPONSIVE`.
    grid_layout: ?GridLayoutConfiguration,

    /// A section based layout organizes visuals into multiple sections and has
    /// customized header, footer and page break.
    section_based_layout: ?SectionBasedLayoutConfiguration,

    pub const json_field_names = .{
        .free_form_layout = "FreeFormLayout",
        .grid_layout = "GridLayout",
        .section_based_layout = "SectionBasedLayout",
    };
};
