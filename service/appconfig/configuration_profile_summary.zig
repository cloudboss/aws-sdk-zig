const ValidatorType = @import("validator_type.zig").ValidatorType;

/// A summary of a configuration profile.
pub const ConfigurationProfileSummary = struct {
    /// The application ID.
    application_id: ?[]const u8 = null,

    /// The ID of the configuration profile.
    id: ?[]const u8 = null,

    /// The URI location of the configuration.
    location_uri: ?[]const u8 = null,

    /// The name of the configuration profile.
    name: ?[]const u8 = null,

    /// The type of configurations contained in the profile. AppConfig supports
    /// `feature flags` and `freeform` configurations. We recommend you
    /// create feature flag configurations to enable or disable new features and
    /// freeform
    /// configurations to distribute configurations to an application. When calling
    /// this API, enter
    /// one of the following values for `Type`:
    ///
    /// `AWS.AppConfig.FeatureFlags`
    ///
    /// `AWS.Freeform`
    @"type": ?[]const u8 = null,

    /// The types of validators in the configuration profile.
    validator_types: ?[]const ValidatorType = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .id = "Id",
        .location_uri = "LocationUri",
        .name = "Name",
        .@"type" = "Type",
        .validator_types = "ValidatorTypes",
    };
};
