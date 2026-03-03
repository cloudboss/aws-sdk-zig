/// Summary of the device fleet.
pub const DeviceFleetSummary = struct {
    /// Timestamp of when the device fleet was created.
    creation_time: ?i64 = null,

    /// Amazon Resource Name (ARN) of the device fleet.
    device_fleet_arn: []const u8,

    /// Name of the device fleet.
    device_fleet_name: []const u8,

    /// Timestamp of when the device fleet was last updated.
    last_modified_time: ?i64 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .device_fleet_arn = "DeviceFleetArn",
        .device_fleet_name = "DeviceFleetName",
        .last_modified_time = "LastModifiedTime",
    };
};
