const AIPromptSummary = @import("ai_prompt_summary.zig").AIPromptSummary;

/// The summary of the AI Prompt version.
pub const AIPromptVersionSummary = struct {
    /// The date for the summary of the AI Prompt version.
    ai_prompt_summary: ?AIPromptSummary,

    /// The version number for this AI Prompt version.
    version_number: ?i64,

    pub const json_field_names = .{
        .ai_prompt_summary = "aiPromptSummary",
        .version_number = "versionNumber",
    };
};
