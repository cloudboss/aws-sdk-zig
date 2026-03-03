const EdgeModelSummary = @import("edge_model_summary.zig").EdgeModelSummary;

/// Summary of the device.
pub const DeviceSummary = struct {
    /// Edge Manager agent version.
    agent_version: ?[]const u8 = null,

    /// A description of the device.
    description: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) of the device.
    device_arn: []const u8,

    /// The name of the fleet the device belongs to.
    device_fleet_name: ?[]const u8 = null,

    /// The unique identifier of the device.
    device_name: []const u8,

    /// The Amazon Web Services Internet of Things (IoT) object thing name
    /// associated with the device..
    iot_thing_name: ?[]const u8 = null,

    /// The last heartbeat received from the device.
    latest_heartbeat: ?i64 = null,

    /// Models on the device.
    models: ?[]const EdgeModelSummary = null,

    /// The timestamp of the last registration or de-reregistration.
    registration_time: ?i64 = null,

    pub const json_field_names = .{
        .agent_version = "AgentVersion",
        .description = "Description",
        .device_arn = "DeviceArn",
        .device_fleet_name = "DeviceFleetName",
        .device_name = "DeviceName",
        .iot_thing_name = "IotThingName",
        .latest_heartbeat = "LatestHeartbeat",
        .models = "Models",
        .registration_time = "RegistrationTime",
    };
};
