const SectionLayoutConfiguration = @import("section_layout_configuration.zig").SectionLayoutConfiguration;
const SectionStyle = @import("section_style.zig").SectionStyle;

/// The configuration of a header or footer section.
pub const HeaderFooterSectionConfiguration = struct {
    /// The layout configuration of the header or footer section.
    layout: SectionLayoutConfiguration,

    /// The unique identifier of the header or footer section.
    section_id: []const u8,

    /// The style options of a header or footer section.
    style: ?SectionStyle = null,

    pub const json_field_names = .{
        .layout = "Layout",
        .section_id = "SectionId",
        .style = "Style",
    };
};
