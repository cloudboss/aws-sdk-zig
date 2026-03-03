const aws = @import("aws");

const Placement = @import("placement.zig").Placement;

/// The infrastructure used when building Amazon EC2 AMIs.
pub const InfrastructureConfigurationSummary = struct {
    /// The Amazon Resource Name (ARN) of the infrastructure configuration.
    arn: ?[]const u8 = null,

    /// The date on which the infrastructure configuration was created.
    date_created: ?[]const u8 = null,

    /// The date on which the infrastructure configuration was last updated.
    date_updated: ?[]const u8 = null,

    /// The description of the infrastructure configuration.
    description: ?[]const u8 = null,

    /// The instance profile of the infrastructure configuration.
    instance_profile_name: ?[]const u8 = null,

    /// The instance types of the infrastructure configuration.
    instance_types: ?[]const []const u8 = null,

    /// The name of the infrastructure configuration.
    name: ?[]const u8 = null,

    /// The instance placement settings that define where the instances that are
    /// launched
    /// from your image will run.
    placement: ?Placement = null,

    /// The tags attached to the image created by Image Builder.
    resource_tags: ?[]const aws.map.StringMapEntry = null,

    /// The tags of the infrastructure configuration.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .date_created = "dateCreated",
        .date_updated = "dateUpdated",
        .description = "description",
        .instance_profile_name = "instanceProfileName",
        .instance_types = "instanceTypes",
        .name = "name",
        .placement = "placement",
        .resource_tags = "resourceTags",
        .tags = "tags",
    };
};
