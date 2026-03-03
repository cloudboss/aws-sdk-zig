const ResourceSpec = @import("resource_spec.zig").ResourceSpec;

/// The TensorBoard app settings.
pub const TensorBoardAppSettings = struct {
    /// The default instance type and the Amazon Resource Name (ARN) of the
    /// SageMaker AI image created on the instance.
    default_resource_spec: ?ResourceSpec = null,

    pub const json_field_names = .{
        .default_resource_spec = "DefaultResourceSpec",
    };
};
