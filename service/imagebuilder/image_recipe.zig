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
    /// instances. You can define settings and add scripts to run when Image Builder
    /// launches
    /// your build instance.
    additional_instance_configuration: ?AdditionalInstanceConfiguration = null,

    /// Tags that are applied to the AMI that Image Builder creates during the Build
    /// phase
    /// prior to image distribution.
    ami_tags: ?[]const aws.map.StringMapEntry = null,

    /// The AMI watermark names attached to the output AMI from this recipe.
    /// AMI watermarks are lineage markers that automatically propagate to
    /// derivative AMIs when the source AMI is copied or distributed.
    ami_watermarks: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the image recipe.
    arn: ?[]const u8 = null,

    /// The block device mappings to apply when creating images from this recipe.
    block_device_mappings: ?[]const InstanceBlockDeviceMapping = null,

    /// The components that are included in the image recipe. A recipe can contain a
    /// maximum of 20 build and test components
    /// in any combination, by default. This maximum is an adjustable quota. For
    /// more information, see
    /// [EC2 Image Builder endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/imagebuilder.html)
    /// in the *Amazon Web Services General Reference*.
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

    /// The output image type. For an image recipe, this is always AMI. Container
    /// images are built from container recipes, a separate resource. This field
    /// isn't currently returned in responses.
    type: ?ImageType = null,

    /// The version of the image recipe.
    version: ?[]const u8 = null,

    /// The working directory used during build and test workflows. If you
    /// don't specify a working directory, Image Builder uses `/tmp` for
    /// Linux and macOS build instances, and `C:/` for Windows build
    /// instances.
    working_directory: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_instance_configuration = "additionalInstanceConfiguration",
        .ami_tags = "amiTags",
        .ami_watermarks = "amiWatermarks",
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
        .type = "type",
        .version = "version",
        .working_directory = "workingDirectory",
    };
};
