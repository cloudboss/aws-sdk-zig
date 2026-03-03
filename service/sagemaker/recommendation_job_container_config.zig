const RecommendationJobPayloadConfig = @import("recommendation_job_payload_config.zig").RecommendationJobPayloadConfig;
const RecommendationJobSupportedEndpointType = @import("recommendation_job_supported_endpoint_type.zig").RecommendationJobSupportedEndpointType;

/// Specifies mandatory fields for running an Inference Recommender job directly
/// in the
/// [CreateInferenceRecommendationsJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateInferenceRecommendationsJob.html) API. The fields specified in `ContainerConfig` override the corresponding fields in the model package. Use `ContainerConfig` if you want to specify these fields for the recommendation job but don't want to edit them in your model package.
pub const RecommendationJobContainerConfig = struct {
    /// Specifies the name and shape of the expected data inputs for your trained
    /// model with a JSON dictionary form. This field is used for optimizing your
    /// model using SageMaker Neo. For more information, see
    /// [DataInputConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_InputConfig.html#sagemaker-Type-InputConfig-DataInputConfig).
    data_input_config: ?[]const u8 = null,

    /// The machine learning domain of the model and its components.
    ///
    /// Valid Values: `COMPUTER_VISION | NATURAL_LANGUAGE_PROCESSING |
    /// MACHINE_LEARNING`
    domain: ?[]const u8 = null,

    /// The machine learning framework of the container image.
    ///
    /// Valid Values: `TENSORFLOW | PYTORCH | XGBOOST | SAGEMAKER-SCIKIT-LEARN`
    framework: ?[]const u8 = null,

    /// The framework version of the container image.
    framework_version: ?[]const u8 = null,

    /// The name of a pre-trained machine learning model benchmarked by Amazon
    /// SageMaker Inference Recommender that matches your model.
    ///
    /// Valid Values: `efficientnetb7 | unet | xgboost | faster-rcnn-resnet101 |
    /// nasnetlarge | vgg16 | inception-v3 | mask-rcnn | sagemaker-scikit-learn |
    /// densenet201-gluon | resnet18v2-gluon | xception | densenet201 | yolov4 |
    /// resnet152 | bert-base-cased | xceptionV1-keras | resnet50 | retinanet`
    nearest_model_name: ?[]const u8 = null,

    /// Specifies the `SamplePayloadUrl` and all other sample payload-related
    /// fields.
    payload_config: ?RecommendationJobPayloadConfig = null,

    /// The endpoint type to receive recommendations for. By default this is null,
    /// and the results of the inference recommendation job return a combined list
    /// of both real-time and serverless benchmarks. By specifying a value for this
    /// field, you can receive a longer list of benchmarks for the desired endpoint
    /// type.
    supported_endpoint_type: ?RecommendationJobSupportedEndpointType = null,

    /// A list of the instance types that are used to generate inferences in
    /// real-time.
    supported_instance_types: ?[]const []const u8 = null,

    /// The supported MIME types for the output data.
    supported_response_mime_types: ?[]const []const u8 = null,

    /// The machine learning task that the model accomplishes.
    ///
    /// Valid Values: `IMAGE_CLASSIFICATION | OBJECT_DETECTION | TEXT_GENERATION |
    /// IMAGE_SEGMENTATION | FILL_MASK | CLASSIFICATION | REGRESSION | OTHER`
    task: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_input_config = "DataInputConfig",
        .domain = "Domain",
        .framework = "Framework",
        .framework_version = "FrameworkVersion",
        .nearest_model_name = "NearestModelName",
        .payload_config = "PayloadConfig",
        .supported_endpoint_type = "SupportedEndpointType",
        .supported_instance_types = "SupportedInstanceTypes",
        .supported_response_mime_types = "SupportedResponseMIMETypes",
        .task = "Task",
    };
};
