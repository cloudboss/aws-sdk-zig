const HybridUpdateValue = @import("hybrid_update_value.zig").HybridUpdateValue;
const UpdateStatus = @import("update_status.zig").UpdateStatus;

/// Contains detailed information about a specific update activity for a hybrid
/// directory
/// component.
pub const HybridUpdateInfoEntry = struct {
    /// The identifier of the assessment performed to validate this update
    /// configuration.
    assessment_id: ?[]const u8 = null,

    /// Specifies if the update was initiated by the customer or Amazon Web
    /// Services.
    initiated_by: ?[]const u8 = null,

    /// The date and time when the update activity status was last updated.
    last_updated_date_time: ?i64 = null,

    /// The new configuration values being applied in this update.
    new_value: ?HybridUpdateValue = null,

    /// The previous configuration values before this update was applied.
    previous_value: ?HybridUpdateValue = null,

    /// The date and time when the update activity was initiated.
    start_time: ?i64 = null,

    /// The current status of the update activity. Valid values include `UPDATED`,
    /// `UPDATING`, and `UPDATE_FAILED`.
    status: ?UpdateStatus = null,

    /// A human-readable description of the update status, including any error
    /// details or
    /// progress information.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .assessment_id = "AssessmentId",
        .initiated_by = "InitiatedBy",
        .last_updated_date_time = "LastUpdatedDateTime",
        .new_value = "NewValue",
        .previous_value = "PreviousValue",
        .start_time = "StartTime",
        .status = "Status",
        .status_reason = "StatusReason",
    };
};
