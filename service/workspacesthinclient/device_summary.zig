const SoftwareSetUpdateSchedule = @import("software_set_update_schedule.zig").SoftwareSetUpdateSchedule;
const DeviceStatus = @import("device_status.zig").DeviceStatus;

/// Describes a thin client device.
pub const DeviceSummary = struct {
    /// The Amazon Resource Name (ARN) of the device.
    arn: ?[]const u8,

    /// The timestamp of when the device was created.
    created_at: ?i64,

    /// The ID of the software set currently installed on the device.
    current_software_set_id: ?[]const u8,

    /// The ID of the software set which the device has been set to.
    desired_software_set_id: ?[]const u8,

    /// The ID of the environment the device is associated with.
    environment_id: ?[]const u8,

    /// The ID of the device.
    id: ?[]const u8,

    /// The timestamp of the most recent session on the device.
    last_connected_at: ?i64,

    /// The timestamp of the most recent check-in of the device.
    last_posture_at: ?i64,

    /// The user ID of the most recent session on the device.
    last_user_id: ?[]const u8,

    /// The model number of the device.
    model: ?[]const u8,

    /// The name of the device.
    name: ?[]const u8,

    /// The ID of the software set that is pending to be installed on the device.
    pending_software_set_id: ?[]const u8,

    /// The hardware serial number of the device.
    serial_number: ?[]const u8,

    /// An option to define if software updates should be applied within a
    /// maintenance window.
    software_set_update_schedule: ?SoftwareSetUpdateSchedule,

    /// The status of the device.
    status: ?DeviceStatus,

    /// The timestamp of when the device was updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .current_software_set_id = "currentSoftwareSetId",
        .desired_software_set_id = "desiredSoftwareSetId",
        .environment_id = "environmentId",
        .id = "id",
        .last_connected_at = "lastConnectedAt",
        .last_posture_at = "lastPostureAt",
        .last_user_id = "lastUserId",
        .model = "model",
        .name = "name",
        .pending_software_set_id = "pendingSoftwareSetId",
        .serial_number = "serialNumber",
        .software_set_update_schedule = "softwareSetUpdateSchedule",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
