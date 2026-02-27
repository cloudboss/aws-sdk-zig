/// An Elastic Inference accelerator to use
/// for the containers in the task.
pub const AwsEcsTaskDefinitionInferenceAcceleratorsDetails = struct {
    /// The Elastic Inference accelerator device name.
    device_name: ?[]const u8,

    /// The Elastic Inference accelerator type to use.
    device_type: ?[]const u8,

    pub const json_field_names = .{
        .device_name = "DeviceName",
        .device_type = "DeviceType",
    };
};
