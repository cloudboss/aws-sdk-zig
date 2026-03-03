const InstanceProfile = @import("instance_profile.zig").InstanceProfile;
const InstanceStatus = @import("instance_status.zig").InstanceStatus;

/// Represents the device instance.
pub const DeviceInstance = struct {
    /// The Amazon Resource Name (ARN) of the device instance.
    arn: ?[]const u8 = null,

    /// The ARN of the device.
    device_arn: ?[]const u8 = null,

    /// A object that contains information about the instance profile.
    instance_profile: ?InstanceProfile = null,

    /// An array of strings that describe the device instance.
    labels: ?[]const []const u8 = null,

    /// The status of the device instance. Valid values are listed here.
    status: ?InstanceStatus = null,

    /// Unique device identifier for the device instance.
    udid: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .device_arn = "deviceArn",
        .instance_profile = "instanceProfile",
        .labels = "labels",
        .status = "status",
        .udid = "udid",
    };
};
