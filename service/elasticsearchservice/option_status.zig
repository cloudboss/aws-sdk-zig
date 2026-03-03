const OptionState = @import("option_state.zig").OptionState;

/// Provides the current status of the entity.
pub const OptionStatus = struct {
    /// Timestamp which tells the creation date for the entity.
    creation_date: i64,

    /// Indicates whether the Elasticsearch domain is being deleted.
    pending_deletion: ?bool = null,

    /// Provides the `OptionState` for the Elasticsearch domain.
    state: OptionState,

    /// Timestamp which tells the last updated time for the entity.
    update_date: i64,

    /// Specifies the latest version for the entity.
    update_version: i32 = 0,

    pub const json_field_names = .{
        .creation_date = "CreationDate",
        .pending_deletion = "PendingDeletion",
        .state = "State",
        .update_date = "UpdateDate",
        .update_version = "UpdateVersion",
    };
};
