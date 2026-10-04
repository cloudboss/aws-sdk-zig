const ExperimentDefinitionStatus = @import("experiment_definition_status.zig").ExperimentDefinitionStatus;

/// Summary information about an experiment definition.
pub const ExperimentDefinitionSummary = struct {
    /// The application ID.
    application_id: ?[]const u8 = null,

    /// The configuration profile ID associated with the experiment.
    configuration_profile_id: ?[]const u8 = null,

    /// The date and time the experiment definition was created, in ISO 8601 format.
    created_at: ?i64 = null,

    /// The environment ID where the experiment runs.
    environment_id: ?[]const u8 = null,

    /// The key of the feature flag used by the experiment.
    flag_key: ?[]const u8 = null,

    /// The hypothesis that the experiment is designed to validate.
    hypothesis: ?[]const u8 = null,

    /// The experiment definition ID.
    id: ?[]const u8 = null,

    /// The name of the experiment definition.
    name: ?[]const u8 = null,

    /// The current status of the experiment definition.
    status: ?ExperimentDefinitionStatus = null,

    /// The date and time the experiment definition was last updated, in ISO 8601
    /// format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .configuration_profile_id = "ConfigurationProfileId",
        .created_at = "CreatedAt",
        .environment_id = "EnvironmentId",
        .flag_key = "FlagKey",
        .hypothesis = "Hypothesis",
        .id = "Id",
        .name = "Name",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
