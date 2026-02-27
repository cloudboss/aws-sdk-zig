const FieldsForThemeGeneration = @import("fields_for_theme_generation.zig").FieldsForThemeGeneration;

/// The configuration details for generating themes with a batch inference job.
pub const ThemeGenerationConfig = struct {
    /// Fields used to generate descriptive themes for a batch inference job.
    fields_for_theme_generation: FieldsForThemeGeneration,

    pub const json_field_names = .{
        .fields_for_theme_generation = "fieldsForThemeGeneration",
    };
};
