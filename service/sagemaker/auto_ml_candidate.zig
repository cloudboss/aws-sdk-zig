const aws = @import("aws");

const CandidateProperties = @import("candidate_properties.zig").CandidateProperties;
const CandidateStatus = @import("candidate_status.zig").CandidateStatus;
const AutoMLCandidateStep = @import("auto_ml_candidate_step.zig").AutoMLCandidateStep;
const FinalAutoMLJobObjectiveMetric = @import("final_auto_ml_job_objective_metric.zig").FinalAutoMLJobObjectiveMetric;
const AutoMLContainerDefinition = @import("auto_ml_container_definition.zig").AutoMLContainerDefinition;
const ObjectiveStatus = @import("objective_status.zig").ObjectiveStatus;

/// Information about a candidate produced by an AutoML training job, including
/// its status, steps, and other properties.
pub const AutoMLCandidate = struct {
    /// The name of the candidate.
    candidate_name: []const u8,

    /// The properties of an AutoML candidate job.
    candidate_properties: ?CandidateProperties = null,

    /// The candidate's status.
    candidate_status: CandidateStatus,

    /// Information about the candidate's steps.
    candidate_steps: []const AutoMLCandidateStep,

    /// The creation time.
    creation_time: i64,

    /// The end time.
    end_time: ?i64 = null,

    /// The failure reason.
    failure_reason: ?[]const u8 = null,

    final_auto_ml_job_objective_metric: ?FinalAutoMLJobObjectiveMetric = null,

    /// The mapping of all supported processing unit (CPU, GPU, etc...) to inference
    /// container definitions for the candidate. This field is populated for the
    /// AutoML jobs V2 (for example, for jobs created by calling
    /// `CreateAutoMLJobV2`) related to image or text classification problem types
    /// only.
    inference_container_definitions: ?[]const aws.map.MapEntry([]const AutoMLContainerDefinition) = null,

    /// Information about the recommended inference container definitions.
    inference_containers: ?[]const AutoMLContainerDefinition = null,

    /// The last modified time.
    last_modified_time: i64,

    /// The objective's status.
    objective_status: ObjectiveStatus,

    pub const json_field_names = .{
        .candidate_name = "CandidateName",
        .candidate_properties = "CandidateProperties",
        .candidate_status = "CandidateStatus",
        .candidate_steps = "CandidateSteps",
        .creation_time = "CreationTime",
        .end_time = "EndTime",
        .failure_reason = "FailureReason",
        .final_auto_ml_job_objective_metric = "FinalAutoMLJobObjectiveMetric",
        .inference_container_definitions = "InferenceContainerDefinitions",
        .inference_containers = "InferenceContainers",
        .last_modified_time = "LastModifiedTime",
        .objective_status = "ObjectiveStatus",
    };
};
