const ClassifierMetadata = @import("classifier_metadata.zig").ClassifierMetadata;
const DocumentClassifierInputDataConfig = @import("document_classifier_input_data_config.zig").DocumentClassifierInputDataConfig;
const LanguageCode = @import("language_code.zig").LanguageCode;
const DocumentClassifierMode = @import("document_classifier_mode.zig").DocumentClassifierMode;
const DocumentClassifierOutputDataConfig = @import("document_classifier_output_data_config.zig").DocumentClassifierOutputDataConfig;
const ModelStatus = @import("model_status.zig").ModelStatus;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Provides information about a document classifier.
pub const DocumentClassifierProperties = struct {
    /// Information about the document classifier, including the number of documents
    /// used for
    /// training the classifier, the number of documents used for test the
    /// classifier, and an accuracy
    /// rating.
    classifier_metadata: ?ClassifierMetadata = null,

    /// The Amazon Resource Name (ARN) of the IAM role that
    /// grants Amazon Comprehend read access to your input data.
    data_access_role_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that identifies the document classifier.
    document_classifier_arn: ?[]const u8 = null,

    /// The time that training the document classifier completed.
    end_time: ?i64 = null,

    /// The Amazon Resource Number (ARN) of the flywheel
    flywheel_arn: ?[]const u8 = null,

    /// The input data configuration that you supplied when you created the document
    /// classifier
    /// for training.
    input_data_config: ?DocumentClassifierInputDataConfig = null,

    /// The language code for the language of the documents that the classifier was
    /// trained
    /// on.
    language_code: ?LanguageCode = null,

    /// Additional information about the status of the classifier.
    message: ?[]const u8 = null,

    /// Indicates the mode in which the specific classifier was trained. This also
    /// indicates the
    /// format of input documents and the format of the confusion matrix. Each
    /// classifier can only be
    /// trained in one mode and this cannot be changed once the classifier is
    /// trained.
    mode: ?DocumentClassifierMode = null,

    /// ID for the KMS key that Amazon Comprehend uses to encrypt
    /// trained custom models. The ModelKmsKeyId can be either of the following
    /// formats:
    ///
    /// * KMS Key ID: `"1234abcd-12ab-34cd-56ef-1234567890ab"`
    ///
    /// * Amazon Resource Name (ARN) of a KMS Key:
    /// `"arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"`
    model_kms_key_id: ?[]const u8 = null,

    /// Provides output results configuration parameters for custom classifier jobs.
    output_data_config: ?DocumentClassifierOutputDataConfig = null,

    /// The Amazon Resource Name (ARN) of the source model. This model was imported
    /// from a
    /// different Amazon Web Services account to create the document classifier
    /// model in your Amazon Web Services account.
    source_model_arn: ?[]const u8 = null,

    /// The status of the document classifier. If the status is `TRAINED` the
    /// classifier is ready to use. If the status is `TRAINED_WITH_WARNINGS` the
    /// classifier training succeeded, but you should review the warnings returned
    /// in the
    /// `CreateDocumentClassifier` response.
    ///
    /// If the status is `FAILED` you can see additional
    /// information about why the classifier wasn't trained in the `Message` field.
    status: ?ModelStatus = null,

    /// The time that the document classifier was submitted for training.
    submit_time: ?i64 = null,

    /// The time that training of the document classifier was completed. Indicates
    /// the time when
    /// the training completes on documentation classifiers. You are billed for the
    /// time interval
    /// between this time and the value of TrainingStartTime.
    training_end_time: ?i64 = null,

    /// Indicates the time when the training starts on documentation classifiers.
    /// You are billed
    /// for the time interval between this time and the value of TrainingEndTime.
    training_start_time: ?i64 = null,

    /// The version name that you assigned to the document classifier.
    version_name: ?[]const u8 = null,

    /// ID for the Amazon Web Services Key Management Service (KMS) key that Amazon
    /// Comprehend uses to encrypt
    /// data on the storage volume attached to the ML compute instance(s) that
    /// process the analysis
    /// job. The VolumeKmsKeyId can be either of the following formats:
    ///
    /// * KMS Key ID: `"1234abcd-12ab-34cd-56ef-1234567890ab"`
    ///
    /// * Amazon Resource Name (ARN) of a KMS Key:
    /// `"arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"`
    volume_kms_key_id: ?[]const u8 = null,

    /// Configuration parameters for a private Virtual Private Cloud (VPC)
    /// containing the
    /// resources you are using for your custom classifier. For more information,
    /// see [Amazon
    /// VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html).
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .classifier_metadata = "ClassifierMetadata",
        .data_access_role_arn = "DataAccessRoleArn",
        .document_classifier_arn = "DocumentClassifierArn",
        .end_time = "EndTime",
        .flywheel_arn = "FlywheelArn",
        .input_data_config = "InputDataConfig",
        .language_code = "LanguageCode",
        .message = "Message",
        .mode = "Mode",
        .model_kms_key_id = "ModelKmsKeyId",
        .output_data_config = "OutputDataConfig",
        .source_model_arn = "SourceModelArn",
        .status = "Status",
        .submit_time = "SubmitTime",
        .training_end_time = "TrainingEndTime",
        .training_start_time = "TrainingStartTime",
        .version_name = "VersionName",
        .volume_kms_key_id = "VolumeKmsKeyId",
        .vpc_config = "VpcConfig",
    };
};
