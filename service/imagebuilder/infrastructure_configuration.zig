const aws = @import("aws");

const InstanceMetadataOptions = @import("instance_metadata_options.zig").InstanceMetadataOptions;
const Logging = @import("logging.zig").Logging;
const Placement = @import("placement.zig").Placement;

/// Details of the infrastructure configuration.
pub const InfrastructureConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the infrastructure configuration.
    arn: ?[]const u8,

    /// The date on which the infrastructure configuration was created.
    date_created: ?[]const u8,

    /// The date on which the infrastructure configuration was last updated.
    date_updated: ?[]const u8,

    /// The description of the infrastructure configuration.
    description: ?[]const u8,

    /// The instance metadata option settings for the infrastructure configuration.
    instance_metadata_options: ?InstanceMetadataOptions,

    /// The instance profile of the infrastructure configuration.
    instance_profile_name: ?[]const u8,

    /// The instance types of the infrastructure configuration.
    instance_types: ?[]const []const u8,

    /// The Amazon EC2 key pair of the infrastructure configuration.
    key_pair: ?[]const u8,

    /// The logging configuration of the infrastructure configuration.
    logging: ?Logging,

    /// The name of the infrastructure configuration.
    name: ?[]const u8,

    /// The instance placement settings that define where the instances that are
    /// launched
    /// from your image will run.
    placement: ?Placement,

    /// The tags attached to the resource created by Image Builder.
    resource_tags: ?[]const aws.map.StringMapEntry,

    /// The security group IDs of the infrastructure configuration.
    security_group_ids: ?[]const []const u8,

    /// The Amazon Resource Name (ARN) for the SNS topic to which we send image
    /// build event
    /// notifications.
    ///
    /// EC2 Image Builder is unable to send notifications to SNS topics that are
    /// encrypted using keys
    /// from other accounts. The key that is used to encrypt the SNS topic must
    /// reside in the
    /// account that the Image Builder service runs under.
    sns_topic_arn: ?[]const u8,

    /// The subnet ID of the infrastructure configuration.
    subnet_id: ?[]const u8,

    /// The tags of the infrastructure configuration.
    tags: ?[]const aws.map.StringMapEntry,

    /// The terminate instance on failure configuration of the infrastructure
    /// configuration.
    terminate_instance_on_failure: ?bool,

    pub const json_field_names = .{
        .arn = "arn",
        .date_created = "dateCreated",
        .date_updated = "dateUpdated",
        .description = "description",
        .instance_metadata_options = "instanceMetadataOptions",
        .instance_profile_name = "instanceProfileName",
        .instance_types = "instanceTypes",
        .key_pair = "keyPair",
        .logging = "logging",
        .name = "name",
        .placement = "placement",
        .resource_tags = "resourceTags",
        .security_group_ids = "securityGroupIds",
        .sns_topic_arn = "snsTopicArn",
        .subnet_id = "subnetId",
        .tags = "tags",
        .terminate_instance_on_failure = "terminateInstanceOnFailure",
    };
};
