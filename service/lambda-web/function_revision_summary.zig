const RevisionState = @import("revision_state.zig").RevisionState;

/// A summary of a web function revision.
pub const FunctionRevisionSummary = struct {
    /// The date and time the revision was created.
    created_at: i64,

    /// A description of the revision.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the revision.
    revision_arn: []const u8,

    /// The identifier of the revision.
    revision_id: []const u8,

    /// The current state of the revision.
    state: RevisionState,

    /// The reason for the current state of the revision.
    state_reason: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .revision_arn = "revisionArn",
        .revision_id = "revisionId",
        .state = "state",
        .state_reason = "stateReason",
    };
};
