const SectionAfterPageBreak = @import("section_after_page_break.zig").SectionAfterPageBreak;

/// The configuration of a page break for a section.
pub const SectionPageBreakConfiguration = struct {
    /// The configuration of a page break after a section.
    after: ?SectionAfterPageBreak,

    pub const json_field_names = .{
        .after = "After",
    };
};
