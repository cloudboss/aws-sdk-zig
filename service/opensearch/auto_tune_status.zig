const AutoTuneState = @import("auto_tune_state.zig").AutoTuneState;

/// The current status of Auto-Tune for the domain. For more information, see
/// [Auto-Tune for Amazon OpenSearch
/// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/auto-tune.html).
pub const AutoTuneStatus = struct {
    /// Date and time when Auto-Tune was enabled for the domain.
    creation_date: i64,

    /// Any errors that occurred while enabling or disabling Auto-Tune.
    error_message: ?[]const u8,

    /// Indicates whether the domain is being deleted.
    pending_deletion: ?bool,

    /// The current state of Auto-Tune on the domain.
    state: AutoTuneState,

    /// Date and time when the Auto-Tune options were last updated for the domain.
    update_date: i64,

    /// The latest version of the Auto-Tune options.
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
