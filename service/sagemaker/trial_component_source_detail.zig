const ProcessingJob = @import("processing_job.zig").ProcessingJob;
const TrainingJob = @import("training_job.zig").TrainingJob;
const TransformJob = @import("transform_job.zig").TransformJob;

/// Detailed information about the source of a trial component. Either
/// `ProcessingJob` or `TrainingJob` is returned.
pub const TrialComponentSourceDetail = struct {
    /// Information about a processing job that's the source of a trial component.
    processing_job: ?ProcessingJob,

    /// The Amazon Resource Name (ARN) of the source.
    source_arn: ?[]const u8,

    /// Information about a training job that's the source of a trial component.
    training_job: ?TrainingJob,

    /// Information about a transform job that's the source of a trial component.
    transform_job: ?TransformJob,

    pub const json_field_names = .{
        .processing_job = "ProcessingJob",
        .source_arn = "SourceArn",
        .training_job = "TrainingJob",
        .transform_job = "TransformJob",
    };
};
