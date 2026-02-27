const ActionFailurePolicy = @import("action_failure_policy.zig").ActionFailurePolicy;

/// The action to archive the email by delivering the email to an Amazon SES
/// archive.
pub const ArchiveAction = struct {
    /// A policy that states what to do in the case of failure. The action will fail
    /// if there are configuration errors. For example, the specified archive has
    /// been deleted.
    action_failure_policy: ?ActionFailurePolicy,

    /// The identifier of the archive to send the email to.
    target_archive: []const u8,

    pub const json_field_names = .{
        .action_failure_policy = "ActionFailurePolicy",
        .target_archive = "TargetArchive",
    };
};
