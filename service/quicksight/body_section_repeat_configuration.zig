const BodySectionRepeatDimensionConfiguration = @import("body_section_repeat_dimension_configuration.zig").BodySectionRepeatDimensionConfiguration;
const BodySectionRepeatPageBreakConfiguration = @import("body_section_repeat_page_break_configuration.zig").BodySectionRepeatPageBreakConfiguration;

/// Describes the configurations that are required to declare a section as
/// repeating.
pub const BodySectionRepeatConfiguration = struct {
    /// List of `BodySectionRepeatDimensionConfiguration` values that describe the
    /// dataset column and constraints for the column used to repeat the contents of
    /// a section.
    dimension_configurations: ?[]const BodySectionRepeatDimensionConfiguration = null,

    /// List of visuals to exclude from repetition in repeating sections. The
    /// visuals will render identically, and ignore the repeating configurations in
    /// all repeating instances.
    non_repeating_visuals: ?[]const []const u8 = null,

    /// Page break configuration to apply for each repeating instance.
    page_break_configuration: ?BodySectionRepeatPageBreakConfiguration = null,

    pub const json_field_names = .{
        .dimension_configurations = "DimensionConfigurations",
        .non_repeating_visuals = "NonRepeatingVisuals",
        .page_break_configuration = "PageBreakConfiguration",
    };
};
