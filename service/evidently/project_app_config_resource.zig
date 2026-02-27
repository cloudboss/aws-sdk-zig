/// This is a structure that defines the configuration of how your application
/// integrates with AppConfig to run client-side evaluation.
pub const ProjectAppConfigResource = struct {
    /// The ID of the AppConfig application to use for client-side evaluation.
    application_id: []const u8,

    /// The ID of the AppConfig profile to use for client-side evaluation.
    configuration_profile_id: []const u8,

    /// The ID of the AppConfig environment to use for client-side evaluation. This
    /// must be an environment that is within the application that you specify for
    /// `applicationId`.
    environment_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .configuration_profile_id = "configurationProfileId",
        .environment_id = "environmentId",
    };
};
