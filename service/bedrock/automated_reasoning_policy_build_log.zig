const AutomatedReasoningPolicyBuildLogEntry = @import("automated_reasoning_policy_build_log_entry.zig").AutomatedReasoningPolicyBuildLogEntry;

/// Contains detailed logging information about the policy build process,
/// including steps taken, decisions made, and any issues encountered.
pub const AutomatedReasoningPolicyBuildLog = struct {
    /// A list of log entries documenting each step in the policy build process,
    /// including timestamps, status, and detailed messages.
    entries: []const AutomatedReasoningPolicyBuildLogEntry,

    pub const json_field_names = .{
        .entries = "entries",
    };
};
