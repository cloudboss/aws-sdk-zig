const PositioningConfigStatus = @import("positioning_config_status.zig").PositioningConfigStatus;
const SidewalkGetStartImportInfo = @import("sidewalk_get_start_import_info.zig").SidewalkGetStartImportInfo;
const ImportTaskStatus = @import("import_task_status.zig").ImportTaskStatus;

/// Information about an import task for wireless devices.
pub const WirelessDeviceImportTask = struct {
    /// The ARN (Amazon Resource Name) of the wireless device import task.
    arn: ?[]const u8,

    /// The time at which the import task was created.
    creation_time: ?i64,

    /// The name of the Sidewalk destination that that describes the IoT rule to
    /// route
    /// messages from the device in the import task that will be onboarded to AWS
    /// IoT
    /// Wireless
    destination_name: ?[]const u8,

    /// The summary information of count of wireless devices in an import task that
    /// failed to
    /// onboarded to the import task.
    failed_imported_device_count: ?i64,

    /// The ID of the wireless device import task.
    id: ?[]const u8,

    /// The summary information of count of wireless devices that are waiting for
    /// the control
    /// log to be added to an import task.
    initialized_imported_device_count: ?i64,

    /// The summary information of count of wireless devices in an import task that
    /// have been
    /// onboarded to the import task.
    onboarded_imported_device_count: ?i64,

    /// The summary information of count of wireless devices in an import task that
    /// are
    /// waiting in the queue to be onboarded.
    pending_imported_device_count: ?i64,

    /// The integration status of the Device Location feature for Sidewalk devices.
    positioning: ?PositioningConfigStatus,

    /// The Sidewalk-related information of the wireless device import task.
    sidewalk: ?SidewalkGetStartImportInfo,

    /// The status information of the wireless device import task.
    status: ?ImportTaskStatus,

    /// The reason that provides additional information about the import task
    /// status.
    status_reason: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .destination_name = "DestinationName",
        .failed_imported_device_count = "FailedImportedDeviceCount",
        .id = "Id",
        .initialized_imported_device_count = "InitializedImportedDeviceCount",
        .onboarded_imported_device_count = "OnboardedImportedDeviceCount",
        .pending_imported_device_count = "PendingImportedDeviceCount",
        .positioning = "Positioning",
        .sidewalk = "Sidewalk",
        .status = "Status",
        .status_reason = "StatusReason",
    };
};
