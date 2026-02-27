const DataUploadFrequency = @import("data_upload_frequency.zig").DataUploadFrequency;
const LatestInferenceResult = @import("latest_inference_result.zig").LatestInferenceResult;
const InferenceSchedulerStatus = @import("inference_scheduler_status.zig").InferenceSchedulerStatus;

/// Contains information about the specific inference scheduler, including data
/// delay
/// offset, model name and ARN, status, and so on.
pub const InferenceSchedulerSummary = struct {
    /// A period of time (in minutes) by which inference on the data is delayed
    /// after the data
    /// starts. For instance, if an offset delay time of five minutes was selected,
    /// inference will
    /// not begin on the data until the first data measurement after the five minute
    /// mark. For
    /// example, if five minutes is selected, the inference scheduler will wake up
    /// at the
    /// configured frequency with the additional five minute delay time to check the
    /// customer S3
    /// bucket. The customer can upload data at the same frequency and they don't
    /// need to stop and
    /// restart the scheduler when uploading new data.
    data_delay_offset_in_minutes: ?i64,

    /// How often data is uploaded to the source S3 bucket for the input data. This
    /// value is the
    /// length of time between data uploads. For instance, if you select 5 minutes,
    /// Amazon Lookout
    /// for Equipment will upload the real-time data to the source bucket once every
    /// 5 minutes.
    /// This frequency also determines how often Amazon Lookout for Equipment starts
    /// a scheduled inference on your
    /// data. In this example, it starts once every 5 minutes.
    data_upload_frequency: ?DataUploadFrequency,

    /// The Amazon Resource Name (ARN) of the inference scheduler.
    inference_scheduler_arn: ?[]const u8,

    /// The name of the inference scheduler.
    inference_scheduler_name: ?[]const u8,

    /// Indicates whether the latest execution for the inference scheduler was
    /// Anomalous
    /// (anomalous events found) or Normal (no anomalous events found).
    latest_inference_result: ?LatestInferenceResult,

    /// The Amazon Resource Name (ARN) of the machine learning model used by the
    /// inference
    /// scheduler.
    model_arn: ?[]const u8,

    /// The name of the machine learning model used for the inference scheduler.
    model_name: ?[]const u8,

    /// Indicates the status of the inference scheduler.
    status: ?InferenceSchedulerStatus,

    pub const json_field_names = .{
        .data_delay_offset_in_minutes = "DataDelayOffsetInMinutes",
        .data_upload_frequency = "DataUploadFrequency",
        .inference_scheduler_arn = "InferenceSchedulerArn",
        .inference_scheduler_name = "InferenceSchedulerName",
        .latest_inference_result = "LatestInferenceResult",
        .model_arn = "ModelArn",
        .model_name = "ModelName",
        .status = "Status",
    };
};
