const aws = @import("aws");

const DesktopType = @import("desktop_type.zig").DesktopType;
const MaintenanceWindow = @import("maintenance_window.zig").MaintenanceWindow;
const EnvironmentSoftwareSetComplianceStatus = @import("environment_software_set_compliance_status.zig").EnvironmentSoftwareSetComplianceStatus;
const SoftwareSetUpdateMode = @import("software_set_update_mode.zig").SoftwareSetUpdateMode;
const SoftwareSetUpdateSchedule = @import("software_set_update_schedule.zig").SoftwareSetUpdateSchedule;

/// Describes an environment.
pub const Environment = struct {
    /// The activation code to register a device to the environment.
    activation_code: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the environment.
    arn: ?[]const u8,

    /// The timestamp of when the environment was created.
    created_at: ?i64,

    /// The ID of the software set to apply.
    desired_software_set_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the desktop to stream from Amazon
    /// WorkSpaces, WorkSpaces Secure Browser, or AppStream 2.0.
    desktop_arn: ?[]const u8,

    /// The URL for the identity provider login (only for environments that use
    /// AppStream 2.0).
    desktop_endpoint: ?[]const u8,

    /// The type of streaming desktop for the environment.
    desktop_type: ?DesktopType,

    /// The tag keys and optional values for the newly created devices for this
    /// environment.
    device_creation_tags: ?[]const aws.map.StringMapEntry,

    /// The ID of the environment.
    id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the Key Management Service key used to
    /// encrypt the environment.
    kms_key_arn: ?[]const u8,

    /// A specification for a time window to apply software updates.
    maintenance_window: ?MaintenanceWindow,

    /// The name of the environment.
    name: ?[]const u8,

    /// The ID of the software set that is pending to be installed.
    pending_software_set_id: ?[]const u8,

    /// The version of the software set that is pending to be installed.
    pending_software_set_version: ?[]const u8,

    /// The number of devices registered to the environment.
    registered_devices_count: ?i32,

    /// Describes if the software currently installed on all devices in the
    /// environment is a supported version.
    software_set_compliance_status: ?EnvironmentSoftwareSetComplianceStatus,

    /// An option to define which software updates to apply.
    software_set_update_mode: ?SoftwareSetUpdateMode,

    /// An option to define if software updates should be applied within a
    /// maintenance window.
    software_set_update_schedule: ?SoftwareSetUpdateSchedule,

    /// The timestamp of when the device was updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .activation_code = "activationCode",
        .arn = "arn",
        .created_at = "createdAt",
        .desired_software_set_id = "desiredSoftwareSetId",
        .desktop_arn = "desktopArn",
        .desktop_endpoint = "desktopEndpoint",
        .desktop_type = "desktopType",
        .device_creation_tags = "deviceCreationTags",
        .id = "id",
        .kms_key_arn = "kmsKeyArn",
        .maintenance_window = "maintenanceWindow",
        .name = "name",
        .pending_software_set_id = "pendingSoftwareSetId",
        .pending_software_set_version = "pendingSoftwareSetVersion",
        .registered_devices_count = "registeredDevicesCount",
        .software_set_compliance_status = "softwareSetComplianceStatus",
        .software_set_update_mode = "softwareSetUpdateMode",
        .software_set_update_schedule = "softwareSetUpdateSchedule",
        .updated_at = "updatedAt",
    };
};
