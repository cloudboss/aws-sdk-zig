const aws = @import("aws");

const AdditionalInferenceSpecificationDefinition = @import("additional_inference_specification_definition.zig").AdditionalInferenceSpecificationDefinition;
const UserContext = @import("user_context.zig").UserContext;
const DriftCheckBaselines = @import("drift_check_baselines.zig").DriftCheckBaselines;
const InferenceSpecification = @import("inference_specification.zig").InferenceSpecification;
const MetadataProperties = @import("metadata_properties.zig").MetadataProperties;
const ModelApprovalStatus = @import("model_approval_status.zig").ModelApprovalStatus;
const ModelPackageModelCard = @import("model_package_model_card.zig").ModelPackageModelCard;
const ModelLifeCycle = @import("model_life_cycle.zig").ModelLifeCycle;
const ModelMetrics = @import("model_metrics.zig").ModelMetrics;
const ModelPackageRegistrationType = @import("model_package_registration_type.zig").ModelPackageRegistrationType;
const ModelPackageStatus = @import("model_package_status.zig").ModelPackageStatus;
const ModelPackageStatusDetails = @import("model_package_status_details.zig").ModelPackageStatusDetails;
const ModelPackageSecurityConfig = @import("model_package_security_config.zig").ModelPackageSecurityConfig;
const SkipModelValidation = @import("skip_model_validation.zig").SkipModelValidation;
const SourceAlgorithmSpecification = @import("source_algorithm_specification.zig").SourceAlgorithmSpecification;
const Tag = @import("tag.zig").Tag;
const ModelPackageValidationSpecification = @import("model_package_validation_specification.zig").ModelPackageValidationSpecification;

/// A container for your trained model that can be deployed for SageMaker
/// inference. This can include inference code, artifacts, and metadata. The
/// model package type can be one of the following.
///
/// * Versioned model: A part of a model package group in Model Registry.
/// * Unversioned model: Not part of a model package group and used in Amazon
///   Web Services Marketplace.
///
/// For more information, see [ `CreateModelPackage`
/// ](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateModelPackage.html).
pub const ModelPackage = struct {
    /// An array of additional Inference Specification objects.
    additional_inference_specifications: ?[]const AdditionalInferenceSpecificationDefinition,

    /// A description provided when the model approval is set.
    approval_description: ?[]const u8,

    /// Whether the model package is to be certified to be listed on Amazon Web
    /// Services Marketplace. For information about listing model packages on Amazon
    /// Web Services Marketplace, see [List Your Algorithm or Model Package on
    /// Amazon Web Services
    /// Marketplace](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-mkt-list.html).
    certify_for_marketplace: ?bool,

    /// Information about the user who created or modified an experiment, trial,
    /// trial component, lineage group, or project.
    created_by: ?UserContext,

    /// The time that the model package was created.
    creation_time: ?i64,

    /// The metadata properties for the model package.
    customer_metadata_properties: ?[]const aws.map.StringMapEntry,

    /// The machine learning domain of your model package and its components. Common
    /// machine learning domains include computer vision and natural language
    /// processing.
    domain: ?[]const u8,

    /// Represents the drift check baselines that can be used when the model monitor
    /// is set using the model package.
    drift_check_baselines: ?DriftCheckBaselines,

    /// Defines how to perform inference generation after a training job is run.
    inference_specification: ?InferenceSpecification,

    /// Information about the user who created or modified an experiment, trial,
    /// trial component, lineage group, or project.
    last_modified_by: ?UserContext,

    /// The last time the model package was modified.
    last_modified_time: ?i64,

    /// Metadata properties of the tracking entity, trial, or trial component.
    metadata_properties: ?MetadataProperties,

    /// The approval status of the model. This can be one of the following values.
    ///
    /// * `APPROVED` - The model is approved
    /// * `REJECTED` - The model is rejected.
    /// * `PENDING_MANUAL_APPROVAL` - The model is waiting for manual approval.
    model_approval_status: ?ModelApprovalStatus,

    model_card: ?ModelPackageModelCard,

    /// A structure describing the current state of the model in its life cycle.
    model_life_cycle: ?ModelLifeCycle,

    /// Metrics for the model.
    model_metrics: ?ModelMetrics,

    /// The Amazon Resource Name (ARN) of the model package.
    model_package_arn: ?[]const u8,

    /// The description of the model package.
    model_package_description: ?[]const u8,

    /// The model group to which the model belongs.
    model_package_group_name: ?[]const u8,

    /// The name of the model package. The name can be as follows:
    ///
    /// * For a versioned model, the name is automatically generated by SageMaker
    ///   Model Registry and follows the format
    ///   '`ModelPackageGroupName/ModelPackageVersion`'.
    /// * For an unversioned model, you must provide the name.
    model_package_name: ?[]const u8,

    /// The package registration type of the model package.
    model_package_registration_type: ?ModelPackageRegistrationType,

    /// The status of the model package. This can be one of the following values.
    ///
    /// * `PENDING` - The model package is pending being created.
    /// * `IN_PROGRESS` - The model package is in the process of being created.
    /// * `COMPLETED` - The model package was successfully created.
    /// * `FAILED` - The model package failed.
    /// * `DELETING` - The model package is in the process of being deleted.
    model_package_status: ?ModelPackageStatus,

    /// Specifies the validation and image scan statuses of the model package.
    model_package_status_details: ?ModelPackageStatusDetails,

    /// The version number of a versioned model.
    model_package_version: ?i32,

    /// The Amazon Simple Storage Service path where the sample payload are stored.
    /// This path must point to a single gzip compressed tar archive (.tar.gz
    /// suffix).
    sample_payload_url: ?[]const u8,

    security_config: ?ModelPackageSecurityConfig,

    /// Indicates if you want to skip model validation.
    skip_model_validation: ?SkipModelValidation,

    /// A list of algorithms that were used to create a model package.
    source_algorithm_specification: ?SourceAlgorithmSpecification,

    /// The URI of the source for the model package.
    source_uri: ?[]const u8,

    /// A list of the tags associated with the model package. For more information,
    /// see [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the *Amazon Web Services General Reference Guide*.
    tags: ?[]const Tag,

    /// The machine learning task your model package accomplishes. Common machine
    /// learning tasks include object detection and image classification.
    task: ?[]const u8,

    /// Specifies batch transform jobs that SageMaker runs to validate your model
    /// package.
    validation_specification: ?ModelPackageValidationSpecification,

    pub const json_field_names = .{
        .additional_inference_specifications = "AdditionalInferenceSpecifications",
        .approval_description = "ApprovalDescription",
        .certify_for_marketplace = "CertifyForMarketplace",
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .customer_metadata_properties = "CustomerMetadataProperties",
        .domain = "Domain",
        .drift_check_baselines = "DriftCheckBaselines",
        .inference_specification = "InferenceSpecification",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .metadata_properties = "MetadataProperties",
        .model_approval_status = "ModelApprovalStatus",
        .model_card = "ModelCard",
        .model_life_cycle = "ModelLifeCycle",
        .model_metrics = "ModelMetrics",
        .model_package_arn = "ModelPackageArn",
        .model_package_description = "ModelPackageDescription",
        .model_package_group_name = "ModelPackageGroupName",
        .model_package_name = "ModelPackageName",
        .model_package_registration_type = "ModelPackageRegistrationType",
        .model_package_status = "ModelPackageStatus",
        .model_package_status_details = "ModelPackageStatusDetails",
        .model_package_version = "ModelPackageVersion",
        .sample_payload_url = "SamplePayloadUrl",
        .security_config = "SecurityConfig",
        .skip_model_validation = "SkipModelValidation",
        .source_algorithm_specification = "SourceAlgorithmSpecification",
        .source_uri = "SourceUri",
        .tags = "Tags",
        .task = "Task",
        .validation_specification = "ValidationSpecification",
    };
};
