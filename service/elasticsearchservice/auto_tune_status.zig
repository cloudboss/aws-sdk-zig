const AutoTuneState = @import("auto_tune_state.zig").AutoTuneState;

/// Provides the current status of the Auto-Tune options.
pub const AutoTuneStatus = struct {
    /// Timestamp which tells Auto-Tune options creation date .
    creation_date: i64,

    /// Specifies the error message while enabling or disabling the Auto-Tune
    /// options.
    error_message: ?[]const u8,

    /// Indicates whether the Elasticsearch domain is being deleted.
    pending_deletion: ?bool,

    /// Specifies the `AutoTuneState` for the Elasticsearch domain.
    state: AutoTuneState,

    /// Timestamp which tells Auto-Tune options last updated time.
    update_date: i64,

    /// Specifies the Auto-Tune options latest version.
    update_version: i32 = 0,

    pub const json_field_names = .{
        .creation_date = "CreationDate",
        .error_message = "ErrorMessage",
        .pending_deletion = "PendingDeletion",
        .state = "State",
        .update_date = "UpdateDate",
        .update_version = "UpdateVersion",
    };
};
