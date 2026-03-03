/// A resource to assign to a container.
pub const AwsEcsTaskDefinitionContainerDefinitionsResourceRequirementsDetails = struct {
    /// The type of resource to assign to a container. Valid values are `GPU` or
    /// `InferenceAccelerator`.
    @"type": ?[]const u8 = null,

    /// The value for the specified resource type.
    ///
    /// For `GPU`, the value is the number of physical GPUs the Amazon ECS container
    /// agent
    /// reserves for the container.
    ///
    /// For `InferenceAccelerator`, the value should match the `DeviceName`
    /// attribute of an entry in `InferenceAccelerators`.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .@"type" = "Type",
        .value = "Value",
    };
};
