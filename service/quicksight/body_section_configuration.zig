const BodySectionContent = @import("body_section_content.zig").BodySectionContent;
const SectionPageBreakConfiguration = @import("section_page_break_configuration.zig").SectionPageBreakConfiguration;
const BodySectionRepeatConfiguration = @import("body_section_repeat_configuration.zig").BodySectionRepeatConfiguration;
const SectionStyle = @import("section_style.zig").SectionStyle;

/// The configuration of a body section.
pub const BodySectionConfiguration = struct {
    /// The configuration of content in a body section.
    content: BodySectionContent,

    /// The configuration of a page break for a section.
    page_break_configuration: ?SectionPageBreakConfiguration,

    /// Describes the configurations that are required to declare a section as
    /// repeating.
    repeat_configuration: ?BodySectionRepeatConfiguration,

    /// The unique identifier of a body section.
    section_id: []const u8,

    /// The style options of a body section.
    style: ?SectionStyle,

    pub const json_field_names = .{
        .content = "Content",
        .page_break_configuration = "PageBreakConfiguration",
        .repeat_configuration = "RepeatConfiguration",
        .section_id = "SectionId",
        .style = "Style",
    };
};
