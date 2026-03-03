/// Details on an Elastic Inference accelerator task override. This parameter is
/// used to
/// override the Elastic Inference accelerator specified in the task definition.
/// For more
/// information, see [Working with Amazon Elastic
/// Inference on Amazon
/// ECS](https://docs.aws.amazon.com/AmazonECS/latest/userguide/ecs-inference.html) in the *Amazon Elastic Container Service
/// Developer Guide*.
pub const EcsInferenceAcceleratorOverride = struct {
    /// The Elastic Inference accelerator device name to override for the task. This
    /// parameter
    /// must match a `deviceName` specified in the task definition.
    device_name: ?[]const u8 = null,

    /// The Elastic Inference accelerator type to use.
    device_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .device_name = "deviceName",
        .device_type = "deviceType",
    };
};
