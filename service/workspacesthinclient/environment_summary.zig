const DesktopType = @import("desktop_type.zig").DesktopType;
const MaintenanceWindow = @import("maintenance_window.zig").MaintenanceWindow;
const SoftwareSetUpdateMode = @import("software_set_update_mode.zig").SoftwareSetUpdateMode;
const SoftwareSetUpdateSchedule = @import("software_set_update_schedule.zig").SoftwareSetUpdateSchedule;

/// Describes an environment.
pub const EnvironmentSummary = struct {
    /// The activation code to register a device to the environment.
    activation_code: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the environment.
    arn: ?[]const u8 = null,

    /// The timestamp of when the environment was created.
    created_at: ?i64 = null,

    /// The ID of the software set to apply.
    desired_software_set_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the desktop to stream from Amazon
    /// WorkSpaces, WorkSpaces Secure Browser, or AppStream 2.0.
    desktop_arn: ?[]const u8 = null,

    /// The URL for the identity provider login (only for environments that use
    /// AppStream 2.0).
    desktop_endpoint: ?[]const u8 = null,

    /// The type of streaming desktop for the environment.
    desktop_type: ?DesktopType = null,

    /// The ID of the environment.
    id: ?[]const u8 = null,

    /// A specification for a time window to apply software updates.
    maintenance_window: ?MaintenanceWindow = null,

    /// The name of the environment.
    name: ?[]const u8 = null,

    /// The ID of the software set that is pending to be installed.
    pending_software_set_id: ?[]const u8 = null,

    /// An option to define which software updates to apply.
    software_set_update_mode: ?SoftwareSetUpdateMode = null,

    /// An option to define if software updates should be applied within a
    /// maintenance window.
    software_set_update_schedule: ?SoftwareSetUpdateSchedule = null,

    /// The timestamp of when the device was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .activation_code = "activationCode",
        .arn = "arn",
        .created_at = "createdAt",
        .desired_software_set_id = "desiredSoftwareSetId",
        .desktop_arn = "desktopArn",
        .desktop_endpoint = "desktopEndpoint",
        .desktop_type = "desktopType",
        .id = "id",
        .maintenance_window = "maintenanceWindow",
        .name = "name",
        .pending_software_set_id = "pendingSoftwareSetId",
        .software_set_update_mode = "softwareSetUpdateMode",
        .software_set_update_schedule = "softwareSetUpdateSchedule",
        .updated_at = "updatedAt",
    };
};
