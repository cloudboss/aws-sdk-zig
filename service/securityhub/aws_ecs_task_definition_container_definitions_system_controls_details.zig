/// A namespaced kernel parameter to set in the container.
pub const AwsEcsTaskDefinitionContainerDefinitionsSystemControlsDetails = struct {
    /// The namespaced kernel parameter for which to set a value.
    namespace: ?[]const u8,

    /// The value of the parameter.
    value: ?[]const u8,

    pub const json_field_names = .{
        .namespace = "Namespace",
        .value = "Value",
    };
};
