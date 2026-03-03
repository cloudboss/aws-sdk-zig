const aws = @import("aws");

const AdditionalInstanceConfiguration = @import("additional_instance_configuration.zig").AdditionalInstanceConfiguration;
const InstanceBlockDeviceMapping = @import("instance_block_device_mapping.zig").InstanceBlockDeviceMapping;
const ComponentConfiguration = @import("component_configuration.zig").ComponentConfiguration;
const Platform = @import("platform.zig").Platform;
const ImageType = @import("image_type.zig").ImageType;

/// An image recipe.
pub const ImageRecipe = struct {
    /// Before you create a new AMI, Image Builder launches temporary Amazon EC2
    /// instances to build and test
    /// your image configuration. Instance configuration adds a layer of control
    /// over those
    /// instances. You can define settings and add scripts to run when an instance
    /// is launched
    /// from your AMI.
    additional_instance_configuration: ?AdditionalInstanceConfiguration = null,

    /// Tags that are applied to the AMI that Image Builder creates during the Build
    /// phase
    /// prior to image distribution.
    ami_tags: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the image recipe.
    arn: ?[]const u8 = null,

    /// The block device mappings to apply when creating images from this recipe.
    block_device_mappings: ?[]const InstanceBlockDeviceMapping = null,

    /// The components that are included in the image recipe. Recipes require a
    /// minimum of one build component, and can
    /// have a maximum of 20 build and test components in any combination.
    components: ?[]const ComponentConfiguration = null,

    /// The date on which this image recipe was created.
    date_created: ?[]const u8 = null,

    /// The description of the image recipe.
    description: ?[]const u8 = null,

    /// The name of the image recipe.
    name: ?[]const u8 = null,

    /// The owner of the image recipe.
    owner: ?[]const u8 = null,

    /// The base image for customizations specified in the image recipe. You can
    /// specify the
    /// parent image using one of the following options:
    ///
    /// * AMI ID
    ///
    /// * Image Builder image Amazon Resource Name (ARN)
    ///
    /// * Amazon Web Services Systems Manager (SSM) Parameter Store Parameter,
    ///   prefixed by `ssm:`,
    /// followed by the parameter name or ARN.
    ///
    /// * Amazon Web Services Marketplace product ID
    parent_image: ?[]const u8 = null,

    /// The platform of the image recipe.
    platform: ?Platform = null,

    /// The tags of the image recipe.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Specifies which type of image is created by the recipe - an AMI or a
    /// container
    /// image.
    @"type": ?ImageType = null,

    /// The version of the image recipe.
    version: ?[]const u8 = null,

    /// The working directory to be used during build and test workflows.
    working_directory: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_instance_configuration = "additionalInstanceConfiguration",
        .ami_tags = "amiTags",
        .arn = "arn",
        .block_device_mappings = "blockDeviceMappings",
        .components = "components",
        .date_created = "dateCreated",
        .description = "description",
        .name = "name",
        .owner = "owner",
        .parent_image = "parentImage",
        .platform = "platform",
        .tags = "tags",
        .@"type" = "type",
        .version = "version",
        .working_directory = "workingDirectory",
    };
};
