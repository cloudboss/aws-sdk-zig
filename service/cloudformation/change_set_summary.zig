const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const ChangeSetStatus = @import("change_set_status.zig").ChangeSetStatus;

/// The `ChangeSetSummary` structure describes a change set, its status, and the
/// stack with which it's associated.
pub const ChangeSetSummary = struct {
    /// The ID of the change set.
    change_set_id: ?[]const u8,

    /// The name of the change set.
    change_set_name: ?[]const u8,

    /// The start time when the change set was created, in UTC.
    creation_time: ?i64,

    /// Descriptive information about the change set.
    description: ?[]const u8,

    /// If the change set execution status is `AVAILABLE`, you can execute the
    /// change
    /// set. If you can't execute the change set, the status indicates why. For
    /// example, a change set
    /// might be in an `UNAVAILABLE` state because CloudFormation is still creating
    /// it or in an
    /// `OBSOLETE` state because the stack was already updated.
    execution_status: ?ExecutionStatus,

    /// Indicates if the change set imports resources that already exist.
    import_existing_resources: ?bool,

    /// Specifies the current setting of `IncludeNestedStacks` for the change set.
    include_nested_stacks: ?bool,

    /// The parent change set ID.
    parent_change_set_id: ?[]const u8,

    /// The root change set ID.
    root_change_set_id: ?[]const u8,

    /// The ID of the stack with which the change set is associated.
    stack_id: ?[]const u8,

    /// The name of the stack with which the change set is associated.
    stack_name: ?[]const u8,

    /// The state of the change set, such as `CREATE_PENDING`,
    /// `CREATE_COMPLETE`, or `FAILED`.
    status: ?ChangeSetStatus,

    /// A description of the change set's status. For example, if your change set is
    /// in the
    /// `FAILED` state, CloudFormation shows the error message.
    status_reason: ?[]const u8,
};
