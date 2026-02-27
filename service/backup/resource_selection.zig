/// This contains metadata about resource selection for tiering configurations.
///
/// You can specify up to 5 different resource selections per tiering
/// configuration.
/// Data moved to lower-cost tier remains there until deletion (one-way
/// transition).
pub const ResourceSelection = struct {
    /// An array of strings that either contains ARNs of the associated resources
    /// or contains a wildcard `*` to specify all resources.
    /// You can specify up to 100 specific resources per tiering configuration.
    resources: []const []const u8,

    /// The type of Amazon Web Services resource; for example, `S3` for Amazon S3.
    /// For tiering configurations, this is currently limited to `S3`.
    resource_type: []const u8,

    /// The number of days after creation within a backup vault that an object can
    /// transition to the low cost warm storage tier.
    /// Must be a positive integer between 60 and 36500 days.
    tiering_down_settings_in_days: i32,

    pub const json_field_names = .{
        .resources = "Resources",
        .resource_type = "ResourceType",
        .tiering_down_settings_in_days = "TieringDownSettingsInDays",
    };
};
