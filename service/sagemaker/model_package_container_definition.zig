const aws = @import("aws");

const AdditionalModelDataSource = @import("additional_model_data_source.zig").AdditionalModelDataSource;
const AdditionalS3DataSource = @import("additional_s3_data_source.zig").AdditionalS3DataSource;
const BaseModel = @import("base_model.zig").BaseModel;
const ModelDataSource = @import("model_data_source.zig").ModelDataSource;
const ModelInput = @import("model_input.zig").ModelInput;

/// Describes the Docker container for the model package.
pub const ModelPackageContainerDefinition = struct {
    /// Data sources that are available to your model in addition to the one that
    /// you specify for `ModelDataSource` when you use the `CreateModelPackage`
    /// action.
    additional_model_data_sources: ?[]const AdditionalModelDataSource = null,

    /// The additional data source that is used during inference in the Docker
    /// container for your model package.
    additional_s3_data_source: ?AdditionalS3DataSource = null,

    /// Identifies the foundation model that was used as the starting point for
    /// model customization.
    base_model: ?BaseModel = null,

    /// The DNS host name for the Docker container.
    container_hostname: ?[]const u8 = null,

    /// The environment variables to set in the Docker container. Each key and value
    /// in the `Environment` string to string map can have length of up to 1024. We
    /// support up to 16 entries in the map.
    environment: ?[]const aws.map.StringMapEntry = null,

    /// The machine learning framework of the model package container image.
    framework: ?[]const u8 = null,

    /// The framework version of the Model Package Container Image.
    framework_version: ?[]const u8 = null,

    /// The Amazon Elastic Container Registry (Amazon ECR) path where inference code
    /// is stored.
    ///
    /// If you are using your own custom algorithm instead of an algorithm provided
    /// by SageMaker, the inference code must meet SageMaker requirements. SageMaker
    /// supports both `registry/repository[:tag]` and `registry/repository[@digest]`
    /// image path formats. For more information, see [Using Your Own Algorithms
    /// with Amazon
    /// SageMaker](https://docs.aws.amazon.com/sagemaker/latest/dg/your-algorithms.html).
    image: ?[]const u8 = null,

    /// An MD5 hash of the training algorithm that identifies the Docker image used
    /// for training.
    image_digest: ?[]const u8 = null,

    /// Specifies whether the model data is a training checkpoint.
    is_checkpoint: ?bool = null,

    /// The ETag associated with Model Data URL.
    model_data_e_tag: ?[]const u8 = null,

    /// Specifies the location of ML model data to deploy during endpoint creation.
    model_data_source: ?ModelDataSource = null,

    /// The Amazon S3 path where the model artifacts, which result from model
    /// training, are stored. This path must point to a single `gzip` compressed tar
    /// archive (`.tar.gz` suffix).
    ///
    /// The model artifacts must be in an S3 bucket that is in the same region as
    /// the model package.
    model_data_url: ?[]const u8 = null,

    /// A structure with Model Input details.
    model_input: ?ModelInput = null,

    /// The name of a pre-trained machine learning benchmarked by Amazon SageMaker
    /// Inference Recommender model that matches your model. You can find a list of
    /// benchmarked models by calling `ListModelMetadata`.
    nearest_model_name: ?[]const u8 = null,

    /// The Amazon Web Services Marketplace product ID of the model package.
    product_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_model_data_sources = "AdditionalModelDataSources",
        .additional_s3_data_source = "AdditionalS3DataSource",
        .base_model = "BaseModel",
        .container_hostname = "ContainerHostname",
        .environment = "Environment",
        .framework = "Framework",
        .framework_version = "FrameworkVersion",
        .image = "Image",
        .image_digest = "ImageDigest",
        .is_checkpoint = "IsCheckpoint",
        .model_data_e_tag = "ModelDataETag",
        .model_data_source = "ModelDataSource",
        .model_data_url = "ModelDataUrl",
        .model_input = "ModelInput",
        .nearest_model_name = "NearestModelName",
        .product_id = "ProductId",
    };
};
