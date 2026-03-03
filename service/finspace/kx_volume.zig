const KxAzMode = @import("kx_az_mode.zig").KxAzMode;
const KxVolumeStatus = @import("kx_volume_status.zig").KxVolumeStatus;
const KxVolumeType = @import("kx_volume_type.zig").KxVolumeType;

/// The structure that contains the metadata of the volume.
pub const KxVolume = struct {
    /// The identifier of the availability zones.
    availability_zone_ids: ?[]const []const u8 = null,

    /// The number of availability zones you want to assign per volume. Currently,
    /// FinSpace only supports `SINGLE` for volumes. This places dataview in a
    /// single AZ.
    az_mode: ?KxAzMode = null,

    /// The timestamp at which the volume was created in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    created_timestamp: ?i64 = null,

    /// A description of the volume.
    description: ?[]const u8 = null,

    /// The last time that the volume was updated in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    last_modified_timestamp: ?i64 = null,

    /// The status of volume.
    ///
    /// * CREATING – The volume creation is in progress.
    ///
    /// * CREATE_FAILED – The volume creation has failed.
    ///
    /// * ACTIVE – The volume is active.
    ///
    /// * UPDATING – The volume is in the process of being updated.
    ///
    /// * UPDATE_FAILED – The update action failed.
    ///
    /// * UPDATED – The volume is successfully updated.
    ///
    /// * DELETING – The volume is in the process of being deleted.
    ///
    /// * DELETE_FAILED – The system failed to delete the volume.
    ///
    /// * DELETED – The volume is successfully deleted.
    status: ?KxVolumeStatus = null,

    /// The error message when a failed state occurs.
    status_reason: ?[]const u8 = null,

    /// A unique identifier for the volume.
    volume_name: ?[]const u8 = null,

    /// The type of file system volume. Currently, FinSpace only supports `NAS_1`
    /// volume type.
    volume_type: ?KxVolumeType = null,

    pub const json_field_names = .{
        .availability_zone_ids = "availabilityZoneIds",
        .az_mode = "azMode",
        .created_timestamp = "createdTimestamp",
        .description = "description",
        .last_modified_timestamp = "lastModifiedTimestamp",
        .status = "status",
        .status_reason = "statusReason",
        .volume_name = "volumeName",
        .volume_type = "volumeType",
    };
};
