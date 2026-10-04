const Treatment = @import("treatment.zig").Treatment;

/// A snapshot of the experiment definition captured at the time an experiment
/// run was started. This preserves the configuration that was active during the
/// run.
pub const ExperimentDefinitionSnapshot = struct {
    /// The application ID at the time the run was started.
    application_id: ?[]const u8 = null,

    /// The audience description at the time the run was started.
    audience_description: ?[]const u8 = null,

    /// The audience rule at the time the run was started.
    audience_rule: ?[]const u8 = null,

    /// The configuration profile ID at the time the run was started.
    configuration_profile_id: ?[]const u8 = null,

    /// The control treatment at the time the run was started.
    control: ?Treatment = null,

    /// The environment ID at the time the run was started.
    environment_id: ?[]const u8 = null,

    /// The feature flag key at the time the run was started.
    flag_key: ?[]const u8 = null,

    /// The hypothesis at the time the run was started.
    hypothesis: ?[]const u8 = null,

    /// The experiment definition ID.
    id: ?[]const u8 = null,

    /// The launch criteria at the time the run was started.
    launch_criteria: ?[]const u8 = null,

    /// The name of the experiment definition at the time the run was started.
    name: ?[]const u8 = null,

    /// The treatments at the time the run was started.
    treatments: ?[]const Treatment = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .audience_description = "AudienceDescription",
        .audience_rule = "AudienceRule",
        .configuration_profile_id = "ConfigurationProfileId",
        .control = "Control",
        .environment_id = "EnvironmentId",
        .flag_key = "FlagKey",
        .hypothesis = "Hypothesis",
        .id = "Id",
        .launch_criteria = "LaunchCriteria",
        .name = "Name",
        .treatments = "Treatments",
    };
};
