const ActionRevision = @import("action_revision.zig").ActionRevision;
const ActionExecution = @import("action_execution.zig").ActionExecution;

/// Represents information about the state of an action.
pub const ActionState = struct {
    /// The name of the action.
    action_name: ?[]const u8 = null,

    /// Represents information about the version (or revision) of an action.
    current_revision: ?ActionRevision = null,

    /// A URL link for more information about the state of the action, such as a
    /// deployment
    /// group details page.
    entity_url: ?[]const u8 = null,

    /// Represents information about the run of an action.
    latest_execution: ?ActionExecution = null,

    /// A URL link for more information about the revision, such as a commit details
    /// page.
    revision_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_name = "actionName",
        .current_revision = "currentRevision",
        .entity_url = "entityUrl",
        .latest_execution = "latestExecution",
        .revision_url = "revisionUrl",
    };
};
