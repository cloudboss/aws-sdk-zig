const MediaAnalysisModelVersions = @import("media_analysis_model_versions.zig").MediaAnalysisModelVersions;
const S3Object = @import("s3_object.zig").S3Object;

/// Contains the results for a media analysis job created with
/// StartMediaAnalysisJob.
pub const MediaAnalysisResults = struct {
    /// Information about the model versions for the features selected in a given
    /// job.
    model_versions: ?MediaAnalysisModelVersions,

    s3_object: ?S3Object,

    pub const json_field_names = .{
        .model_versions = "ModelVersions",
        .s3_object = "S3Object",
    };
};
