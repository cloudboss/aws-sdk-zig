/// The artifacts that are generated during an AutoML job.
pub const AutoMLJobArtifacts = struct {
    /// The URL of the notebook location.
    candidate_definition_notebook_location: ?[]const u8 = null,

    /// The URL of the notebook location.
    data_exploration_notebook_location: ?[]const u8 = null,

    pub const json_field_names = .{
        .candidate_definition_notebook_location = "CandidateDefinitionNotebookLocation",
        .data_exploration_notebook_location = "DataExplorationNotebookLocation",
    };
};
