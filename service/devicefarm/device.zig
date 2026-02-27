const DeviceAvailability = @import("device_availability.zig").DeviceAvailability;
const CPU = @import("cpu.zig").CPU;
const DeviceFormFactor = @import("device_form_factor.zig").DeviceFormFactor;
const DeviceInstance = @import("device_instance.zig").DeviceInstance;
const DevicePlatform = @import("device_platform.zig").DevicePlatform;
const Resolution = @import("resolution.zig").Resolution;

/// Represents a device type that an app is tested against.
pub const Device = struct {
    /// The device's ARN.
    arn: ?[]const u8,

    /// Indicates how likely a device is available for a test run. Currently
    /// available in the ListDevices and GetDevice API methods.
    availability: ?DeviceAvailability,

    /// The device's carrier.
    carrier: ?[]const u8,

    /// Information about the device's CPU.
    cpu: ?CPU,

    /// The name of the fleet to which this device belongs.
    fleet_name: ?[]const u8,

    /// The type of fleet to which this device belongs. Possible values are PRIVATE
    /// and PUBLIC.
    fleet_type: ?[]const u8,

    /// The device's form factor.
    ///
    /// Allowed values include:
    ///
    /// * PHONE
    ///
    /// * TABLET
    form_factor: ?DeviceFormFactor,

    /// The device's heap size, expressed in bytes.
    heap_size: ?i64,

    /// The device's image name.
    image: ?[]const u8,

    /// The instances that belong to this device.
    instances: ?[]const DeviceInstance,

    /// The device's manufacturer name.
    manufacturer: ?[]const u8,

    /// The device's total memory size, expressed in bytes.
    memory: ?i64,

    /// The device's model name.
    model: ?[]const u8,

    /// The device's model ID.
    model_id: ?[]const u8,

    /// The device's display name.
    name: ?[]const u8,

    /// The device's operating system type.
    os: ?[]const u8,

    /// The device's platform.
    ///
    /// Allowed values include:
    ///
    /// * ANDROID
    ///
    /// * IOS
    platform: ?DevicePlatform,

    /// The device's radio.
    radio: ?[]const u8,

    /// Specifies whether remote access has been enabled for the specified
    /// device.
    remote_access_enabled: ?bool,

    /// This flag is set to `true` if remote debugging is enabled for the
    /// device.
    ///
    /// Remote debugging is [no
    /// longer
    /// supported](https://docs.aws.amazon.com/devicefarm/latest/developerguide/history.html).
    remote_debug_enabled: ?bool,

    /// The resolution of the device.
    resolution: ?Resolution,

    pub const json_field_names = .{
        .arn = "arn",
        .availability = "availability",
        .carrier = "carrier",
        .cpu = "cpu",
        .fleet_name = "fleetName",
        .fleet_type = "fleetType",
        .form_factor = "formFactor",
        .heap_size = "heapSize",
        .image = "image",
        .instances = "instances",
        .manufacturer = "manufacturer",
        .memory = "memory",
        .model = "model",
        .model_id = "modelId",
        .name = "name",
        .os = "os",
        .platform = "platform",
        .radio = "radio",
        .remote_access_enabled = "remoteAccessEnabled",
        .remote_debug_enabled = "remoteDebugEnabled",
        .resolution = "resolution",
    };
};
