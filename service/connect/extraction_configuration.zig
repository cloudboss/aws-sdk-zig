const ExtractionDefinitionNotFoundBehavior = @import("extraction_definition_not_found_behavior.zig").ExtractionDefinitionNotFoundBehavior;

/// The extraction configuration that defines how data is extracted from
/// customer
/// interactions.
pub const ExtractionConfiguration = struct {
    /// The behavior when the extraction cannot find the specified data in the
    /// interaction.
    not_found_behavior: ?ExtractionDefinitionNotFoundBehavior = null,

    /// The prompt hint that guides the extraction. This text tells the generative
    /// AI model what
    /// data to look for in the customer interaction.
    prompt_hint: []const u8,

    pub const json_field_names = .{
        .not_found_behavior = "NotFoundBehavior",
        .prompt_hint = "PromptHint",
    };
};
