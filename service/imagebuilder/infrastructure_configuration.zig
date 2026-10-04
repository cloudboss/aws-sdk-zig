const aws = @import("aws");

const InstanceMetadataOptions = @import("instance_metadata_options.zig").InstanceMetadataOptions;
const Logging = @import("logging.zig").Logging;
const Placement = @import("placement.zig").Placement;

/// Details of the infrastructure configuration.
pub const InfrastructureConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the infrastructure configuration.
    arn: ?[]const u8 = null,

    /// The date on which the infrastructure configuration was created.
    date_created: ?[]const u8 = null,

    /// The date on which the infrastructure configuration was last updated.
    date_updated: ?[]const u8 = null,

    /// The description of the infrastructure configuration.
    description: ?[]const u8 = null,

    /// The instance metadata option settings for the infrastructure configuration.
    instance_metadata_options: ?InstanceMetadataOptions = null,

    /// The instance profile of the infrastructure configuration.
    instance_profile_name: ?[]const u8 = null,

    /// The instance types of the infrastructure configuration.
    instance_types: ?[]const []const u8 = null,

    /// The Amazon EC2 key pair of the infrastructure configuration.
    key_pair: ?[]const u8 = null,

    /// The logging configuration of the infrastructure configuration. When you
    /// configure S3 logs, Image Builder writes logs from the build and test process
    /// to the
    /// specified bucket under the key prefix.
    logging: ?Logging = null,

    /// The name of the infrastructure configuration.
    name: ?[]const u8 = null,

    /// The instance placement settings that define where the build and test
    /// instances that Image Builder launches during image creation run. These
    /// settings
    /// don't affect instances that you launch from the output image.
    placement: ?Placement = null,

    /// The metadata tags assigned to the Amazon EC2 build and test instances that
    /// Image Builder
    /// launches during image creation.
    resource_tags: ?[]const aws.map.StringMapEntry = null,

    /// The security group IDs of the infrastructure configuration.
    security_group_ids: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the SNS topic to which Image Builder
    /// sends image build event notifications. Specify a standard topic. Image
    /// Builder doesn't support FIFO
    /// topics.
    ///
    /// EC2 Image Builder can't send notifications to SNS topics that are encrypted
    /// using keys
    /// from other accounts. If your SNS topic is encrypted, the key must be owned
    /// by the
    /// same account that owns your Image Builder resources.
    sns_topic_arn: ?[]const u8 = null,

    /// The subnet ID of the infrastructure configuration.
    subnet_id: ?[]const u8 = null,

    /// The tags of the infrastructure configuration.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Indicates whether Image Builder terminates the build and test instances when
    /// the image
    /// build fails. When `false`, Image Builder retains the instance so that you
    /// can debug it.
    terminate_instance_on_failure: ?bool = null,

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
