const AIAgentSummary = @import("ai_agent_summary.zig").AIAgentSummary;

/// The summary of the AI Agent version.
pub const AIAgentVersionSummary = struct {
    /// The data for the summary of the AI Agent version.
    ai_agent_summary: ?AIAgentSummary,

    /// The version number for this AI Agent version.
    version_number: ?i64,

    pub const json_field_names = .{
        .ai_agent_summary = "aiAgentSummary",
        .version_number = "versionNumber",
    };
};
