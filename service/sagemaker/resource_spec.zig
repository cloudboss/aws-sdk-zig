const AppInstanceType = @import("app_instance_type.zig").AppInstanceType;

/// Specifies the ARN's of a SageMaker AI image and SageMaker AI image version,
/// and the instance type that the version runs on.
///
/// When both `SageMakerImageVersionArn` and `SageMakerImageArn` are passed,
/// `SageMakerImageVersionArn` is used. Any updates to `SageMakerImageArn` will
/// not take effect if `SageMakerImageVersionArn` already exists in the
/// `ResourceSpec` because `SageMakerImageVersionArn` always takes precedence.
/// To clear the value set for `SageMakerImageVersionArn`, pass `None` as the
/// value.
pub const ResourceSpec = struct {
    /// The instance type that the image version runs on.
    ///
    /// **JupyterServer apps** only support the `system` value.
    ///
    /// For **KernelGateway apps**, the `system` value is translated to
    /// `ml.t3.medium`. KernelGateway apps also support all other values for
    /// available instance types.
    instance_type: ?AppInstanceType,

    /// The Amazon Resource Name (ARN) of the Lifecycle Configuration attached to
    /// the Resource.
    lifecycle_config_arn: ?[]const u8,

    /// The ARN of the SageMaker AI image that the image version belongs to.
    sage_maker_image_arn: ?[]const u8,

    /// The SageMakerImageVersionAlias of the image to launch with. This value is in
    /// SemVer 2.0.0 versioning format.
    sage_maker_image_version_alias: ?[]const u8,

    /// The ARN of the image version created on the instance. To clear the value set
    /// for `SageMakerImageVersionArn`, pass `None` as the value.
    sage_maker_image_version_arn: ?[]const u8,

    pub const json_field_names = .{
        .instance_type = "InstanceType",
        .lifecycle_config_arn = "LifecycleConfigArn",
        .sage_maker_image_arn = "SageMakerImageArn",
        .sage_maker_image_version_alias = "SageMakerImageVersionAlias",
        .sage_maker_image_version_arn = "SageMakerImageVersionArn",
    };
};
