const ScopeDecision = @import("scope_decision.zig").ScopeDecision;

/// The outcome of scoping a CI/CD pentest job's code changes, including the
/// decision and the reason for it.
pub const ScopeResult = struct {
    /// The scoping decision for the job's code changes.
    decision: ScopeDecision,

    /// A human-readable explanation of the scoping decision.
    reason: []const u8,

    pub const json_field_names = .{
        .decision = "decision",
        .reason = "reason",
    };
};
