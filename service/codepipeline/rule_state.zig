const RuleRevision = @import("rule_revision.zig").RuleRevision;
const RuleExecution = @import("rule_execution.zig").RuleExecution;

/// Returns information about the state of a rule.
///
/// Values returned in the `revisionId` field indicate the rule revision
/// information, such as the commit ID, for the current state.
pub const RuleState = struct {
    /// The ID of the current revision of the artifact successfully worked on by the
    /// job.
    current_revision: ?RuleRevision = null,

    /// A URL link for more information about the state of the action, such as a
    /// details
    /// page.
    entity_url: ?[]const u8 = null,

    /// Represents information about the latest run of an rule.
    latest_execution: ?RuleExecution = null,

    /// A URL link for more information about the revision, such as a commit details
    /// page.
    revision_url: ?[]const u8 = null,

    /// The name of the rule.
    rule_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .current_revision = "currentRevision",
        .entity_url = "entityUrl",
        .latest_execution = "latestExecution",
        .revision_url = "revisionUrl",
        .rule_name = "ruleName",
    };
};
