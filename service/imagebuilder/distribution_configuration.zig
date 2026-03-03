const aws = @import("aws");

const Distribution = @import("distribution.zig").Distribution;

/// A distribution configuration.
pub const DistributionConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the distribution configuration.
    arn: ?[]const u8 = null,

    /// The date on which this distribution configuration was created.
    date_created: ?[]const u8 = null,

    /// The date on which this distribution configuration was last updated.
    date_updated: ?[]const u8 = null,

    /// The description of the distribution configuration.
    description: ?[]const u8 = null,

    /// The distribution objects that apply Region-specific settings for the
    /// deployment of
    /// the image to targeted Regions.
    distributions: ?[]const Distribution = null,

    /// The name of the distribution configuration.
    name: ?[]const u8 = null,

    /// The tags of the distribution configuration.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The maximum duration in minutes for this distribution configuration.
    timeout_minutes: i32,

    pub const json_field_names = .{
        .arn = "arn",
        .date_created = "dateCreated",
        .date_updated = "dateUpdated",
        .description = "description",
        .distributions = "distributions",
        .name = "name",
        .tags = "tags",
        .timeout_minutes = "timeoutMinutes",
    };
};
