const Validation = @import("validation.zig").Validation;

/// Model-based metadata extraction configuration.
pub const LlmExtractionConfig = struct {
    /// Description of what this metadata field represents.
    definition: []const u8,

    /// Instructions for extraction. Supports built-in operators like LATEST_VALUE
    /// or custom natural-language instructions.
    llm_extraction_instruction: ?[]const u8 = null,

    /// Validation rules to constrain extracted values.
    validation: ?Validation = null,

    pub const json_field_names = .{
        .definition = "definition",
        .llm_extraction_instruction = "llmExtractionInstruction",
        .validation = "validation",
    };
};
