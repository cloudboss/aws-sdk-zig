const DefaultSectionBasedLayoutConfiguration = @import("default_section_based_layout_configuration.zig").DefaultSectionBasedLayoutConfiguration;

/// The options that determine the default settings for a paginated layout
/// configuration.
pub const DefaultPaginatedLayoutConfiguration = struct {
    /// The options that determine the default settings for a section-based layout
    /// configuration.
    section_based: ?DefaultSectionBasedLayoutConfiguration,

    pub const json_field_names = .{
        .section_based = "SectionBased",
    };
};
