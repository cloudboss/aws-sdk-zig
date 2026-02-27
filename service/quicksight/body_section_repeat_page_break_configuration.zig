const SectionAfterPageBreak = @import("section_after_page_break.zig").SectionAfterPageBreak;

/// The page break configuration to apply for each repeating instance.
pub const BodySectionRepeatPageBreakConfiguration = struct {
    after: ?SectionAfterPageBreak,

    pub const json_field_names = .{
        .after = "After",
    };
};
