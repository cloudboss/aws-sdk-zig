const aws = @import("aws");

const Distribution = @import("distribution.zig").Distribution;

/// Defines how Image Builder distributes the output of an image build. You can
/// configure:
///
/// * The Regions to distribute the image to.
///
/// * The Region-specific settings to apply, such as output AMI names,
/// launch permissions for other Amazon Web Services accounts, and target
/// container
/// repositories.
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

    /// A property that Image Builder doesn't use. You can't set this property
    /// when you create or update a distribution configuration, and it has no
    /// effect on distribution behavior.
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
