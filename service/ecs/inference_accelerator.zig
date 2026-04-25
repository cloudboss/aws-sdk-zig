/// Details on an Elastic Inference accelerator. For more information, see
/// [Working with Amazon Elastic Inference on Amazon
/// ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-inference.html) in the *Amazon Elastic Container Service Developer Guide*.
pub const InferenceAccelerator = struct {
    /// The Elastic Inference accelerator device name. The `deviceName` must also be
    /// referenced in a container definition as a
    /// [ResourceRequirement](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ResourceRequirement.html).
    device_name: []const u8,

    /// The Elastic Inference accelerator type to use.
    device_type: []const u8,

    pub const json_field_names = .{
        .device_name = "deviceName",
        .device_type = "deviceType",
    };
};
