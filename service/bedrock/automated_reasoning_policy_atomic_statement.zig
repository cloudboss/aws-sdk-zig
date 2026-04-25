const AutomatedReasoningPolicyStatementLocation = @import("automated_reasoning_policy_statement_location.zig").AutomatedReasoningPolicyStatementLocation;

/// Represents a single, indivisible statement extracted from a source document.
/// Atomic statements are the fundamental units used to ground policy rules and
/// variables to their source material.
pub const AutomatedReasoningPolicyAtomicStatement = struct {
    /// A unique identifier for this atomic statement within the fidelity report.
    id: []const u8,

    /// Information about where this statement appears in the source document,
    /// including line numbers.
    location: AutomatedReasoningPolicyStatementLocation,

    /// The actual text content of the atomic statement as extracted from the source
    /// document.
    text: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .location = "location",
        .text = "text",
    };
};
