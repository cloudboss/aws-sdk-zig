const OptionState = @import("option_state.zig").OptionState;

/// Provides the current status of an entity.
pub const OptionStatus = struct {
    /// The timestamp when the entity was created.
    creation_date: i64,

    /// Indicates whether the entity is being deleted.
    pending_deletion: ?bool,

    /// The state of the entity.
    state: OptionState,

    /// The timestamp of the last time the entity was updated.
    update_date: i64,

    /// The latest version of the entity.
    update_version: i32 = 0,

    pub const json_field_names = .{
        .creation_date = "CreationDate",
        .pending_deletion = "PendingDeletion",
        .state = "State",
        .update_date = "UpdateDate",
        .update_version = "UpdateVersion",
    };
};
