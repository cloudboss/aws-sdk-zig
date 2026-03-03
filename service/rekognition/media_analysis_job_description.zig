const MediaAnalysisJobFailureDetails = @import("media_analysis_job_failure_details.zig").MediaAnalysisJobFailureDetails;
const MediaAnalysisInput = @import("media_analysis_input.zig").MediaAnalysisInput;
const MediaAnalysisManifestSummary = @import("media_analysis_manifest_summary.zig").MediaAnalysisManifestSummary;
const MediaAnalysisOperationsConfig = @import("media_analysis_operations_config.zig").MediaAnalysisOperationsConfig;
const MediaAnalysisOutputConfig = @import("media_analysis_output_config.zig").MediaAnalysisOutputConfig;
const MediaAnalysisResults = @import("media_analysis_results.zig").MediaAnalysisResults;
const MediaAnalysisJobStatus = @import("media_analysis_job_status.zig").MediaAnalysisJobStatus;

/// Description for a media analysis job.
pub const MediaAnalysisJobDescription = struct {
    /// The Unix date and time when the job finished.
    completion_timestamp: ?i64 = null,

    /// The Unix date and time when the job was started.
    creation_timestamp: i64,

    /// Details about the error that resulted in failure of the job.
    failure_details: ?MediaAnalysisJobFailureDetails = null,

    /// Reference to the input manifest that was provided in the job creation
    /// request.
    input: MediaAnalysisInput,

    /// The identifier for a media analysis job.
    job_id: []const u8,

    /// The name of a media analysis job.
    job_name: ?[]const u8 = null,

    /// KMS Key that was provided in the creation request.
    kms_key_id: ?[]const u8 = null,

    /// Provides statistics on input manifest and errors identified in the input
    /// manifest.
    manifest_summary: ?MediaAnalysisManifestSummary = null,

    /// Operation configurations that were provided during job creation.
    operations_config: MediaAnalysisOperationsConfig,

    /// Output configuration that was provided in the creation request.
    output_config: MediaAnalysisOutputConfig,

    /// Output manifest that contains prediction results.
    results: ?MediaAnalysisResults = null,

    /// The status of the media analysis job being retrieved.
    status: MediaAnalysisJobStatus,

    pub const json_field_names = .{
        .completion_timestamp = "CompletionTimestamp",
        .creation_timestamp = "CreationTimestamp",
        .failure_details = "FailureDetails",
        .input = "Input",
        .job_id = "JobId",
        .job_name = "JobName",
        .kms_key_id = "KmsKeyId",
        .manifest_summary = "ManifestSummary",
        .operations_config = "OperationsConfig",
        .output_config = "OutputConfig",
        .results = "Results",
        .status = "Status",
    };
};
