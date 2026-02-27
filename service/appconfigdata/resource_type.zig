pub const ResourceType = enum {
    /// Resource type value for the Application resource.
    application,
    /// Resource type value for the ConfigurationProfile resource.
    configuration_profile,
    /// Resource type value for the Deployment resource.
    deployment,
    /// Resource type value for the Environment resource.
    environment,
    /// Resource type value for the Configuration resource.
    configuration,

    pub const json_field_names = .{
        .application = "APPLICATION",
        .configuration_profile = "CONFIGURATION_PROFILE",
        .deployment = "DEPLOYMENT",
        .environment = "ENVIRONMENT",
        .configuration = "CONFIGURATION",
    };
};
