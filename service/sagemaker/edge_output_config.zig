const EdgePresetDeploymentType = @import("edge_preset_deployment_type.zig").EdgePresetDeploymentType;

/// The output configuration.
pub const EdgeOutputConfig = struct {
    /// The Amazon Web Services Key Management Service (Amazon Web Services KMS) key
    /// that Amazon SageMaker uses to encrypt data on the storage volume after
    /// compilation job. If you don't provide a KMS key ID, Amazon SageMaker uses
    /// the default KMS key for Amazon S3 for your role's account.
    kms_key_id: ?[]const u8 = null,

    /// The configuration used to create deployment artifacts. Specify configuration
    /// options with a JSON string. The available configuration options for each
    /// type are:
    ///
    /// * `ComponentName` (optional) - Name of the GreenGrass V2 component. If not
    ///   specified, the default name generated consists of "SagemakerEdgeManager"
    ///   and the name of your SageMaker Edge Manager packaging job.
    /// * `ComponentDescription` (optional) - Description of the component.
    /// * `ComponentVersion` (optional) - The version of the component.
    ///
    /// Amazon Web Services IoT Greengrass uses semantic versions for components.
    /// Semantic versions follow a* major.minor.patch* number system. For example,
    /// version 1.0.0 represents the first major release for a component. For more
    /// information, see the [semantic version specification](https://semver.org/).
    /// * `PlatformOS` (optional) - The name of the operating system for the
    ///   platform. Supported platforms include Windows and Linux.
    /// * `PlatformArchitecture` (optional) - The processor architecture for the
    ///   platform.
    ///
    /// Supported architectures Windows include: Windows32_x86, Windows64_x64.
    ///
    /// Supported architectures for Linux include: Linux x86_64, Linux ARMV8.
    preset_deployment_config: ?[]const u8 = null,

    /// The deployment type SageMaker Edge Manager will create. Currently only
    /// supports Amazon Web Services IoT Greengrass Version 2 components.
    preset_deployment_type: ?EdgePresetDeploymentType = null,

    /// The Amazon Simple Storage (S3) bucker URI.
    s3_output_location: []const u8,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .preset_deployment_config = "PresetDeploymentConfig",
        .preset_deployment_type = "PresetDeploymentType",
        .s3_output_location = "S3OutputLocation",
    };
};
