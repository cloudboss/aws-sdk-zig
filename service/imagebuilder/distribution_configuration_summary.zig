const aws = @import("aws");

/// A high-level overview of a distribution configuration.
pub const DistributionConfigurationSummary = struct {
    /// The Amazon Resource Name (ARN) of the distribution configuration.
    arn: ?[]const u8 = null,

    /// The date on which the distribution configuration was created.
    date_created: ?[]const u8 = null,

    /// The date on which the distribution configuration was updated.
    date_updated: ?[]const u8 = null,

    /// The description of the distribution configuration.
    description: ?[]const u8 = null,

    /// The name of the distribution configuration.
    name: ?[]const u8 = null,

    /// A list of Regions where the container image is distributed to.
    regions: ?[]const []const u8 = null,

    /// The tags associated with the distribution configuration.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .date_created = "dateCreated",
        .date_updated = "dateUpdated",
        .description = "description",
        .name = "name",
        .regions = "regions",
        .tags = "tags",
    };
};
