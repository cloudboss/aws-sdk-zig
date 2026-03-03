const aws = @import("aws");

const AdditionalModelDataSource = @import("additional_model_data_source.zig").AdditionalModelDataSource;
const ImageConfig = @import("image_config.zig").ImageConfig;
const ContainerMode = @import("container_mode.zig").ContainerMode;
const ModelDataSource = @import("model_data_source.zig").ModelDataSource;
const MultiModelConfig = @import("multi_model_config.zig").MultiModelConfig;

/// Describes the container, as part of model definition.
pub const ContainerDefinition = struct {
    /// Data sources that are available to your model in addition to the one that
    /// you specify for `ModelDataSource` when you use the `CreateModel` action.
    additional_model_data_sources: ?[]const AdditionalModelDataSource = null,

    /// This parameter is ignored for models that contain only a `PrimaryContainer`.
    ///
    /// When a `ContainerDefinition` is part of an inference pipeline, the value of
    /// the parameter uniquely identifies the container for the purposes of logging
    /// and metrics. For information, see [Use Logs and Metrics to Monitor an
    /// Inference
    /// Pipeline](https://docs.aws.amazon.com/sagemaker/latest/dg/inference-pipeline-logs-metrics.html). If you don't specify a value for this parameter for a `ContainerDefinition` that is part of an inference pipeline, a unique name is automatically assigned based on the position of the `ContainerDefinition` in the pipeline. If you specify a value for the `ContainerHostName` for any `ContainerDefinition` that is part of an inference pipeline, you must specify a value for the `ContainerHostName` parameter of every `ContainerDefinition` in that pipeline.
    container_hostname: ?[]const u8 = null,

    /// The environment variables to set in the Docker container. Don't include any
    /// sensitive data in your environment variables.
    ///
    /// The maximum length of each key and value in the `Environment` map is 1024
    /// bytes. The maximum length of all keys and values in the map, combined, is 32
    /// KB. If you pass multiple containers to a `CreateModel` request, then the
    /// maximum length of all of their maps, combined, is also 32 KB.
    environment: ?[]const aws.map.StringMapEntry = null,

    /// The path where inference code is stored. This can be either in Amazon EC2
    /// Container Registry or in a Docker registry that is accessible from the same
    /// VPC that you configure for your endpoint. If you are using your own custom
    /// algorithm instead of an algorithm provided by SageMaker, the inference code
    /// must meet SageMaker requirements. SageMaker supports both
    /// `registry/repository[:tag]` and `registry/repository[@digest]` image path
    /// formats. For more information, see [Using Your Own Algorithms with Amazon
    /// SageMaker](https://docs.aws.amazon.com/sagemaker/latest/dg/your-algorithms.html).
    ///
    /// The model artifacts in an Amazon S3 bucket and the Docker image for
    /// inference container in Amazon EC2 Container Registry must be in the same
    /// region as the model or endpoint you are creating.
    image: ?[]const u8 = null,

    /// Specifies whether the model container is in Amazon ECR or a private Docker
    /// registry accessible from your Amazon Virtual Private Cloud (VPC). For
    /// information about storing containers in a private Docker registry, see [Use
    /// a Private Docker Registry for Real-Time Inference
    /// Containers](https://docs.aws.amazon.com/sagemaker/latest/dg/your-algorithms-containers-inference-private.html).
    ///
    /// The model artifacts in an Amazon S3 bucket and the Docker image for
    /// inference container in Amazon EC2 Container Registry must be in the same
    /// region as the model or endpoint you are creating.
    image_config: ?ImageConfig = null,

    /// The inference specification name in the model package version.
    inference_specification_name: ?[]const u8 = null,

    /// Whether the container hosts a single model or multiple models.
    mode: ?ContainerMode = null,

    /// Specifies the location of ML model data to deploy.
    ///
    /// Currently you cannot use `ModelDataSource` in conjunction with SageMaker
    /// batch transform, SageMaker serverless endpoints, SageMaker multi-model
    /// endpoints, and SageMaker Marketplace.
    model_data_source: ?ModelDataSource = null,

    /// The S3 path where the model artifacts, which result from model training, are
    /// stored. This path must point to a single gzip compressed tar archive
    /// (.tar.gz suffix). The S3 path is required for SageMaker built-in algorithms,
    /// but not if you use your own algorithms. For more information on built-in
    /// algorithms, see [Common
    /// Parameters](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-algo-docker-registry-paths.html).
    ///
    /// The model artifacts must be in an S3 bucket that is in the same region as
    /// the model or endpoint you are creating.
    ///
    /// If you provide a value for this parameter, SageMaker uses Amazon Web
    /// Services Security Token Service to download model artifacts from the S3 path
    /// you provide. Amazon Web Services STS is activated in your Amazon Web
    /// Services account by default. If you previously deactivated Amazon Web
    /// Services STS for a region, you need to reactivate Amazon Web Services STS
    /// for that region. For more information, see [Activating and Deactivating
    /// Amazon Web Services STS in an Amazon Web Services
    /// Region](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_enable-regions.html) in the *Amazon Web Services Identity and Access Management User Guide*.
    ///
    /// If you use a built-in algorithm to create a model, SageMaker requires that
    /// you provide a S3 path to the model artifacts in `ModelDataUrl`.
    model_data_url: ?[]const u8 = null,

    /// The name or Amazon Resource Name (ARN) of the model package to use to create
    /// the model.
    model_package_name: ?[]const u8 = null,

    /// Specifies additional configuration for multi-model endpoints.
    multi_model_config: ?MultiModelConfig = null,

    pub const json_field_names = .{
        .additional_model_data_sources = "AdditionalModelDataSources",
        .container_hostname = "ContainerHostname",
        .environment = "Environment",
        .image = "Image",
        .image_config = "ImageConfig",
        .inference_specification_name = "InferenceSpecificationName",
        .mode = "Mode",
        .model_data_source = "ModelDataSource",
        .model_data_url = "ModelDataUrl",
        .model_package_name = "ModelPackageName",
        .multi_model_config = "MultiModelConfig",
    };
};
