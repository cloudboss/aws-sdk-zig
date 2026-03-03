const CustomImage = @import("custom_image.zig").CustomImage;
const ResourceSpec = @import("resource_spec.zig").ResourceSpec;

/// The KernelGateway app settings.
pub const KernelGatewayAppSettings = struct {
    /// A list of custom SageMaker AI images that are configured to run as a
    /// KernelGateway app.
    ///
    /// The maximum number of custom images are as follows.
    ///
    /// * On a domain level: 200
    /// * On a space level: 5
    /// * On a user profile level: 5
    custom_images: ?[]const CustomImage = null,

    /// The default instance type and the Amazon Resource Name (ARN) of the default
    /// SageMaker AI image used by the KernelGateway app.
    ///
    /// The Amazon SageMaker AI Studio UI does not use the default instance type
    /// value set here. The default instance type set here is used when Apps are
    /// created using the CLI or CloudFormation and the instance type parameter
    /// value is not passed.
    default_resource_spec: ?ResourceSpec = null,

    /// The Amazon Resource Name (ARN) of the Lifecycle Configurations attached to
    /// the the user profile or domain.
    ///
    /// To remove a Lifecycle Config, you must set `LifecycleConfigArns` to an empty
    /// list.
    lifecycle_config_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .custom_images = "CustomImages",
        .default_resource_spec = "DefaultResourceSpec",
        .lifecycle_config_arns = "LifecycleConfigArns",
    };
};
