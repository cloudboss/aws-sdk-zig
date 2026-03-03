const ActionDeclaration = @import("action_declaration.zig").ActionDeclaration;
const BeforeEntryConditions = @import("before_entry_conditions.zig").BeforeEntryConditions;
const BlockerDeclaration = @import("blocker_declaration.zig").BlockerDeclaration;
const FailureConditions = @import("failure_conditions.zig").FailureConditions;
const SuccessConditions = @import("success_conditions.zig").SuccessConditions;

/// Represents information about a stage and its definition.
pub const StageDeclaration = struct {
    /// The actions included in a stage.
    actions: []const ActionDeclaration,

    /// The method to use when a stage allows entry. For example, configuring this
    /// field for
    /// conditions will allow entry to the stage when the conditions are met.
    before_entry: ?BeforeEntryConditions = null,

    /// Reserved for future use.
    blockers: ?[]const BlockerDeclaration = null,

    /// The name of the stage.
    name: []const u8,

    /// The method to use when a stage has not completed successfully. For example,
    /// configuring this field for rollback will roll back a failed stage
    /// automatically to the
    /// last successful pipeline execution in the stage.
    on_failure: ?FailureConditions = null,

    /// The method to use when a stage has succeeded. For example, configuring this
    /// field for
    /// conditions will allow the stage to succeed when the conditions are met.
    on_success: ?SuccessConditions = null,

    pub const json_field_names = .{
        .actions = "actions",
        .before_entry = "beforeEntry",
        .blockers = "blockers",
        .name = "name",
        .on_failure = "onFailure",
        .on_success = "onSuccess",
    };
};
