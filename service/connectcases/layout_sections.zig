const Section = @import("section.zig").Section;

/// Ordered list containing different kinds of sections that can be added. A
/// LayoutSections object can only contain one section.
pub const LayoutSections = struct {
    sections: ?[]const Section = null,

    pub const json_field_names = .{
        .sections = "sections",
    };
};
