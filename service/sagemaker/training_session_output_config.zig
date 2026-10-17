const TrainingSessionS3Location = @import("training_session_s3_location.zig").TrainingSessionS3Location;

/// The output configuration for a training session, including the Amazon S3
/// location for checkpoints and model artifacts, and optional encryption
/// settings.
pub const TrainingSessionOutputConfig = struct {
    /// The Amazon S3 location where training session outputs, including checkpoints
    /// and model artifacts, are stored.
    s3_location: TrainingSessionS3Location,

    pub const json_field_names = .{
        .s3_location = "S3Location",
    };
};
