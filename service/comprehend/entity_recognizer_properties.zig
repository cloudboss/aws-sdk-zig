const EntityRecognizerInputDataConfig = @import("entity_recognizer_input_data_config.zig").EntityRecognizerInputDataConfig;
const LanguageCode = @import("language_code.zig").LanguageCode;
const EntityRecognizerOutputDataConfig = @import("entity_recognizer_output_data_config.zig").EntityRecognizerOutputDataConfig;
const EntityRecognizerMetadata = @import("entity_recognizer_metadata.zig").EntityRecognizerMetadata;
const ModelStatus = @import("model_status.zig").ModelStatus;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Describes information about an entity recognizer.
pub const EntityRecognizerProperties = struct {
    /// The Amazon Resource Name (ARN) of the IAM role that
    /// grants Amazon Comprehend read access to your input data.
    data_access_role_arn: ?[]const u8 = null,

    /// The time that the recognizer creation completed.
    end_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) that identifies the entity recognizer.
    entity_recognizer_arn: ?[]const u8 = null,

    /// The Amazon Resource Number (ARN) of the flywheel
    flywheel_arn: ?[]const u8 = null,

    /// The input data properties of an entity recognizer.
    input_data_config: ?EntityRecognizerInputDataConfig = null,

    /// The language of the input documents. All documents must be in the same
    /// language. Only
    /// English ("en") is currently supported.
    language_code: ?LanguageCode = null,

    /// A description of the status of the recognizer.
    message: ?[]const u8 = null,

    /// ID for the KMS key that Amazon Comprehend uses to encrypt
    /// trained custom models. The ModelKmsKeyId can be either of the following
    /// formats:
    ///
    /// * KMS Key ID: `"1234abcd-12ab-34cd-56ef-1234567890ab"`
    ///
    /// * Amazon Resource Name (ARN) of a KMS Key:
    /// `"arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"`
    model_kms_key_id: ?[]const u8 = null,

    /// Output data configuration.
    output_data_config: ?EntityRecognizerOutputDataConfig = null,

    /// Provides information about an entity recognizer.
    recognizer_metadata: ?EntityRecognizerMetadata = null,

    /// The Amazon Resource Name (ARN) of the source model. This model was imported
    /// from a
    /// different Amazon Web Services account to create the entity recognizer model
    /// in your Amazon Web Services account.
    source_model_arn: ?[]const u8 = null,

    /// Provides the status of the entity recognizer.
    status: ?ModelStatus = null,

    /// The time that the recognizer was submitted for processing.
    submit_time: ?i64 = null,

    /// The time that training of the entity recognizer was completed.
    training_end_time: ?i64 = null,

    /// The time that training of the entity recognizer started.
    training_start_time: ?i64 = null,

    /// The version name you assigned to the entity recognizer.
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
    /// resources you are using for your custom entity recognizer. For more
    /// information, see [Amazon
    /// VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html).
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .data_access_role_arn = "DataAccessRoleArn",
        .end_time = "EndTime",
        .entity_recognizer_arn = "EntityRecognizerArn",
        .flywheel_arn = "FlywheelArn",
        .input_data_config = "InputDataConfig",
        .language_code = "LanguageCode",
        .message = "Message",
        .model_kms_key_id = "ModelKmsKeyId",
        .output_data_config = "OutputDataConfig",
        .recognizer_metadata = "RecognizerMetadata",
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
