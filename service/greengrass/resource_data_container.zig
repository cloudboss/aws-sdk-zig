const LocalDeviceResourceData = @import("local_device_resource_data.zig").LocalDeviceResourceData;
const LocalVolumeResourceData = @import("local_volume_resource_data.zig").LocalVolumeResourceData;
const S3MachineLearningModelResourceData = @import("s3_machine_learning_model_resource_data.zig").S3MachineLearningModelResourceData;
const SageMakerMachineLearningModelResourceData = @import("sage_maker_machine_learning_model_resource_data.zig").SageMakerMachineLearningModelResourceData;
const SecretsManagerSecretResourceData = @import("secrets_manager_secret_resource_data.zig").SecretsManagerSecretResourceData;

/// A container for resource data. The container takes only one of the following
/// supported resource data types: ''LocalDeviceResourceData'',
/// ''LocalVolumeResourceData'', ''SageMakerMachineLearningModelResourceData'',
/// ''S3MachineLearningModelResourceData'',
/// ''SecretsManagerSecretResourceData''.
pub const ResourceDataContainer = struct {
    /// Attributes that define the local device resource.
    local_device_resource_data: ?LocalDeviceResourceData = null,

    /// Attributes that define the local volume resource.
    local_volume_resource_data: ?LocalVolumeResourceData = null,

    /// Attributes that define an Amazon S3 machine learning resource.
    s3_machine_learning_model_resource_data: ?S3MachineLearningModelResourceData = null,

    /// Attributes that define an Amazon SageMaker machine learning resource.
    sage_maker_machine_learning_model_resource_data: ?SageMakerMachineLearningModelResourceData = null,

    /// Attributes that define a secret resource, which references a secret from AWS
    /// Secrets Manager.
    secrets_manager_secret_resource_data: ?SecretsManagerSecretResourceData = null,

    pub const json_field_names = .{
        .local_device_resource_data = "LocalDeviceResourceData",
        .local_volume_resource_data = "LocalVolumeResourceData",
        .s3_machine_learning_model_resource_data = "S3MachineLearningModelResourceData",
        .sage_maker_machine_learning_model_resource_data = "SageMakerMachineLearningModelResourceData",
        .secrets_manager_secret_resource_data = "SecretsManagerSecretResourceData",
    };
};
