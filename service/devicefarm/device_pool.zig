const Rule = @import("rule.zig").Rule;
const DevicePoolType = @import("device_pool_type.zig").DevicePoolType;

/// Represents a collection of device types.
pub const DevicePool = struct {
    /// The device pool's ARN.
    arn: ?[]const u8,

    /// The device pool's description.
    description: ?[]const u8,

    /// The number of devices that Device Farm can add to your device pool. Device
    /// Farm adds devices that are
    /// available and meet the criteria that you assign for the `rules` parameter.
    /// Depending on how many
    /// devices meet these constraints, your device pool might contain fewer devices
    /// than the value for this
    /// parameter.
    ///
    /// By specifying the maximum number of devices, you can control the costs that
    /// you incur
    /// by running tests.
    max_devices: ?i32,

    /// The device pool's name.
    name: ?[]const u8,

    /// Information about the device pool's rules.
    rules: ?[]const Rule,

    /// The device pool's type.
    ///
    /// Allowed values include:
    ///
    /// * CURATED: A device pool that is created and managed by AWS Device
    /// Farm.
    ///
    /// * PRIVATE: A device pool that is created and managed by the device pool
    /// developer.
    @"type": ?DevicePoolType,

    pub const json_field_names = .{
        .arn = "arn",
        .description = "description",
        .max_devices = "maxDevices",
        .name = "name",
        .rules = "rules",
        .@"type" = "type",
    };
};
