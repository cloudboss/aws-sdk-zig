const UpdateValue = @import("update_value.zig").UpdateValue;
const UpdateStatus = @import("update_status.zig").UpdateStatus;

/// An entry of update information related to a requested update type.
pub const UpdateInfoEntry = struct {
    /// This specifies if the update was initiated by the customer or by the service
    /// team.
    initiated_by: ?[]const u8,

    /// The last updated date and time of a particular directory setting.
    last_updated_date_time: ?i64,

    /// The new value of the target setting.
    new_value: ?UpdateValue,

    /// The old value of the target setting.
    previous_value: ?UpdateValue,

    /// The name of the Region.
    region: ?[]const u8,

    /// The start time of the `UpdateDirectorySetup` for the particular type.
    start_time: ?i64,

    /// The status of the update performed on the directory.
    status: ?UpdateStatus,

    /// The reason for the current status of the update type activity.
    status_reason: ?[]const u8,

    pub const json_field_names = .{
        .initiated_by = "InitiatedBy",
        .last_updated_date_time = "LastUpdatedDateTime",
        .new_value = "NewValue",
        .previous_value = "PreviousValue",
        .region = "Region",
        .start_time = "StartTime",
        .status = "Status",
        .status_reason = "StatusReason",
    };
};
