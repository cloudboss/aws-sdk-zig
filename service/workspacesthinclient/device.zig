const DeviceSoftwareSetComplianceStatus = @import("device_software_set_compliance_status.zig").DeviceSoftwareSetComplianceStatus;
const SoftwareSetUpdateSchedule = @import("software_set_update_schedule.zig").SoftwareSetUpdateSchedule;
const SoftwareSetUpdateStatus = @import("software_set_update_status.zig").SoftwareSetUpdateStatus;
const DeviceStatus = @import("device_status.zig").DeviceStatus;

/// Describes a thin client device.
pub const Device = struct {
    /// The Amazon Resource Name (ARN) of the device.
    arn: ?[]const u8 = null,

    /// The timestamp of when the device was created.
    created_at: ?i64 = null,

    /// The ID of the software set currently installed on the device.
    current_software_set_id: ?[]const u8 = null,

    /// The version of the software set currently installed on the device.
    current_software_set_version: ?[]const u8 = null,

    /// The ID of the software set which the device has been set to.
    desired_software_set_id: ?[]const u8 = null,

    /// The ID of the environment the device is associated with.
    environment_id: ?[]const u8 = null,

    /// The ID of the device.
    id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Key Management Service key used to
    /// encrypt the device.
    kms_key_arn: ?[]const u8 = null,

    /// The timestamp of the most recent session on the device.
    last_connected_at: ?i64 = null,

    /// The timestamp of the most recent check-in of the device.
    last_posture_at: ?i64 = null,

    /// The user ID of the most recent session on the device.
    last_user_id: ?[]const u8 = null,

    /// The model number of the device.
    model: ?[]const u8 = null,

    /// The name of the device.
    name: ?[]const u8 = null,

    /// The ID of the software set that is pending to be installed on the device.
    pending_software_set_id: ?[]const u8 = null,

    /// The version of the software set that is pending to be installed on the
    /// device.
    pending_software_set_version: ?[]const u8 = null,

    /// The hardware serial number of the device.
    serial_number: ?[]const u8 = null,

    /// Describes if the software currently installed on the device is a supported
    /// version.
    software_set_compliance_status: ?DeviceSoftwareSetComplianceStatus = null,

    /// An option to define if software updates should be applied within a
    /// maintenance window.
    software_set_update_schedule: ?SoftwareSetUpdateSchedule = null,

    /// Describes if the device has a supported version of software installed.
    software_set_update_status: ?SoftwareSetUpdateStatus = null,

    /// The status of the device.
    status: ?DeviceStatus = null,

    /// The timestamp of when the device was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .current_software_set_id = "currentSoftwareSetId",
        .current_software_set_version = "currentSoftwareSetVersion",
        .desired_software_set_id = "desiredSoftwareSetId",
        .environment_id = "environmentId",
        .id = "id",
        .kms_key_arn = "kmsKeyArn",
        .last_connected_at = "lastConnectedAt",
        .last_posture_at = "lastPostureAt",
        .last_user_id = "lastUserId",
        .model = "model",
        .name = "name",
        .pending_software_set_id = "pendingSoftwareSetId",
        .pending_software_set_version = "pendingSoftwareSetVersion",
        .serial_number = "serialNumber",
        .software_set_compliance_status = "softwareSetComplianceStatus",
        .software_set_update_schedule = "softwareSetUpdateSchedule",
        .software_set_update_status = "softwareSetUpdateStatus",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
