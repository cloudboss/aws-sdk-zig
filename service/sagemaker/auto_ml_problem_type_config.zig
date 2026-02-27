const ImageClassificationJobConfig = @import("image_classification_job_config.zig").ImageClassificationJobConfig;
const TabularJobConfig = @import("tabular_job_config.zig").TabularJobConfig;
const TextClassificationJobConfig = @import("text_classification_job_config.zig").TextClassificationJobConfig;
const TextGenerationJobConfig = @import("text_generation_job_config.zig").TextGenerationJobConfig;
const TimeSeriesForecastingJobConfig = @import("time_series_forecasting_job_config.zig").TimeSeriesForecastingJobConfig;

/// A collection of settings specific to the problem type used to configure an
/// AutoML job V2. There must be one and only one config of the following type.
pub const AutoMLProblemTypeConfig = union(enum) {
    /// Settings used to configure an AutoML job V2 for the image classification
    /// problem type.
    image_classification_job_config: ?ImageClassificationJobConfig,
    /// Settings used to configure an AutoML job V2 for the tabular problem type
    /// (regression, classification).
    tabular_job_config: ?TabularJobConfig,
    /// Settings used to configure an AutoML job V2 for the text classification
    /// problem type.
    text_classification_job_config: ?TextClassificationJobConfig,
    /// Settings used to configure an AutoML job V2 for the text generation (LLMs
    /// fine-tuning) problem type.
    ///
    /// The text generation models that support fine-tuning in Autopilot are
    /// currently accessible exclusively in regions supported by Canvas. Refer to
    /// the documentation of Canvas for the [full list of its supported
    /// Regions](https://docs.aws.amazon.com/sagemaker/latest/dg/canvas.html).
    text_generation_job_config: ?TextGenerationJobConfig,
    /// Settings used to configure an AutoML job V2 for the time-series forecasting
    /// problem type.
    time_series_forecasting_job_config: ?TimeSeriesForecastingJobConfig,

    pub const json_field_names = .{
        .image_classification_job_config = "ImageClassificationJobConfig",
        .tabular_job_config = "TabularJobConfig",
        .text_classification_job_config = "TextClassificationJobConfig",
        .text_generation_job_config = "TextGenerationJobConfig",
        .time_series_forecasting_job_config = "TimeSeriesForecastingJobConfig",
    };
};
