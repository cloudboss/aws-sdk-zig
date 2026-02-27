const CandidateArtifactLocations = @import("candidate_artifact_locations.zig").CandidateArtifactLocations;
const MetricDatum = @import("metric_datum.zig").MetricDatum;

/// The properties of an AutoML candidate job.
pub const CandidateProperties = struct {
    /// The Amazon S3 prefix to the artifacts generated for an AutoML candidate.
    candidate_artifact_locations: ?CandidateArtifactLocations,

    /// Information about the candidate metrics for an AutoML job.
    candidate_metrics: ?[]const MetricDatum,

    pub const json_field_names = .{
        .candidate_artifact_locations = "CandidateArtifactLocations",
        .candidate_metrics = "CandidateMetrics",
    };
};
