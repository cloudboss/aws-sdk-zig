const BaseModelName = @import("base_model_name.zig").BaseModelName;
const InputDataConfig = @import("input_data_config.zig").InputDataConfig;
const CLMLanguageCode = @import("clm_language_code.zig").CLMLanguageCode;
const ModelStatus = @import("model_status.zig").ModelStatus;

/// Provides information about a custom language model, including:
///
/// * The base model name
///
/// * When the model was created
///
/// * The location of the files used to train the model
///
/// * When the model was last modified
///
/// * The name you chose for the model
///
/// * The model's language
///
/// * The model's processing state
///
/// * Any available upgrades for the base model
pub const LanguageModel = struct {
    /// The Amazon Transcribe standard language model, or base model, used to create
    /// your
    /// custom language model.
    base_model_name: ?BaseModelName = null,

    /// The date and time the specified custom language model was created.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.761000-07:00` represents 12:32 PM UTC-7 on May
    /// 4, 2022.
    create_time: ?i64 = null,

    /// If `ModelStatus` is `FAILED`, `FailureReason`
    /// contains information about why the custom language model request failed. See
    /// also:
    /// [Common
    /// Errors](https://docs.aws.amazon.com/transcribe/latest/APIReference/CommonErrors.html).
    failure_reason: ?[]const u8 = null,

    /// The Amazon S3 location of the input files used to train and tune your custom
    /// language model, in addition to the data access role ARN (Amazon Resource
    /// Name) that has
    /// permissions to access these data.
    input_data_config: ?InputDataConfig = null,

    /// The language code used to create your custom language model. Each custom
    /// language
    /// model must contain terms in only one language, and the language you select
    /// for your
    /// custom language model must match the language of your training and tuning
    /// data.
    ///
    /// For a list of supported languages and their associated language codes, refer
    /// to the
    /// [Supported
    /// languages](https://docs.aws.amazon.com/transcribe/latest/dg/supported-languages.html) table. Note that US English (`en-US`) is
    /// the only language supported with Amazon Transcribe Medical.
    language_code: ?CLMLanguageCode = null,

    /// The date and time the specified custom language model was last modified.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.761000-07:00` represents 12:32 PM UTC-7 on May
    /// 4, 2022.
    last_modified_time: ?i64 = null,

    /// A unique name, chosen by you, for your custom language model.
    ///
    /// This name is case sensitive, cannot contain spaces, and must be unique
    /// within an
    /// Amazon Web Services account.
    model_name: ?[]const u8 = null,

    /// The status of the specified custom language model. When the status displays
    /// as
    /// `COMPLETED` the model is ready for use.
    model_status: ?ModelStatus = null,

    /// Shows if a more current base model is available for use with the specified
    /// custom
    /// language model.
    ///
    /// If `false`, your custom language model is using the most up-to-date base
    /// model.
    ///
    /// If `true`, there is a newer base model available than the one your language
    /// model is using.
    ///
    /// Note that to update a base model, you must recreate the custom language
    /// model using
    /// the new base model. Base model upgrades for existing custom language models
    /// are not
    /// supported.
    upgrade_availability: ?bool = null,

    pub const json_field_names = .{
        .base_model_name = "BaseModelName",
        .create_time = "CreateTime",
        .failure_reason = "FailureReason",
        .input_data_config = "InputDataConfig",
        .language_code = "LanguageCode",
        .last_modified_time = "LastModifiedTime",
        .model_name = "ModelName",
        .model_status = "ModelStatus",
        .upgrade_availability = "UpgradeAvailability",
    };
};
