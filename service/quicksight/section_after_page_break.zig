const SectionPageBreakStatus = @import("section_page_break_status.zig").SectionPageBreakStatus;

/// The configuration of a page break after a section.
pub const SectionAfterPageBreak = struct {
    /// The option that enables or disables a page break at the end of a section.
    status: ?SectionPageBreakStatus = null,

    pub const json_field_names = .{
        .status = "Status",
    };
};
